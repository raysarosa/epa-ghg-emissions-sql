-- File: 03_advanced.sql
-- Goal: Practice advanced SQL techniques using BigQuery:
-- Window functions, nested subqueries, comparative logic, time-aware analysis

-- 🔹 Query 1: Top emitting facility per state
-- Task: For each state, find the facility with the highest reported GHG emissions.
-- Use ROW_NUMBER or RANK to return only the top one per state.
WITH highest_ghg_emission AS(
  SELECT
    facility_name,
    ghg_quantity_mtco2e,
    state,
    ROW_NUMBER() OVER(PARTITION BY state ORDER BY ghg_quantity_mtco2e DESC) AS rn
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
)

SELECT
  facility_name,
  ghg_quantity_mtco2e,
  state
FROM highest_ghg_emission
WHERE rn = 1
ORDER BY 2 DESC;

-- 🔹 Query 2: Lowest emitting facility per state
-- Task: For each state, find the facility with the lowest reported GHG emissions (greater than 0).
-- Use ROW_NUMBER to return only the top one per state based on ascending emissions.
WITH lowest_ghg_emission AS(
  SELECT
    facility_name,
    ghg_quantity_mtco2e,
    state,
    ROW_NUMBER() OVER(PARTITION BY state ORDER BY ghg_quantity_mtco2e ASC) AS rn
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
)

SELECT
  facility_name,
  ghg_quantity_mtco2e,
  state
FROM lowest_ghg_emission
WHERE rn = 1
ORDER BY 2 ASC;

-- 🔹 Query 3: Percentile ranking of facilities
-- Task: Rank all facilities by their emissions and assign a percentile (0–100).
-- Use NTILE or PERCENT_RANK to classify them.
SELECT
  facility_name,
  ghg_quantity_mtco2e,
  ROUND(PERCENT_RANK() OVER(ORDER BY ghg_quantity_mtco2e),2) AS percentile_rank
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`;


-- 🔹 Query 4: Emissions share by parent company
-- Task: Calculate each parent company’s share (%) of total emissions.
-- Return parent company, total emissions, and % of national total.
WITH total_emissions_pc AS(
  SELECT
    parent_company,
    ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emission_pc
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
  GROUP BY 1
  ORDER BY 2 DESC
),

total_emissions AS(
  SELECT
    SUM(ghg_quantity_mtco2e) AS total_emission
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
)

SELECT
  parent_company,
  total_emission_pc,
  ROUND(((total_emission_pc / total_emission) * 100),2) AS share
FROM total_emissions_pc, total_emissions
ORDER BY 2 DESC;

-- 🔹 Query 5: State vs National Comparison
-- Task: For each state, calculate its total emissions as a % of the national total.
WITH total_emissions AS(
  SELECT
    SUM(ghg_quantity_mtco2e) AS total_emission
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
),

total_emissions_state AS(
  SELECT
    state,
    ROUND(SUM(ghg_quantity_mtco2e),2) AS total_emission_state
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
  GROUP BY 1
  ORDER BY 2 DESC
)

SELECT
  state,
  total_emission_state,
  ROUND(((total_emission_state / total_emission) * 100),2) AS percentage_state
FROM total_emissions_state, total_emissions
ORDER BY 2 DESC;

-- 🔹 Query 6: Industry emissions gap
-- Task: For each subpart (industry), find the difference between its highest and lowest emitting facilities.
WITH lowest_subpart AS(
  SELECT
    subpart,
    MIN(ghg_quantity_mtco2e) AS lowest_ghg
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`,
  UNNEST(SPLIT(subparts, ',')) AS subpart
  GROUP BY 1
  ORDER BY 1
),

highest_subpart AS(
  SELECT
    subpart,
    MAX(ghg_quantity_mtco2e) AS highest_ghg
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`,
  UNNEST(SPLIT(subparts, ',')) AS subpart
  GROUP BY 1
  ORDER BY 1
)

SELECT
  h.subpart,
  lowest_ghg,
  highest_ghg,
  highest_ghg - lowest_ghg AS difference_ghg
FROM lowest_subpart l
JOIN highest_subpart h ON l.subpart = h.subpart
ORDER BY 4 DESC;


-- 🔸 Bonus Challenge:
-- Task: Label each facility as 'Above Average', 'Average', or 'Below Average' based on national average.
-- Use CASE and a CTE to structure the logic.
WITH avg_emissions AS(
  SELECT
    AVG(ghg_quantity_mtco2e) AS avg_facility_emission
  FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`
)

SELECT
  facility_name,
  ghg_quantity_mtco2e,
  CASE
    WHEN ghg_quantity_mtco2e > avg_facility_emission THEN "Above Average"
    WHEN ghg_quantity_mtco2e = avg_facility_emission THEN "Average"
    WHEN ghg_quantity_mtco2e < avg_facility_emission THEN "Below Average"
  END AS avg
FROM `sql-practice-with-bigquery.epa_emissions.epa_ghg_2023`, avg_emissions
ORDER BY 2;
