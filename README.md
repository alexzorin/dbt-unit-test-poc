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

```diff
diff --git a/macros/demo.sql b/macros/demo.sql
index f55d77c..e03f79c 100644
--- a/macros/demo.sql
+++ b/macros/demo.sql
@@ -9,7 +9,7 @@
 {%- macro demo_cols() -%}
     {%- if execute -%}
         {%- set columns = (
-            model.columns.values()
+            graph.nodes["model.demo.my_second_dbt_model"].columns.values()
             | list
         ) -%}
         {%- for col in columns -%}
```

### Running the workaround

    git checkout workaround
    docker compose up --attach dbt

## Relevant Files

- Macro line that is the source of the crash: https://github.com/alexzorin/dbt-unit-test-poc/blob/d66958a69ef4b9c4a9e3a85d3b9e46ce34117fdc/macros/demo.sql#L11-L13
- Model that uses the macro: https://github.com/alexzorin/dbt-unit-test-poc/blob/main/models/example/my_second_dbt_model.sql#L2
- The unit test: https://github.com/alexzorin/dbt-unit-test-poc/blob/main/tests/unit/demo.sql