-- File: 02_intermediate.sql
-- Goal: Practice GROUP BY, filtering, logic functions (CASE/COALESCE), HAVING, OFFSET

-- 🔹 Query 1: Total emissions by state
-- Task: For each state, calculate total emissions.
-- Order from highest to lowest.
SELECT
  state,
  ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emission
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY total_emission DESC;

-- 🔹 Query 2: Average emissions per facility by state
-- Task: Return average emissions per facility.
-- Only include states with more than 10 facilities using HAVING.
SELECT
  state,
  ROUND(AVG(ghg_quantity_mtco2e),2) AS average_emissions, 
  COUNT(DISTINCT facility_name) AS facility_count
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
HAVING facility_count > 10
ORDER BY average_emissions DESC;

-- 🔹 Query 3: Top 10 parent companies by emissions
-- Task: Find the 10 parent companies with the highest total emissions.
-- Use LIMIT and OFFSET to also get the "next 10" if you want.
SELECT
  DISTINCT parent_company,
  ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emissions
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY total_emissions DESC
LIMIT 10;

-- 🔹 Query 4: Emissions by industry type (SUBPARTS)
-- Task: Group emissions by subpart.
SELECT
  subpart,
  ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emissions
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`,
UNNEST(SPLIT(subparts, ',')) AS subpart
GROUP BY 1
ORDER BY total_emissions DESC;

-- 🔹 Query 5: Facilities with above-average emissions
-- Task: Calculate national average.
-- Return facilities above this using a subquery or CTE.
WITH avg_emissions AS(
  SELECT
    ROUND(AVG(ghg_quantity_mtco2e),2) AS total_avg_emission
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
),

facility_avg_emissions AS (
  SELECT
    DISTINCT facility_name,
    ROUND(AVG(ghg_quantity_mtco2e),2) AS facility_avg_emission
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
  GROUP BY 1
)

SELECT
  facility_name,
  facility_avg_emission
FROM facility_avg_emissions, avg_emissions
WHERE facility_avg_emission > total_avg_emission
ORDER BY facility_avg_emission DESC;

-- 🔹 Query 6: Emissions by ZIP code (Top 10)
-- Use OFFSET 5 to return ZIPs ranked 6–10.
SELECT
  zip_code,
  ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emissions
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY total_emissions DESC
LIMIT 10
OFFSET 5;

-- 🔹 Query 7: Count of facilities per state
-- Task: GROUP BY state and count rows.
-- Use HAVING to filter for states with at least 5 facilities.
SELECT
  state,
  COUNT(DISTINCT facility_name) AS count_facilities
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
HAVING count_facilities >= 5
ORDER BY count_facilities DESC;

-- 🔹 Query 8: Classify states by emissions level
-- Task: Use CASE to label each state as:
-- 'Low' < 500k, 'Medium' 500k–2M, 'High' > 2M
-- Return a count of states per tier.
SELECT
  state,
  COUNT(DISTINCT facility_name) AS count_facilities
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
HAVING count_facilities >= 5
ORDER BY count_facilities DESC;

-- 🔹 Query 9: Least Emitting Facilities
-- Task: Identify the 10 facilities that reported the lowest non-zero GHG emissions.
-- Focus on facilities that are active (emitted something), but with very low impact.
SELECT
  DISTINCT facility_name,
  ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emissions
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY 2
LIMIT 10;

-- 🔹 Query 10: Lowest Average Emissions per Facility by State
-- Task: Find the 5 states with the lowest average GHG emissions per facility.
-- Only include states with at least 5 facilities to avoid outliers.
-- Order by average emissions ascending.
SELECT
  state,
  ROUND(AVG(ghg_quantity_mtco2e),2) AS avg_emissions,
  COUNT(DISTINCT facility_name) AS count_facilities
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
GROUP BY 1
ORDER BY 2
LIMIT 5;
