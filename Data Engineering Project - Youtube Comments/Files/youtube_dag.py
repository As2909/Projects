from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
from youtube_etl import run_etl

default_args = {
    'owner': 'ankit',
    'depends_on_past': False,
    'start_date': days_ago(0),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'youtube_etl',
    default_args=default_args,
    description='A simple DAG to perform ETL from YouTube API to Azure Blob Storage',
    schedule_interval=timedelta(days=1),
)


run_etl_task = PythonOperator(
    task_id='run_etl_task',
    python_callable=run_etl,
    dag=dag,
)

run_etl_task
