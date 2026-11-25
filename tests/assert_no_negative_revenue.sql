-- Custom test: returns rows that break the rule; the test passes when it returns 0 rows.
-- Rule: monthly revenue can never be negative.
select *
from {{ ref('fct_monthly_revenue') }}
where revenue < 0
