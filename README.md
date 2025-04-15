# 🌎 EPA Greenhouse Gas Emissions – SQL Analysis with BigQuery

This project explores and analyzes facility-level greenhouse gas (GHG) emissions data from the U.S. Environmental Protection Agency (EPA), using SQL and Google BigQuery. It aims to uncover key environmental insights through clean, efficient querying.

---

## 📊 Project Goals

- Practice **SQL querying** from basic to advanced level
- Work with **real-world environmental data**
- Analyze emissions by **state**, **facility**, **ZIP code**, **parent company**, and **industry**
- Identify both **top emitters** and **low-emission performers**
- Apply **window functions**, **subqueries**, **categorization**, and **aggregations**
- Structure queries for clarity, logic, and scalability

---

## 🗃️ Dataset

- **Source**: [EPA FLIGHT (Facility Level Information on Greenhouse Gases Tool)](https://ghgdata.epa.gov/ghgp/main.do)
- **File**: 2023 GHG direct emitters (uploaded in `.parquet` format)
- **Columns** include: facility name, GHG emissions (CO₂e), location, parent company, subparts (industry), etc.

See [`Datasets/README.md`](./Datasets/README.md) for details on the data structure and license.

---

## 📁 Project Structure

```bash
epa-ghg-emissions-sql/
├── Queries/
│   ├── 01_basic.sql
│   └── 02_intermediate.sql
│   └── 03_advanced.sql
├── Datasets/
│   └── README.md
└── README.md
```

## 📄 SQL Query Levels

### 🟩 `01_basic.sql`
Applies core SQL operations:
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- Filtering and sorting emissions
- Simple thresholds and top emitters
- Handling missing data

### 🟨 `02_intermediate.sql`
Applies intermediate SQL techniques:
- Aggregation with `GROUP BY`, `SUM`, `AVG`, `COUNT`
- Filtering with `HAVING`
- Logical operations with `CASE` and `COALESCE`
- Basic use of `UNNEST`, `OFFSET`, and subqueries
- Focus on both high-impact sources and low-emission performers

### 🟦 `03_advanced.sql`
Explores advanced SQL analytics:
- `ROW_NUMBER`, `PERCENT_RANK`, and window functions
- Emission comparisons by state and industry
- Subpart-level aggregation with joins and unnesting
- Labeling facilities by performance vs national average using `CASE`
- National share analysis by company and state

---

## 🛠 Tools Used
- SQL (BigQuery Standard SQL)
- Google BigQuery (cloud-based querying)
- EPA FLIGHT dataset
- Parquet format for optimized upload & query performance

---

## 🚧 Future Work
- Build dashboards with Power BI or Looker Studio
- Combine multi-year emissions data
- Overlay weather or energy consumption data for contextual analysis
- Deploy insights in interactive reports

---

## 🧑‍💻 Author

**Raysa Rocha**  
📍 Postgrad in Data Science & Analytics – Nova IMS, Lisbon  
🌐 [LinkedIn](https://www.linkedin.com/in/raysarocha) | [GitHub](https://github.com/raysarosa)

---

## 📜 License

- **Data**: © EPA — [Public Domain via FLIGHT](https://ghgdata.epa.gov/ghgp/main.do)  
- **Code**: MIT License
