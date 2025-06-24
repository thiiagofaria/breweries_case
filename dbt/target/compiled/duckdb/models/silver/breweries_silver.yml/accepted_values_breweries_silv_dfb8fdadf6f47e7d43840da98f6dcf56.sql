
    
    

with all_values as (

    select
        brewery_type as value_field,
        count(*) as n_records

    from "dbt"."main_silver"."breweries_silver"
    group by brewery_type

)

select *
from all_values
where value_field not in (
    'micro','nano','regional','brewpub','large','planning','contract','proprietor','closed'
)


