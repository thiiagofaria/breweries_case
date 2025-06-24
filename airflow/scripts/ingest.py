import pandas as pd
import boto3
import requests
from io import BytesIO
from botocore.exceptions import ClientError


headers = {"User-Agent": "Mozilla/5.0"}
response = requests.get("https://api.openbrewerydb.org/v1/breweries?per_page=50", headers=headers)
response.raise_for_status()

df = pd.DataFrame(response.json())

buffer = BytesIO()
df.to_parquet(buffer, index=False)
buffer.seek(0)

s3 = boto3.client(
    's3',
    endpoint_url='http://minio:9000',
    aws_access_key_id='minio',
    aws_secret_access_key='minio123'
)

bucket = "raw"
key = "breweries.parquet"

try:
    s3.head_bucket(Bucket=bucket)
except ClientError as e:
    error_code = int(e.response['Error']['Code'])
    if error_code == 404:
        s3.create_bucket(Bucket=bucket)
    else:
        raise

s3.upload_fileobj(buffer, Bucket=bucket, Key=key)
print("Upload concluído com sucesso!")
