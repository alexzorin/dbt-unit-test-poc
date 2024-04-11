.PHONY: all
all: deps run test

.PHONY: deps
deps:
	dbt deps

.PHONY: run
run:
	dbt run

.PHONY: test
test:
	dbt test --select tag:unit-test