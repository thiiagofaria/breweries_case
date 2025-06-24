FROM apache/airflow:2.8.0-python3.11

# Define o diretório do DBT (usado em runtime)
ENV DBT_DIR=/opt/dbt

# Cria diretório com permissões corretas
USER root
RUN mkdir -p ${DBT_DIR}/duckdb && \
    chown -R airflow: ${DBT_DIR}

# Volta para o usuário airflow
USER airflow

# Define diretório de trabalho padrão do Airflow
WORKDIR /opt/airflow

# Copia os requirements (para instalar dbt e libs)
COPY --chown=airflow:airflow airflow/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia os DAGs e scripts
COPY --chown=airflow:airflow airflow/dags /opt/airflow/dags
COPY --chown=airflow:airflow airflow/scripts /opt/airflow/scripts

# Copia o projeto dbt (se não for montado como volume)
COPY --chown=airflow:airflow dbt ${DBT_DIR}
