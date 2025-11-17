select 
    id as paymentid,
    orderid as order_id,
    paymentmethod,
    amount/100 as amount,
    status,
    created,
   _batched_at 

  from raw.stripe.payment