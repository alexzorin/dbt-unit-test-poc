{% macro ref() %}
   {{ return(dbt_unit_testing.ref(*varargs, **kwargs)) }}
{% endmacro %}

{% macro source() %}
   {{ return(dbt_unit_testing.source(*varargs, **kwargs)) }}
{% endmacro %}

{%- macro demo_cols() -%}
    {%- if execute -%}
        {%- set columns = (
            graph.nodes["model.demo.my_second_dbt_model"].columns.values()
            | list
        ) -%}
        {%- for col in columns -%}
            {% if "transform" in col.meta %}
                {%- set macro = context.get(col.meta.transform) -%}
                {{ macro(col.name) }}
            {% else %} {{ col.name }}
            {%- endif -%}
            {{- "," if not loop.last -}}
        {%- endfor -%}
    {%- endif -%}
{%- endmacro -%}

{%- macro demo_transform(col) -%}
    {{ col }} * 1000 AS {{ col }}
{%- endmacro -%}
