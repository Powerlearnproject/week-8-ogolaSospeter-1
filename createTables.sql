CREATE DATABASE IF NOT EXISTS HealthDB;

-- Create GeographicAreas table
CREATE TABLE GeographicAreas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    geographic_code VARCHAR(50),
    geographic_area VARCHAR(100),
    country_code VARCHAR(10),
    country VARCHAR(100)
);

-- Create PopulationSubgroups table
CREATE TABLE PopulationSubgroups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    population_subgroup VARCHAR(100),
    subpop_code VARCHAR(50)
);

-- Create HIVData table
CREATE TABLE HIVData (
    record_id INT PRIMARY KEY,
    data_type VARCHAR(50),
    age_category_code VARCHAR(10),
    geographic_area_id INT,
    reference_date DATE,
    virus_type VARCHAR(50),
    source_id VARCHAR(50),
    sequence VARCHAR(50),
    age INT,
    sex VARCHAR(10),
    num_of_deaths INT,
    num_cases INT,
    prevalence_rate DECIMAL(5, 2),
    sample_size INT,
    incidence_rate DECIMAL(5, 2),
    comments TEXT,
    specimen_type VARCHAR(50),
    test_type VARCHAR(50),
    quality VARCHAR(50),
    site_name VARCHAR(100),
    author VARCHAR(100),
    year INT,
    title VARCHAR(255),
    publication_information TEXT,
    FOREIGN KEY (geographic_area_id) REFERENCES GeographicAreas(id)
);
