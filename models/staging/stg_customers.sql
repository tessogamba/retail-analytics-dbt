-- staging model for customers
-- source: jaffle_shop.raw.raw_customers
-- purpose: rename and clean raw customer data for downstream use

with source as (

    -- pull all records directly from the raw source table in Snowflake
    -- using source() function means if the raw table moves we only update _sources.yml
    select * from {{ source('jaffle_shop', 'raw_customers') }}

),

renamed as (

    select
    -- rename id to customer_id for clarity downstream
        id as customer_id,  
        first_name,
        last_name

    from source

)

-- final select avails the cleaned data to downstream models
select * from renamed