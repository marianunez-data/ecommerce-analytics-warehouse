-- One row per order.
select
    order_id,
    user_id,
    status as order_status,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from {{ source('thelook', 'orders') }}
