-- macros/generate_snapshot_sql.sql
{% macro generate_snapshot_sql(staging_tables) %}
{% for hub_customer in staging_tables %}
    {{ config(
        materialized='snapshot',
        unique_key='C_CUSTKEY',
        strategy='timestamp',
        updated_at='UPDATE_DT',
        target_schema=generate_schema_name('STAGING'),
        alias=table_name ~ '_SNAPSHOT'
    ) }}

    select * from {{ ref(hub_customer) }}
{% endfor %}
{% endmacro %}


snapshots/my_snapshots.sql
{% set raw_tables = ['WFD_TABLE'] %}
{{ generate_snapshot_sql(raw_tables) }}