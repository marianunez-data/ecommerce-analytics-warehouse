-- One row per product: units, revenue, margin and rank within its category.

with items as (
    select product_id, sale_price
    from {{ ref('stg_order_items') }}
    where item_status not in ('Cancelled', 'Returned')
),

sales as (
    select
        product_id,
        count(*)        as units_sold,
        sum(sale_price) as revenue
    from items
    group by product_id
)

select
    p.product_id,
    p.product_name,
    p.brand,
    p.category,
    p.department,
    s.units_sold,
    round(s.revenue, 2)                                                    as revenue,
    round(s.revenue - s.units_sold * p.cost, 2)                            as gross_margin,
    round(safe_divide(s.revenue - s.units_sold * p.cost, s.revenue) * 100, 2) as gross_margin_pct,
    rank() over (partition by p.category order by s.revenue desc)          as revenue_rank_in_category
from {{ ref('stg_products') }} as p
inner join sales as s on p.product_id = s.product_id
