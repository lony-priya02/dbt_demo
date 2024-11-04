{% macro generate_snapshot(snapshot_name, source_schema, source_table, unique_key, updated_at) %}
{% snapshot {{ sat_order_snapshot }} %}
    
    {{ config(
materialized='snapshot',
unique_key='C_CUSTKEY',
strategy='timestamp',
updated_at='UPDATE_DT',
target_schema=generate_schema_name('snapshots')
    ) }}

select * from {{ source(source_schema, source_table) }}
{% endfor %}
{% endmacro %}