-- staging model for payments
-- source: jaffle_shop.raw.raw_payments
-- purpose: rename and clean raw payment data for downstream use

with source as (
    select * from {{source ('jaffle_shop', 'raw_payments')}}
),

renamed as (
    select 
    id as payment_id,
    order_id,
    payment_method,
    amount/100 as amount
from source
)

select * from renamed