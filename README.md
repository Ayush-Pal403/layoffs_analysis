# World Layoffs: SQL Data Cleaning & Exploratory Data Analysis

## Project Overview
This project uses SQL to clean, prepare and explore a dataset of global layoffs. It examines layoff events across companies, industries, locations, funding stages and time periods, with the aim of identifying patterns in the scale and distribution of layoffs.

The workflow is divided into two stages:
1. **Data cleaning and preparation** — creates staging tables, identifies potential duplicate records, standardises selected fields, converts date values and fills some missing industry values where matching records are available.
2. **Exploratory data analysis (EDA)** — analyses layoffs by company, geography, industry, funding stage and time, including annual rankings and cumulative monthly totals.

## Dataset
The raw dataset (`layoffs.csv`) contains **2,361 records** and **9 columns**:

| Column | Description |
|---|---|
| `company` | Company name |
| `location` | Location associated with the layoff record |
| `industry` | Industry classification |
| `total_laid_off` | Number of employees laid off |
| `percentage_laid_off` | Share of the workforce laid off, where available |
| `date` | Date of the layoff event |
| `stage` | Company funding stage |
| `country` | Country |
| `funds_raised_millions` | Funds raised, in millions |

## Tools & SQL Features
- MySQL
- Staging tables
- Common Table Expressions (CTEs)
- Window functions (`ROW_NUMBER()`, `DENSE_RANK()`, `SUM() OVER()`)
- Joins
- Aggregations and filtering
- Date and string functions

## Project Workflow

### 1. Data Cleaning
The cleaning script performs the following preparation and checks:
- Creates a staging table from the raw table to preserve the original data.
- Uses `ROW_NUMBER()` across the dataset's fields to identify potential duplicate records.
- Creates a second staging table with a `row_num` helper column for duplicate inspection.
- Trims leading/trailing whitespace from company names.
- Converts date strings into date values using `STR_TO_DATE()` and modifies the date column to the `DATE` data type.
- Checks distinct country values and records with missing layoff counts and percentages.
- Uses a self-join to populate missing industry values where a matching company/location record has a non-null industry.
- Drops the helper `row_num` column from the final staging table.


### 2. Exploratory Data Analysis
The EDA script explores:
- Maximum layoff count in a single record and the range of reported layoff percentages.
- Companies reporting 100% layoffs, with funding raised used to contextualise these records.
- Companies with the largest single layoff events and the highest cumulative layoffs.
- Layoffs by location and country.
- Layoffs by industry and funding stage.
- Annual layoff totals.
- Top three companies by layoffs for each year using `DENSE_RANK()`.
- Monthly layoff totals and cumulative totals using a window function.

## Analysis Questions
The project investigates questions such as:
1. What is the maximum number of employees laid off in a single record?
2. What are the minimum and maximum reported layoff percentages?
3. Which companies reported 100% layoffs, and how much funding had they raised?
4. Which companies had the largest single layoff events?
5. Which companies recorded the highest cumulative layoffs?
6. Which locations and countries had the highest reported layoffs?
7. How were layoffs distributed across years, industries and funding stages?
8. Which three companies had the highest layoffs in each year?
9. How did layoffs change month by month, and what was the cumulative total over time?

## SQL Techniques Demonstrated
- `CREATE TABLE ... LIKE` and staging-table workflow
- `ROW_NUMBER()` for duplicate identification
- `TRIM()` and `STR_TO_DATE()` for data standardisation
- Self-joins to fill missing industry values from matching records
- `ALTER TABLE` and `MODIFY COLUMN`
- `SUM()`, `MAX()` and `MIN()`
- `GROUP BY`, `ORDER BY`, `WHERE` and `LIMIT`
- CTEs
- `DENSE_RANK()` with `PARTITION BY`
- Cumulative window calculations with `SUM() OVER (ORDER BY ...)`
- `YEAR()` and `SUBSTRING()` for time-based aggregation

## Repository Structure
```text
world-layoffs-sql-project/
├── layoffs.csv
├── Data_Cleaning.sql
├── EDA.sql
└── README.md
```

- `layoffs.csv` — raw dataset.
- `Data_Cleaning.sql` — cleaning and preparation queries.
- `SQL_SCRIPT.sql` — exploratory analysis queries.
- `README.md` — project documentation.

## How to Reproduce
1. Create or select a MySQL database.
2. Import `layoffs.csv` into a table named `layoffs`.
3. Run `Data_Cleaning.sql` to create and prepare the staging tables. Review the script and adjust database/table references if needed for your environment.
4. Run `SQL_SCRIPT.sql` against the prepared staging table(s) to reproduce the exploratory analysis.

## Notes
- The scripts use MySQL syntax.
- The raw dataset is kept separate from the staging tables created during the cleaning workflow.
- The cleaning script performs checks and transformations described above; it does not explicitly delete duplicate rows or rows with both layoff metrics missing.

## Author
Ayush Pal
