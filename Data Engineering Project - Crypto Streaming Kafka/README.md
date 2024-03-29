### Project Description: Real-time Cryptocurrency Market Data Pipeline

#### Overview
This project aims to build a real-time data pipeline for collecting, processing, and storing cryptocurrency market data using Kafka, Azure Blob Storage, and the CoinMarketCap API. The pipeline consists of two main components: a producer that fetches data from the API and publishes it to a Kafka topic, and a consumer that reads data from the Kafka topic and uploads it to Azure Blob Storage.

#### Technologies Used
- **Kafka:** A distributed streaming platform for handling real-time data feeds.
- **Azure Blob Storage:** A cloud-based storage solution for storing large amounts of unstructured data.
- **CoinMarketCap API:** An API for accessing cryptocurrency market data.
- **Python:** It is used for implementing the data pipeline.

#### Workflow
1. **Data Extraction**
   - Use the CoinMarketCap API to fetch the latest cryptocurrency market data.
   - Handle potential connection errors and timeouts gracefully. \
You can see the KafkaConsumer python code for data extraction is [HERE.](Files/KafkaConsumer.ipynb)

2. **Data Transformation**
   - Convert the fetched data into JSON format for compatibility with Kafka.

3. **Data Ingestion**
   - Use KafkaProducer to publish the data to a Kafka topic named "crypto".

4. **Data Storage**
   - Use KafkaConsumer to consume messages from the "crypto" topic.
   - Upload each message to Azure Blob Storage as a JSON file in a container named "cryptomarket".

5. **Error Handling**
   - Implemented error handling to ensure the pipeline can recover from failures gracefully.
