select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select city
from "dbt"."main_gold"."breweries_gold"
where city is null



      
    ) dbt_internal_test