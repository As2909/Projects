# Data Engineering Project: YouTube Comments ETL

## Project Overview
This project focuses on extracting, transforming, and loading (ETL) YouTube comments data using the YouTube Data API and Azure Blob Storage. The goal is to collect comments from a specific YouTube video, process them into a structured format, and store them in Azure Blob Storage for further analysis. Airflow is used to orchestrate the whole ETL process.

## Tools and Technologies Used
- Google API Client Library for accessing the YouTube Data API
- Pandas for data manipulation
- Azure Storage Blob SDK for interacting with Azure Blob Storage
- Apache Airflow for workflow management

## Data Extraction
The project starts with extracting comments from a YouTube video using the YouTube Data API. Google has simplified their API usage, providing an API explorer that lets me see the returned data directly within explorer itself.
![api_explore](Files/1google_api_explorer.png)
In my youtube_etl code i used `extract_data()` function  to fetches comments in batches using pagination to ensure all comments are retrieved.

## Data Transformation
Understanding the data and its structure and getting the data I needed. CommentsThreads endpoint offers a list of comment threads.
Once the comments are extracted, the `transform_data()` function processes the raw comment data into a structured format. It extracts relevant information such as the author's name, comment text, publish time, and like count for each comment.

## Data Loading
The transformed data is then loaded into Azure Blob Storage using the `load_data()` function. The data is saved as a CSV file in a specified container in the Azure Blob Storage account.

## Airflow DAG
The ETL process is orchestrated using Apache Airflow. A DAG (Directed Acyclic Graph) named `youtube_etl` is created with a single task `run_etl_task` that executes the ETL process. The DAG is scheduled to run daily to ensure that new comments are captured regularly.

## Conclusion
This project demonstrates a basic ETL pipeline for processing YouTube comments data. It showcases how data can be extracted from an API, transformed into a usable format, and loaded into a storage system for further analysis.

