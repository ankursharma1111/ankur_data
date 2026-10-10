
SELECT
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY,
    QUANTITY,
    PRICE,
    GROSS_SALES
FROM {{ ref('int_order_Details') }}
WHERE STATUS = 'COMPLETED'
