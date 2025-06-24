
    
    

select
    id as unique_field,
    count(*) as n_records

from "dbt"."main_silver"."breweries_silver"
where id is not null
group by id
having count(*) > 1


