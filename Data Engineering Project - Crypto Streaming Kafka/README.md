### Project Description: Real-time Cryptocurrency Market Data Pipeline

#### Overview
This project aims to build a real-time data pipeline for collecting, processing, and storing cryptocurrency market data using Kafka, Azure Blob Storage, and the CoinMarketCap API. The pipeline consists of two main components: a producer that fetches data from the API and publishes it to a Kafka topic, and a consumer that reads data from the Kafka topic and uploads it to Azure Blob Storage.

#### Technologies Used
- **Kafka:** A distributed streaming platform for handling real-time data feeds.
- **Azure Vm** : A virtual machine to run kafka servers.
- **Azure Blob Storage:** A cloud-based storage solution for storing large amounts of unstructured data.
- **CoinMarketCap API:** An API for accessing cryptocurrency market data.
- **Python:** It is used for implementing the data pipeline.

#### Workflow
1. **Data Extraction**
   - Use the CoinMarketCap API to fetch the latest cryptocurrency market data.
   - Handle potential connection errors and timeouts gracefully.
   - The producer to connect to the Kafka broker running on the Azure VM with the IP address 20.197.15.167 and port          9092.
     
```python
producer = KafkaProducer(bootstrap_servers=["20.197.15.167:9092"],
                        value_serializer=lambda x: dumps(x).encode("utf-8"))
for data in data_list:
    producer.send('crypto', value=data)
    sleep(1)
print("Data sent to Kafka topic successfully")

```  
You can see the full KafkaProducer python code for data extraction is [HERE.](Files/KafkaProducer.ipynb)

2. **Data Transformation**
   - Convert the fetched data into JSON format for compatibility with Kafka.

3. **Data Ingestion**
   - Use KafkaProducer to publish the data to a Kafka topic named "crypto".

4. **Data Storage**
   - Use KafkaConsumer to consume messages from the "crypto" topic.
   - Upload each message to Azure Blob Storage as a JSON file in a container named "cryptomarket".

5. **Error Handling**
   - Implemented error handling to ensure the pipeline can recover from failures gracefully.
