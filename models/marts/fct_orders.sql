-- fact table for orders
-- grain: one row per order
-- joins: stg_orders + stg_payments

with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

final as (

    select
       orders.order_id,
       orders.customer_id,
       orders.order_date,
       orders.status,
       payments.payment_method,
       payments.amount

    from orders
    left join payments on orders.order_id = payments.order_id

)

select * from final