# Build checklist

## Day 1: setup + staging
- [ ] Create a GCP project in the BigQuery sandbox (no card).
- [ ] Open bigquery-public-data > thelook_ecommerce and check column names in each table's Schema tab.
- [ ] Create the public GitHub repo `ecommerce-analytics-warehouse` and push this skeleton.
- [ ] `pip install -r requirements.txt`, copy profiles.yml.example, `gcloud auth application-default login`.
- [ ] `dbt deps` then `dbt build --select staging` until all staging tests pass.

## Day 2: marts
- [ ] fct_monthly_revenue (LAG for MoM growth).
- [ ] fct_cohort_retention.
- [ ] Run `dbt build`; fix failures; note any test that caught a real issue.

## Day 3: marts + CI
- [ ] dim_customers (LTV + RFM with NTILE).
- [ ] fct_product_performance (RANK by category).
- [ ] Custom test passes.
- [ ] GitHub Actions: create a service account (BigQuery Data Editor + BigQuery Job User),
      add secrets GCP_PROJECT_ID and GCP_SA_KEY, open a pull request and see the green check.

## Day 4: dashboard + README
- [ ] Looker Studio dashboard on the marts; save screenshots to docs/images.
- [ ] `dbt docs generate`; save the lineage image to docs/images/lineage.png.
- [ ] Fill every README section with real numbers.
- [ ] Pin the repo on the GitHub profile.
