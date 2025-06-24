from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime
import subprocess

def ingest():
    subprocess.run(["python", "/opt/airflow/scripts/ingest.py"], check=True)

with DAG(
    "pipeline_dbt_duckdb",
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["dbt", "duckdb"],
) as dag:

    ingest_task = PythonOperator(
        task_id="ingest",
        python_callable=ingest
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=(
            "DBT_LOG_PATH=/opt/airflow/logs "
            "dbt run --project-dir /opt/dbt --profiles-dir /opt/dbt"
        ),
    )

    ingest_task >> dbt_run
