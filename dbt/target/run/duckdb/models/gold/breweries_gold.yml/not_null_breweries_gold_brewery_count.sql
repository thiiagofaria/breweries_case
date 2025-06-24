select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select brewery_count
from "dbt"."main_gold"."breweries_gold"
where brewery_count is null



      
    ) dbt_internal_test