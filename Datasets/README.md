# 📂 Datasets

This folder documents the public datasets used throughout this project.  
All datasets are hosted on Google BigQuery or uploaded manually and used for SQL querying in BigQuery.

---

## 🧑‍💻 Dataset – EPA FLIGHT (Facility-Level GHG Reporting)

- **Dataset Name**: `epa_ghg_2023`
- **Source**: [EPA FLIGHT Tool](https://ghgdata.epa.gov/ghgp/main.do)
- **Description**:  
  This dataset contains greenhouse gas emissions (in metric tons of CO₂ equivalent) reported by U.S. facilities in 2023. Each row represents an individual facility, including emissions data, location, parent company, and subpart (industry) information.

- **Data Format**: Uploaded in `.parquet` format to Google BigQuery  
- **Original Format**: XLS → CSV → Parquet  
- **License**: Public domain (U.S. Government data)

---

## 📌 Notes

- **Subparts**: The `subparts` column may contain multiple industry codes, separated by commas (e.g. `"C,HH,W"`).
- **Units**: Emissions are measured in **metric tons of CO₂e (MTCO₂e)**.
- **Scope**: Includes all direct emitters reported to the EPA in 2023.

---

## 🧪 Example Usage in SQL

```sql
SELECT
  facility_name,
  ghg_quantity_mtco2e
FROM `your_project.epa_emissions.epa_ghg_2023`
LIMIT 10;
