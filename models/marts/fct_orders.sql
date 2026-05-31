-- fact table for orders
-- grain: one row per order
-- joins: stg_orders + stg_payments

with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

-- aggregate payments to one row per order before joining
payment_totals as (

    select
        order_id,
        sum(amount) as amount,
        -- get the most common payment method per order
        max(payment_method) as payment_method

    from payments
    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        payment_totals.payment_method,
        payment_totals.amount

    from orders
    left join payment_totals
        on orders.order_id = payment_totals.order_id

)

select * from final