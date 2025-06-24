{{ config(materialized='view') }}

WITH agg AS (
  SELECT
    brewery_type,
    state,
    city,
    COUNT(*) AS brewery_count
  FROM {{ ref('breweries_silver') }}
  GROUP BY brewery_type, state, city
)

SELECT
  brewery_type,
  state,
  city,
  brewery_count,
  -- total por estado (soma de brewery_count dentro de cada state)
  SUM(brewery_count) OVER (PARTITION BY state)              AS total_per_state,
  -- percentual dentro do estado
  ROUND(
    100.0 * brewery_count 
    / NULLIF(SUM(brewery_count) OVER (PARTITION BY state), 0)
  , 2)                                                      AS pct_of_state,
  -- ranking dentro do estado
  RANK() OVER (PARTITION BY state ORDER BY brewery_count DESC) AS rank_within_state
FROM agg
ORDER BY state, rank_within_state
