{{ config(
    materialized='external',
    format='parquet',
    location='s3://bronze/breweries_bronze/data.parquet'
) }}

SELECT * 
FROM read_parquet('s3://raw/*.parquet')