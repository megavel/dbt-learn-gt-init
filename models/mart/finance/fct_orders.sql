with 
stripe as (
    select *
    from {{ref('stg_stripe__payments')}}
),

orders as (
    select *
    from {{ref('stg_jaffle_shop_orders')}}
),

paymentcheck as (

    select 
    order_id,
    coalesce(sum(amount), 0)  as amount
 from stripe
    where status = 'success'
    group by 1

)

 select 
    order_id,
    customer_id,
    order_date,
    paymentcheck.amount
    from orders
    left join paymentcheck using (order_id)