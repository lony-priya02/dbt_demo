-- models/sat_customer_snapshot.sql .This model stores descriptive attributes of the customer. Each time the customer’s data changes, a new record is added with a new load_timestamp.
{% snapshot sat_customer_snapshot %}


    {{
        config(
        target_database='SAMPLE_DATA',
        target_schema='snapshots',
        unique_key='C_CUSTKEY',
        strategy='timestamp',
        updated_at='UPDATE_DT'
        )
    }}

SELECT 
C_CUSTKEY,            -- Foreign key to Customer Hub
C_NAME,               -- Descriptive attribute
C_ADDRESS,            -- Descriptive attribute
C_MKTSEGMENT,         -- Descriptive attribute
CURRENT_TIMESTAMP AS UPDATE_DT  -- The column used for updates
FROM {{ source('sample_data_snapshot','CUSTOMER') }}  -- Reference the staging table

{% endsnapshot %}
