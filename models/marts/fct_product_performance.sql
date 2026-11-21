-- TODO (Camila): one row per product.
-- Columns: product_id, product_name, category, units_sold, revenue, gross_margin,
--          revenue_rank_in_category (RANK() OVER (PARTITION BY category ORDER BY revenue DESC)).
select 1 as placeholder
