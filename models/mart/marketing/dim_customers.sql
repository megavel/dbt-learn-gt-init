with customers as (

    select * from
    {{ref('stg_jaffle_shop_customers')}}
),

stripe_details as (

    select * from 
    {{ref('fct_orders')}}
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_amountusdd

    from stripe_details

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        c.first_order_date,
        c.most_recent_order_date,
        coalesce(c.number_of_orders, 0) as number_of_orders,
        c.lifetime_amountusddd

    from customers
    left join customer_orders c using (customer_id)
    
)

select * from final
