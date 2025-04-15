-- File: 01_basic.sql
-- Goal: Practice basic SQL using EPA carbon emissions data

-- 🔹 Query 1: Preview the data
-- Task: Show the first 10 rows from the emissions dataset
SELECT
  facility_name,
  state,
  ghg_quantity_mtco2e
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
LIMIT 10;

-- 🔹 Query 2: Top 10 highest-emitting facilities
-- Task: List the top 10 facilities by total reported GHG emissions
SELECT
  facility_name,
  state,
  ghg_quantity_mtco2e
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
ORDER BY ghg_quantity_mtco2e DESC
LIMIT 10;

-- 🔹 Query 3: Facilities in California with high emissions
-- Task: Find all facilities in CA that emitted more than 500,000 metric tons
SELECT
  facility_name,
  state,
  city_name,
  ghg_quantity_mtco2e
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
WHERE ghg_quantity_mtco2e >= 500000 AND state = "CA"
ORDER BY ghg_quantity_mtco2e DESC;

-- 🔹 Query 4: Emissions by state
-- Task: Count number of facilities per state
SELECT
  state,
  COUNT(DISTINCT facility_name) AS facility_count
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY facility_count DESC;

-- 🔹 Query 5: Emissions over a threshold
-- Task: List facilities with emissions over 1 million metric tons
SELECT
  facility_name,
  ghg_quantity_mtco2e
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
WHERE ghg_quantity_mtco2e >= 1000000
ORDER BY ghg_quantity_mtco2e DESC;


-- 🔸 Bonus Challenge:
-- Task: List facilities with missing ZIP codes or cities
SELECT
  facility_name,
  zip_code,
  city_name
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
WHERE zip_code IS NULL OR city_name IS NULL;
