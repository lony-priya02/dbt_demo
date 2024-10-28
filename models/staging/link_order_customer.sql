-- models/link_order_customer.sql
{{ config(materialized='table') }}
WITH source AS (
  SELECT DISTINCT
    o_orderkey,
    o_custkey,
    hash(o_orderkey || o_custkey) AS link_order_region_key,
    o_orderstatus
  FROM {{ source('sample_data_snowflake','ORDERS') }} limit 10
)
SELECT * FROM source
