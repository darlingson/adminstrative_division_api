-- Create the database if it doesn't exist
CREATE DATABASE malawi_admin_divs;

-- Create tables
CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE districts (
    id SERIAL PRIMARY KEY,
    district_name VARCHAR(100) NOT NULL,
    region_id INTEGER REFERENCES regions(id),
    UNIQUE(district_name, region_id)
);

CREATE TABLE towns (
    id SERIAL PRIMARY KEY,
    town_name VARCHAR(100) NOT NULL,
    district_id INTEGER REFERENCES districts(id),
    UNIQUE(town_name, district_id)
);