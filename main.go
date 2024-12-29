package main

import (
    "net/http"

    "github.com/gin-gonic/gin"
)


func main() {
    router := gin.Default()
    router.GET("/divisions", getDivisions)
	router.GET("/divisions/:division/districts", getDistrictsInDivision)
	router.GET("/divisions/:division/districts/:district/towns", getTownsInDistrict)
    router.Run("localhost:8080")
}
type Division struct {
    Name string `json:"name"`
}

func getDivisions(c *gin.Context) {
    divisions := []Division{
        {Name: "Northern Region"},
        {Name: "Central Region"},
        {Name: "Southern Region"},
    }
    c.IndentedJSON(http.StatusOK, divisions)
}
func getDistrictsInDivision(c *gin.Context) {}
func getTownsInDistrict(c *gin.Context) {}