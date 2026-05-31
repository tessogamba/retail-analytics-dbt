-- dimension model for customers
-- source: stg_customers, fct_orders
-- grain: one row per customer
-- purpose: customer attributes plus aggregated order metrics for downstream analysis

with customers as (

    -- pull all cleaned customer records from staging
    select * from {{ ref('stg_customers') }}

),

customer_orders as (

    -- pull all orders from the fact table to aggregate per customer
    select * from {{ ref('fct_orders') }}

),

merged as (

    -- left join ensures all customers appear even if they have no orders
    -- customers with no orders will have NULL for order metrics
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.order_id,
        customer_orders.order_date,
        customer_orders.amount
    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

),

final as (

    -- aggregate order metrics per customer
    -- count distinct handles customers with multiple payments per order
    select
        customer_id,
        first_name,
        last_name,
        count(distinct order_id)    as number_of_orders,
        min(order_date)             as first_order_date,
        max(order_date)             as most_recent_order_date,
        sum(amount)                 as lifetime_value
    from merged
    group by customer_id, first_name, last_name

)

select * from final