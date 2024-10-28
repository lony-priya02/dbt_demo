-- models/hub_customer.sql
{{ config(materialized='table') }}
WITH source AS (
  SELECT DISTINCT
    C_CUSTKEY as C_CUSTKEY,
    hash(C_CUSTKEY) AS cust_key,
    C_NAME as customer_name,
    CURRENT_TIMESTAMP AS UPDATE_DT
  FROM {{ source('sample_data_snowflake','CUSTOMER') }} limit 10
)
SELECT * FROM source
