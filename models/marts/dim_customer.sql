
{{ config(materialized='table') }}

SELECT
    DBT_SCD_ID AS CUSTOMER_VERSION_KEY,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    CITY,

    DBT_VALID_FROM AS EFFECTIVE_FROM,
    DBT_VALID_TO AS EFFECTIVE_TO,

    CASE
        WHEN DBT_VALID_TO IS NULL THEN TRUE
        ELSE FALSE
    END AS IS_CURRENT

FROM {{ ref('customer_snapshot') }}
