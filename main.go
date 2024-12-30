package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
)

type Town struct {
	Name string `db:"town_name"`
}

type District struct {
	Name  string   `db:"district_name"`
	Towns []string `db:"towns"`
}

type Region struct {
	Name      string     `db:"region_name"`
	Districts []District `db:"districts"`
}

type MalawiData struct {
	Country string   `db:"country"`
	Regions []Region `db:"regions"`
}

func main() {
	db, err := sqlx.Connect("postgres", "user=postgres dbname=malawi_admin_divs sslmode=disable password=root host=localhost")
	if err != nil {
		log.Fatalln(err)
	}
	defer db.Close()

	router := gin.Default()

	router.POST("/insert-data", func(c *gin.Context) {
		var data MalawiData
		if err := c.BindJSON(&data); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		err := insertData(db, data)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": "Data inserted successfully"})
	})
    router.Use(func(c *gin.Context) {
        c.Set("db", db)
        c.Next()
    })
	router.GET("/divisions", getDivisions)
	router.GET("/divisions/:division/districts", getDistrictsInDivision)
	router.GET("/divisions/:division/districts/:district/towns", getTownsInDistrict)

	router.Run("localhost:8080")
}

func insertData(db *sqlx.DB, data MalawiData) error {
	tx, err := db.Beginx()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	for _, region := range data.Regions {
		// Insert region
		var regionID int
		err := tx.QueryRow(
			"INSERT INTO regions (region_name) VALUES ($1) RETURNING id",
			region.Name,
		).Scan(&regionID)
		if err != nil {
			return err
		}

		for _, district := range region.Districts {
			// Insert district
			var districtID int
			err := tx.QueryRow(
				"INSERT INTO districts (district_name, region_id) VALUES ($1, $2) RETURNING id",
				district.Name, regionID,
			).Scan(&districtID)
			if err != nil {
				return err
			}

			// Insert towns
			for _, town := range district.Towns {
				_, err := tx.Exec(
					"INSERT INTO towns (town_name, district_id) VALUES ($1, $2)",
					town, districtID,
				)
				if err != nil {
					return err
				}
			}
		}
	}

	return tx.Commit()
}

func getDivisions(c *gin.Context) {
	db := c.MustGet("db").(*sqlx.DB)
	var regions []Region
	err := db.Select(&regions, "SELECT region_name FROM regions")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, regions)
}

func getDistrictsInDivision(c *gin.Context) {
	db := c.MustGet("db").(*sqlx.DB)
	division := c.Param("division")
	var districts []District
	err := db.Select(&districts,
		`SELECT d.district_name 
		FROM districts d 
		JOIN regions r ON d.region_id = r.id 
		WHERE r.region_name = $1`, division)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, districts)
}

func getTownsInDistrict(c *gin.Context) {
	db := c.MustGet("db").(*sqlx.DB)
	district := c.Param("district")

	var towns []Town
	err := db.Select(&towns,
		`SELECT t.town_name 
		FROM towns t 
		JOIN districts d ON t.district_id = d.id 
		WHERE d.district_name = $1`, district)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, towns)
}
