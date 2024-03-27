import os
import googleapiclient.discovery
import pandas as pd
from azure.storage.blob import BlobClient
from azure.identity import DefaultAzureCredential

def extract_data():
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"
    api_service_name = "youtube"
    api_version = "v3"
    DEVELOPER_KEY = "AIzaSyAh2VZ154srI0UOJLQ9gtbnM1IXbeZdVB4"

    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, developerKey=DEVELOPER_KEY)

    response_collection = []
    
    nextPageToken = None

    # Paginate through comments until all are retrieved
    while True:
        request = youtube.commentThreads().list(
            part="snippet,replies",
            videoId="B-d97ZrAJZ0",  # Replace with the video ID you want to extract comments from
            pageToken=nextPageToken
        )
        response = request.execute()
        response_collection.extend(response["items"])
        nextPageToken = response.get("nextPageToken")
        if not nextPageToken:
            break

    return response_collection

def transform_data(response_collection):
    comments = []
    for item in response_collection:
        comment = item["snippet"]["topLevelComment"]["snippet"]
        author = comment["authorDisplayName"]
        comment_text = comment["textOriginal"]
        publish_time = comment["publishedAt"]
        like_count = comment["likeCount"]
        comment_info = {
            "author": author,
            "comment_text": comment_text,
            "publish_time": publish_time,
            "like_count": like_count
        }
        comments.append(comment_info)

    return pd.DataFrame(comments)

def load_data(df):
    # Azure Blob Storage credentials and container information
    account_url = "YOUR_ACCOUNT_URL_HERE"
    container_name = "youtube-etl-airflow"
    blob_name = "oneplus12_youtube_comments.csv"

    # Create a BlobClient to upload the DataFrame as a CSV file
    blob_client = BlobClient(
        account_url=account_url, 
        container_name=container_name, 
        blob_name=blob_name,
        credential=DefaultAzureCredential(),
    )

    # Write DataFrame to a temporary CSV file and upload to Blob Storage
    df.to_csv("temp.csv", index=False)
    with open("temp.csv", "rb") as data:
        blob_client.upload_blob(data, overwrite=True)

    # Remove the temporary CSV file
    os.remove("temp.csv")

def run_etl():
    # Extract data from YouTube API
    response_collection = extract_data()
    
    # Transform data into DataFrame
    df = transform_data(response_collection)
    
    # Load data into Azure Blob Storage
    load_data(df)
