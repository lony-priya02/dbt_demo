{% macro generate_snapshot(snapshot_name, source_schema, source_table, unique_key, updated_at) %}
    
    {{ config(
        materialized='snapshot',
        unique_key='o_orderkey',
        strategy='timestamp',
        updated_at='updated_at',
        target_schema=generate_schema_name('snapshots')
    ) }}

    select * from {{ source(source_schema, source_table) }}
    
{% endmacro %}