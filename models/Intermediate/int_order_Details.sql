
SELECT
    o.ORDER_ID,
    o.ORDER_DATE,
    o.STATUS,
    o.QUANTITY,

    c.CUSTOMER_ID,
    c.CUSTOMER_NAME,
    c.CITY,

    p.PRODUCT_ID,
    p.PRODUCT_NAME,
    p.CATEGORY,
    p.PRICE,

    o.QUANTITY * p.PRICE AS GROSS_SALES

FROM {{ ref('stg_orders') }} o

INNER JOIN {{ ref('stg_customers') }} c
    ON o.CUSTOMER_ID = c.CUSTOMER_ID

INNER JOIN {{ ref('stg_products') }} p
    ON o.PRODUCT_ID = p.PRODUCT_ID
