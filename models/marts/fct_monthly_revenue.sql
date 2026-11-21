-- Monthly revenue, orders, customers and month-over-month growth.

with order_items as (
    select
        order_id,
        user_id,
        sale_price,
        date_trunc(date(created_at), month) as revenue_month
    from {{ ref('stg_order_items') }}
    where item_status not in ('Cancelled', 'Returned')
),

monthly as (
    select
        revenue_month,
        sum(sale_price)          as revenue,
        count(distinct order_id) as orders,
        count(distinct user_id)  as customers
    from order_items
    group by revenue_month
),

final as (
    select
        revenue_month,
        round(revenue, 2)                                   as revenue,
        orders,
        customers,
        round(safe_divide(revenue, orders), 2)              as avg_order_value,
        round(lag(revenue) over (order by revenue_month), 2) as prev_month_revenue,
        round(
            safe_divide(
                revenue - lag(revenue) over (order by revenue_month),
                lag(revenue) over (order by revenue_month)
            ) * 100, 2
        )                                                   as mom_growth_pct
    from monthly
)

select * from final
order by revenue_month