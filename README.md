# E-commerce Analytics Warehouse (dbt + BigQuery)

![dbt CI](https://github.com/marianunez-data/ecommerce-analytics-warehouse/actions/workflows/dbt_ci.yml/badge.svg)

## Business question
<!-- 2-3 sentences: what an e-commerce team needs to know about revenue, retention and customer value. -->

## Dataset
BigQuery public dataset `bigquery-public-data.thelook_ecommerce` (fictional store: orders, order items, users, products).

## Architecture
<!-- dbt lineage image: docs/images/lineage.png -->
raw (public dataset) -> staging (views, cleaned and renamed) -> marts (tables for analysis)

| Model | Grain | Purpose |
|---|---|---|
| fct_monthly_revenue | month | Revenue, orders, customers, month-over-month growth |
| fct_cohort_retention | cohort month x months since first order | Retention curves |
| dim_customers | customer | Lifetime value and RFM segments |
| fct_product_performance | product | Revenue, margin and rank in category |

## SQL techniques
<!-- CTEs, window functions (LAG, RANK, NTILE), cohort logic, SAFE_DIVIDE. Explain 2-3 decisions. -->

## Data quality
<!-- dbt tests used and anything they caught (your STAR story). -->

## Key findings
<!-- 3-5 insights with real numbers from your queries. -->

## Dashboard
<!-- Looker Studio link + screenshots in docs/images (sandbox tables expire after 60 days). -->

## How to run
```bash
pip install -r requirements.txt
cp profiles.yml.example ~/.dbt/profiles.yml   # set YOUR_GCP_PROJECT_ID
gcloud auth application-default login
dbt deps
dbt build
```

## Credentials earned while building this project
<!-- HackerRank SQL (Intermediate), Kaggle SQL, dbt Fundamentals, Snowflake Data Warehousing Workshop: add links. -->
