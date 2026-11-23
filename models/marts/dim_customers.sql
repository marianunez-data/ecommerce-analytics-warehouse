-- One row per customer: lifetime value and RFM segmentation.

with orders as (
    select order_id, user_id, date(created_at) as order_date
    from {{ ref('stg_orders') }}
    where order_status not in ('Cancelled', 'Returned')
),

items as (
    select user_id, sale_price
    from {{ ref('stg_order_items') }}
    where item_status not in ('Cancelled', 'Returned')
),

customer_orders as (
    select
        user_id,
        min(order_date)          as first_order_date,
        max(order_date)          as last_order_date,
        count(distinct order_id) as total_orders
    from orders
    group by user_id
),

customer_revenue as (
    select user_id, sum(sale_price) as lifetime_value
    from items
    group by user_id
),

base as (
    select
        u.user_id,
        u.country,
        u.traffic_source,
        co.first_order_date,
        co.last_order_date,
        co.total_orders,
        round(coalesce(cr.lifetime_value, 0), 2)               as lifetime_value,
        date_diff(current_date(), co.last_order_date, day)     as recency_days
    from {{ ref('stg_users') }} as u
    inner join customer_orders as co on u.user_id = co.user_id
    left join customer_revenue as cr on u.user_id = cr.user_id
),

scored as (
    select
        *,
        ntile(5) over (order by recency_days desc)  as r_score,
        ntile(5) over (order by total_orders)       as f_score,
        ntile(5) over (order by lifetime_value)     as m_score
    from base
)

select
    *,
    case
        when r_score >= 4 and f_score >= 4 and m_score >= 4 then 'Champions'
        when r_score >= 4 and f_score >= 3                   then 'Loyal'
        when r_score >= 4                                    then 'Recent'
        when r_score <= 2 and m_score >= 4                   then 'At risk (high value)'
        when r_score <= 2                                    then 'Lost'
        else 'Needs attention'
    end as rfm_segment
from scored
