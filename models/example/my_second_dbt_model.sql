
select {{ demo_cols() }}
from {{ ref('my_first_dbt_model') }}
