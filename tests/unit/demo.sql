{{
    config(
        tags=['unit-test']
    )
}}

-- depends_on: {{ ref('my_first_dbt_model') }}

{% call dbt_unit_testing.test('my_second_dbt_model', 'all ids should be multiplied by 1000') %}
  
  {% call dbt_unit_testing.mock_ref ('my_first_dbt_model') %}
    select 7 as id, 'foo' as title
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    select 7000 as id
  {% endcall %}
{% endcall %}
