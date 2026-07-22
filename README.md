# Retail Analytics dbt Project
An end-to-end analytics engineering project built with **dbt**, **Snowflake**, and **SQL**, demonstrating staging layers, dimensional modelling, data quality testing, and documentation.

<img width="2422" height="1180" alt="Screenshot 2026-05-31 at 17 19 32" src="https://github.com/user-attachments/assets/db2e8e8b-bf9a-45b1-a420-d5d10ab1f3af" />

---
## Project Overview

This project transforms raw retail transaction data into analytics-ready dimensional models using modern data engineering practices. It simulates a real-world analytics engineering workflow where raw source data is cleaned, tested, and modelled into business-ready tables.

## Tech Stack

- **dbt Cloud** - transformation, testing, and documentation
- **Snowflake** - cloud data warehouse
- **SQL** - all transformation logic
- **GitHub** - version control

## Data Sources

Raw data loaded directly into Snowflake (`jaffle_shop.raw` schema):

| Table | Description | Rows |
|-------|-------------|------|
| `raw_customers` | Customer records | 100 |
| `raw_orders` | Order transactions | 99 |
| `raw_payments` | Payment records | 198 |

## Project Structure

**Staging layer** — `models/staging/`
- `_sources.yml` — source definitions
- `stg_customers.sql` — cleaned customer records
- `stg_orders.sql` — cleaned order records  
- `stg_payments.sql` — amounts converted from cents to GBP

**Mart layer** — `models/marts/`
- `fct_orders.sql` — fact table, one row per order
- `dim_customers.sql` — dimension table with customer order metrics

## Data Lineage
<img width="2422" height="1180" alt="Screenshot 2026-05-31 at 17 19 32" src="https://github.com/user-attachments/assets/11b1ef38-e07a-4836-bc70-fa1f6b96d151" />

## Staging Layer
Cleans and renames raw source data:

- **stg_customers** — renames `id` to `customer_id`
- **stg_orders** — renames `id` to `order_id`, `user_id` to `customer_id`
- **stg_payments** — renames `id` to `payment_id`, converts amounts from cents to GBP

## Mart Layer
Contains business-ready dimensional models:

- **fct_orders** — fact table with one row per order, joining orders and aggregated payments
- **dim_customers** — dimension table with customer attributes and aggregated order metrics including `number_of_orders`, `first_order_date`, `most_recent_order_date`, and `lifetime_value`

## Data Quality Tests
18 tests across all models covering:

- **Uniqueness** — primary keys are unique across all models
- **Not null** — required fields are never null
- **Referential integrity** — foreign keys exist in parent tables
- **Accepted values** — status and payment method fields only contain valid values

All 18 tests passing.

## How to Run

```bash
# Install dependencies
dbt deps

# Run all models
dbt run

# Run data quality tests
dbt test

# Generate documentation
dbt docs generate
```
## Related Projects
- [case-management-analytics-pipeline-power-bi](https://github.com/tessogamba/case-management-analytics-pipeline-power-bi) - Production analytics pipeline built on a live SQL Server case management database with Power Query, dimensional modelling and DAX
- [retail-analytics-tableau](https://github.com/tessogamba/retail-analytics-tableau) - Tableau dashboard created on top of this pipeline
- [financial-analytics-bigquery](https://github.com/tessogamba/financial-analytics-bigquery) - Financial analytics engineering project created with BigQuery and raw SQL
- [financial-analytics-looker](https://github.com/tessogamba/financial-analytics-looker) - Looker Studio dashboard created on top of the BigQuery pipeline
---

*Built by Tess Ogamba · [github.com/tessogamba](https://github.com/tessogamba)*
