
{{
    config(
        materialized='incremental',
        unique_key='ORDER_ID',
        incremental_strategy='merge'
    )
}}

WITH source_orders AS (

    SELECT
        ORDER_ID,
        CUSTOMER_ID,
        PRODUCT_ID,
        ORDER_DATE,
        QUANTITY,
        STATUS,
        UPDATED_AT
    FROM {{ source('raw', 'RAW_ORDERS') }}

),

{% if is_incremental() %}

max_target_timestamp AS (

    SELECT
        DATEADD(
            day,
            -1,
            COALESCE(
                MAX(UPDATED_AT),
                '1900-01-01'::TIMESTAMP_NTZ
            )
        ) AS MAX_UPDATED_AT
    FROM {{ this }}

)

{% endif %}

SELECT
    s.ORDER_ID,
    s.CUSTOMER_ID,
    s.PRODUCT_ID,
    s.ORDER_DATE,
    s.QUANTITY,
    s.STATUS,
    s.UPDATED_AT
FROM source_orders s

{% if is_incremental() %}

CROSS JOIN max_target_timestamp m
WHERE s.UPDATED_AT >= m.MAX_UPDATED_AT

{% endif %}
