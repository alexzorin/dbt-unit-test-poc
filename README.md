# dbt-unit-test-poc

This project exists to demonstrate an issue with https://github.com/EqualExperts/dbt-unit-testing.

When using a macro to access [the `model` object](https://docs.getdbt.com/reference/dbt-jinja-functions/model), it is replaced with the `tests` model. This only happens when running tests via `dbt-unit-testing`, not via `dbt run` etc.

This means if the macro relies on accessing `model.columns`, for example, it is not possible e.g.:

```jinja
{%- set columns = (
    model.columns.values()
    | list
) -%}
```

This will just produce an empty list, because `tests` has no values.

## Running

This is essentially the `dbt init ` project, with a macro added to access column data, and a basic unit test using `dbt-unit-testing`.

Make sure you have `docker-compose` installed and just run:

    docker compose up --attach dbt

You will see that the test crashes.

Of course, you can just try run the dbt project locally. 

There is a `workaround` branch that uses this to access the columns instead of `model.columns`, but this is undesirable:

```jinja
{%- set model_cols = graph.nodes["model.demo.my_second_dbt_model"].columns -%}
```
