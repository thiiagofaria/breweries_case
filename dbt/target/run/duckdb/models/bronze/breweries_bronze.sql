
      create or replace view "dbt"."main_bronze"."breweries_bronze__dbt_int" as (
        select * from read_parquet('s3://bronze/breweries_bronze/data.parquet', union_by_name=False)
        -- if relation is empty, filter by all columns having null values
        
      );
    