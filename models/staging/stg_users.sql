-- One row per customer. Personal fields (name, email, address) are left out on purpose.
select
    id as user_id,
    age,
    gender,
    country,
    traffic_source,
    created_at as signup_at
from {{ source('thelook', 'users') }}
