-- Customer retention by cohort (month of first purchase).

with orders as (
    select
        user_id,
        date_trunc(date(created_at), month) as order_month
    from {{ ref('stg_orders') }}
    where order_status not in ('Cancelled', 'Returned')
),

first_order as (
    select
        user_id,
        min(order_month) as cohort_month
    from orders
    group by user_id
),

cohort_size as (
    select
        cohort_month,
        count(distinct user_id) as cohort_size
    from first_order
    group by cohort_month
),

activity as (
    select
        f.cohort_month,
        date_diff(o.order_month, f.cohort_month, month) as months_since_first_order,
        count(distinct o.user_id)                         as active_customers
    from orders as o
    inner join first_order as f
        on o.user_id = f.user_id
    group by 1, 2
),

final as (
    select
        a.cohort_month,
        a.months_since_first_order,
        a.active_customers,
        c.cohort_size,
        round(safe_divide(a.active_customers, c.cohort_size) * 100, 2) as retention_pct
    from activity as a
    inner join cohort_size as c
        on a.cohort_month = c.cohort_month
)

select * from final
order by cohort_month, months_since_first_order