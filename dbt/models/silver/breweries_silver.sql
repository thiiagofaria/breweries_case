
{{ config(
    materialized='external',
    format='parquet',
    location='s3://silver/breweries_silver/data.parquet'
) }}

WITH source AS (
    SELECT *
    FROM {{ ref('breweries_bronze') }}
),

cleaned AS (
    SELECT
        id,
        lower(trim(CAST(name AS VARCHAR)))         AS name,
        lower(trim(CAST(brewery_type AS VARCHAR))) AS brewery_type,
        trim(CAST(address_1 AS VARCHAR))           AS address_1,
        trim(CAST(address_2 AS VARCHAR))           AS address_2,
        trim(CAST(address_3 AS VARCHAR))           AS address_3,
        trim(CAST(street AS VARCHAR))              AS street,
        upper(left(trim(CAST(city AS VARCHAR)), 1))
          || lower(substr(trim(CAST(city AS VARCHAR)), 2)) AS city,
        upper(trim(CAST(state AS VARCHAR)))        AS state,
        upper(trim(CAST(state_province AS VARCHAR))) AS state_province,
        trim(CAST(postal_code AS VARCHAR))         AS postal_code,
        trim(CAST(country AS VARCHAR))             AS country,
        trim(CAST(phone AS VARCHAR))               AS phone,
        trim(CAST(website_url AS VARCHAR))         AS website_url,
        CAST(longitude AS DOUBLE)                  AS longitude,
        CAST(latitude AS DOUBLE)                   AS latitude
    FROM source
    WHERE id IS NOT NULL
)

SELECT DISTINCT * FROM cleaned