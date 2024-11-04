-- models/link_order_customer.sql
{{ config(materialized='table') }}
WITH source AS (
  SELECT DISTINCT
    o_orderkey,
    o_custkey,
    hash(o_orderkey || o_custkey) AS link_order_cust_key,
    o_orderstatus,
    O_ORDERDATE,
    O_SHIPPRIORITY,
    current_timestamp() as update_dt
  FROM {{ source('sample_data_snowflake','ORDERS') }} limit 10
)
SELECT * FROM source

/*{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
where update_dt >= (select max(update_dt) from {{ this }}) 

{% endif %}
