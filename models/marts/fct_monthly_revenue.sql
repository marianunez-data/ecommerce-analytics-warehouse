-- TODO (Camila): one row per month.
-- Columns: revenue_month, revenue, orders, customers, avg_order_value,
--          prev_month_revenue (LAG), mom_growth_pct.
-- Rules: count only items with item_status not in ('Cancelled', 'Returned').
-- Techniques: CTEs, DATE_TRUNC, LAG() OVER (ORDER BY revenue_month), SAFE_DIVIDE.
select 1 as placeholder
