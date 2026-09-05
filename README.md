# Retail Analytics Engineering (dbt & Snowflake)
An enterprise-aligned analytics engineering platform using dbt Cloud, Snowflake, and SQL to orchestrate modular data pipelines, programmatic data-quality assertions, and optimised star-schema dimensional models.

---
## Project Overview

This project demonstrates a structured transformation workflow in which raw source data is cleaned, tested and modelled into reliable, business-ready tables for customer, order and revenue analysis.

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

- [case-management-analytics-platform](https://github.com/tessogamba/case-management-analytics-platform) - Production SQL Server-to-Power BI analytics platform with dimensional modelling, DAX and governed data-quality controls
- [retail-analytics-tableau](https://github.com/tessogamba/retail-analytics-tableau) - Tableau dashboard for customer, sales and revenue analysis using these transformed datasets
- [financial-analytics-bigquery](https://github.com/tessogamba/financial-analytics-bigquery) - Financial analytics project using BigQuery and reusable SQL models across 12 public companies and 23 metrics
- [financial-analytics-looker-studio](https://github.com/tessogamba/financial-analytics-looker-studio) - Looker Studio dashboard for exploring financial growth, profitability and risk

---
*Built by Tess Ogamba · [github.com/tessogamba](https://github.com/tessogamba) · [LinkedIn](https://linkedin.com/in/tessogamba)*
