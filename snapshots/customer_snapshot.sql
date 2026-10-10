
{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='CUSTOMER_ID',
        strategy='timestamp',
        updated_at='UPDATED_AT'
    )
}}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    CITY,
    UPDATED_AT
FROM {{ source('raw', 'RAW_CUSTOMERS') }}

{% endsnapshot %}
