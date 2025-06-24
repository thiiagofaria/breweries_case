
      create or replace view "dbt"."main_silver"."breweries_silver__dbt_int" as (
        select * from read_parquet('s3://silver/breweries_silver/data.parquet', union_by_name=False)
        -- if relation is empty, filter by all columns having null values
        
      );
    