FROM apache/airflow:2.8.0-python3.11

ENV DBT_DIR=/opt/dbt

USER root
RUN mkdir -p ${DBT_DIR}/duckdb && \
    chown -R airflow: ${DBT_DIR}

USER airflow

WORKDIR /opt/airflow

COPY --chown=airflow:airflow airflow/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=airflow:airflow airflow/dags /opt/airflow/dags
COPY --chown=airflow:airflow airflow/scripts /opt/airflow/scripts

COPY --chown=airflow:airflow dbt ${DBT_DIR}
