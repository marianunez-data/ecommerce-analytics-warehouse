-- TODO (Camila): one row per cohort_month x months_since_first_order.
-- Columns: cohort_month, months_since_first_order, active_customers, cohort_size, retention_pct.
-- Steps: first order month per customer (MIN), join back to orders,
--        DATE_DIFF(order_month, cohort_month, MONTH), count distinct customers.
select 1 as placeholder
