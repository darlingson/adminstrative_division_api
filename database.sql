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

INSERT INTO regions (region_name) VALUES
    ('Northern Region'),
    ('Central Region'),
    ('Southern Region');

-- Insert districts and towns for Northern Region
WITH northern_region AS (SELECT id FROM regions WHERE region_name = 'Northern Region')
INSERT INTO districts (district_name, region_id) VALUES
    ('Chitipa', (SELECT id FROM northern_region)),
    ('Karonga', (SELECT id FROM northern_region)),
    ('Mzimba', (SELECT id FROM northern_region)),
    ('Nkhata Bay', (SELECT id FROM northern_region)),
    ('Nkhotakota', (SELECT id FROM northern_region)),
    ('Rumphi', (SELECT id FROM northern_region));

-- Insert towns for Northern Region districts
WITH district_ids AS (SELECT id, district_name FROM districts)
INSERT INTO towns (town_name, district_id) VALUES
    ('Chitipa Town', (SELECT id FROM district_ids WHERE district_name = 'Chitipa')),
    ('Ivalo', (SELECT id FROM district_ids WHERE district_name = 'Chitipa')),
    ('Kaporo', (SELECT id FROM district_ids WHERE district_name = 'Chitipa')),
    
    ('Karonga Town', (SELECT id FROM district_ids WHERE district_name = 'Karonga')),
    ('Chitimba', (SELECT id FROM district_ids WHERE district_name = 'Karonga')),
    ('Nyungwe', (SELECT id FROM district_ids WHERE district_name = 'Karonga')),
    
    ('Mzimba', (SELECT id FROM district_ids WHERE district_name = 'Mzimba')),
    ('Luwerezi', (SELECT id FROM district_ids WHERE district_name = 'Mzimba')),
    ('Bembeke', (SELECT id FROM district_ids WHERE district_name = 'Mzimba')),
    
    ('Nkhata Bay Town', (SELECT id FROM district_ids WHERE district_name = 'Nkhata Bay')),
    ('Mbowe', (SELECT id FROM district_ids WHERE district_name = 'Nkhata Bay')),
    ('Matemba', (SELECT id FROM district_ids WHERE district_name = 'Nkhata Bay')),
    
    ('Nkhotakota', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    ('Dwangwa', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    ('Lifuwu', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    
    ('Rumphi Town', (SELECT id FROM district_ids WHERE district_name = 'Rumphi')),
    ('Chintheche', (SELECT id FROM district_ids WHERE district_name = 'Rumphi')),
    ('Jumbe', (SELECT id FROM district_ids WHERE district_name = 'Rumphi'));

-- Insert districts and towns for Central Region
WITH central_region AS (SELECT id FROM regions WHERE region_name = 'Central Region')
INSERT INTO districts (district_name, region_id) VALUES
    ('Dowa', (SELECT id FROM central_region)),
    ('Kasungu', (SELECT id FROM central_region)),
    ('Lilongwe', (SELECT id FROM central_region)),
    ('Mchinji', (SELECT id FROM central_region)),
    ('Nkhotakota', (SELECT id FROM central_region)),
    ('Ntcheu', (SELECT id FROM central_region)),
    ('Salima', (SELECT id FROM central_region)),
    ('Viphya', (SELECT id FROM central_region));

-- Insert towns for Central Region districts
WITH district_ids AS (SELECT id, district_name FROM districts WHERE region_id = (SELECT id FROM regions WHERE region_name = 'Central Region'))
INSERT INTO towns (town_name, district_id) VALUES
    ('Dowa', (SELECT id FROM district_ids WHERE district_name = 'Dowa')),
    ('Msundwe', (SELECT id FROM district_ids WHERE district_name = 'Dowa')),
    ('Chilinde', (SELECT id FROM district_ids WHERE district_name = 'Dowa')),
    
    ('Kasungu Town', (SELECT id FROM district_ids WHERE district_name = 'Kasungu')),
    ('Kalulu', (SELECT id FROM district_ids WHERE district_name = 'Kasungu')),
    ('Chisamba', (SELECT id FROM district_ids WHERE district_name = 'Kasungu')),
    
    ('Lilongwe City', (SELECT id FROM district_ids WHERE district_name = 'Lilongwe')),
    ('Mchinji', (SELECT id FROM district_ids WHERE district_name = 'Lilongwe')),
    ('Chilanga', (SELECT id FROM district_ids WHERE district_name = 'Lilongwe')),
    
    ('Mchinji Town', (SELECT id FROM district_ids WHERE district_name = 'Mchinji')),
    ('Kamwendo', (SELECT id FROM district_ids WHERE district_name = 'Mchinji')),
    ('Kaphuka', (SELECT id FROM district_ids WHERE district_name = 'Mchinji')),
    
    ('Nkhotakota', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    ('Chikwawa', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    ('Dwangwa', (SELECT id FROM district_ids WHERE district_name = 'Nkhotakota')),
    
    ('Ntcheu Town', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    ('Makungwa', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    ('Lifuwu', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    
    ('Salima Town', (SELECT id FROM district_ids WHERE district_name = 'Salima')),
    ('Nanjoka', (SELECT id FROM district_ids WHERE district_name = 'Salima')),
    ('Liwonde', (SELECT id FROM district_ids WHERE district_name = 'Salima')),
    
    ('Viphya', (SELECT id FROM district_ids WHERE district_name = 'Viphya')),
    ('Chikangawa', (SELECT id FROM district_ids WHERE district_name = 'Viphya'));

-- Insert districts and towns for Southern Region
WITH southern_region AS (SELECT id FROM regions WHERE region_name = 'Southern Region')
INSERT INTO districts (district_name, region_id) VALUES
    ('Blantyre', (SELECT id FROM southern_region)),
    ('Chikwawa', (SELECT id FROM southern_region)),
    ('Chiradzulu', (SELECT id FROM southern_region)),
    ('Mangochi', (SELECT id FROM southern_region)),
    ('Machinga', (SELECT id FROM southern_region)),
    ('Mulanje', (SELECT id FROM southern_region)),
    ('Nsanje', (SELECT id FROM southern_region)),
    ('Ntcheu', (SELECT id FROM southern_region)),
    ('Phalombe', (SELECT id FROM southern_region)),
    ('Zomba', (SELECT id FROM southern_region));

-- Insert towns for Southern Region districts
WITH district_ids AS (SELECT id, district_name FROM districts WHERE region_id = (SELECT id FROM regions WHERE region_name = 'Southern Region'))
INSERT INTO towns (town_name, district_id) VALUES
    ('Blantyre City', (SELECT id FROM district_ids WHERE district_name = 'Blantyre')),
    ('Limbe', (SELECT id FROM district_ids WHERE district_name = 'Blantyre')),
    ('Machi', (SELECT id FROM district_ids WHERE district_name = 'Blantyre')),
    
    ('Chikwawa Town', (SELECT id FROM district_ids WHERE district_name = 'Chikwawa')),
    ('Kalumba', (SELECT id FROM district_ids WHERE district_name = 'Chikwawa')),
    ('Lundu', (SELECT id FROM district_ids WHERE district_name = 'Chikwawa')),
    
    ('Chiradzulu', (SELECT id FROM district_ids WHERE district_name = 'Chiradzulu')),
    ('Zomba', (SELECT id FROM district_ids WHERE district_name = 'Chiradzulu')),
    ('Liwonde', (SELECT id FROM district_ids WHERE district_name = 'Chiradzulu')),
    
    ('Mangochi Town', (SELECT id FROM district_ids WHERE district_name = 'Mangochi')),
    ('Nkhudzi Bay', (SELECT id FROM district_ids WHERE district_name = 'Mangochi')),
    ('Chingale', (SELECT id FROM district_ids WHERE district_name = 'Mangochi')),
    
    ('Machinga', (SELECT id FROM district_ids WHERE district_name = 'Machinga')),
    ('Mikundi', (SELECT id FROM district_ids WHERE district_name = 'Machinga')),
    ('Chabwera', (SELECT id FROM district_ids WHERE district_name = 'Machinga')),
    
    ('Mulanje', (SELECT id FROM district_ids WHERE district_name = 'Mulanje')),
    ('Chitakale', (SELECT id FROM district_ids WHERE district_name = 'Mulanje')),
    ('Nkhande', (SELECT id FROM district_ids WHERE district_name = 'Mulanje')),
    
    ('Nsanje', (SELECT id FROM district_ids WHERE district_name = 'Nsanje')),
    ('Bangula', (SELECT id FROM district_ids WHERE district_name = 'Nsanje')),
    ('Chikala', (SELECT id FROM district_ids WHERE district_name = 'Nsanje')),
    
    ('Ntcheu Town', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    ('Makungwa', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    ('Lifuwu', (SELECT id FROM district_ids WHERE district_name = 'Ntcheu')),
    
    ('Phalombe', (SELECT id FROM district_ids WHERE district_name = 'Phalombe')),
    ('Chitakale', (SELECT id FROM district_ids WHERE district_name = 'Phalombe')),
    ('Chitawira', (SELECT id FROM district_ids WHERE district_name = 'Phalombe')),
    
    ('Zomba City', (SELECT id FROM district_ids WHERE district_name = 'Zomba')),
    ('Mpona', (SELECT id FROM district_ids WHERE district_name = 'Zomba')),
    ('Naisi', (SELECT id FROM district_ids WHERE district_name = 'Zomba'));