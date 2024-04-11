FROM python:3.12-alpine

VOLUME ["/app"]
WORKDIR /app

RUN apk add libffi-dev gcc libc-dev linux-headers make git && \
    pip install --upgrade setuptools wheel ipdb && \
    pip install dbt-postgres

ENTRYPOINT [ "make" ]