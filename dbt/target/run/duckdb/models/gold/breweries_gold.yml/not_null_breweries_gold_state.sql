select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select state
from "dbt"."main_gold"."breweries_gold"
where state is null



      
    ) dbt_internal_test