-- test file: test_order_delivery_time.sql
SELECT
    O_ORDERKEY,
    O_orderstatus
FROM {{ ref('orders') }}
WHERE O_orderstatus in ('P','F','O')
