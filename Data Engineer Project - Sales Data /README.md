## Data Transformation Pipeline for Azure Data Lake Storage Gen2

### Overview
This project aims to create a comprehensive data transformation pipeline for Azure Data Lake Storage Gen2. The pipeline will handle data ingestion, processing, transformation, and storage using Apache Spark and Azure Databricks.

#### Pipeline 1: Generic Data Transformation
- **Data Ingestion:** Raw data from various sources will be ingested into Azure Data Lake Storage Gen2 (`ingested-data` container).
- **Data Transformation:** Using Spark DataFrame operations, the data will be standardized, cleaned, and enriched before being stored in the `transformation-1` container.
- **Data Normalization:** Column names in the transformed data will be normalized to ensure consistency.
- **Data Loading:** Transformed data will be loaded into the `transformation-2` container in Delta format.
- **Data Access:** Views will be created in Azure Synapse Analytics for querying the transformed data.

#### Pipeline 2: AdventureWorks Database Integration
- **Data Ingestion:** Raw data from the AdventureWorks database on an on-premise SQL Server will be ingested into Azure Data Lake Storage Gen2 (`ingested-data` container) using Azure Data Factory's self-hosted integration runtime with SQL authentication.
- **Data Transformation:** Using Azure Data Factory's Lookup activity, the pipeline will retrieve the table names and schemas of the SalesLT schema from the AdventureWorks database. The foreach activity will iterate over each table and use the Copy activity to load the data into Azure Data Lake Storage Gen2 as Parquet files.
- **Data Access:** Views will be created in Azure Synapse Analytics to enable querying of the Parquet files stored in Azure Data Lake Storage Gen2.

### Technologies Used
- Apache Spark
- Azure Databricks
- Azure Data Lake Storage Gen2
- Azure Synapse Analytics
- Azure Data Factory

### Objectives
- Ingest raw data into Azure Data Lake Storage Gen2.
- Process and transform raw data into a standardized format.
- Normalize column names in the transformed data.
- Load transformed data into Azure Data Lake Storage Gen2 in Delta format.
- Create views in Azure Synapse Analytics for querying transformed data.

### Benefits
- Improved data quality and consistency.
- Enhanced data accessibility and query performance.
- Scalable and efficient data processing.

### Future Scope
- Implement data validation and quality checks.
- Integrate real-time data processing.
- Enhance data visualization and reporting capabilities.

### Conclusion
These projects provide robust data transformation pipelines for Azure Data Lake Storage Gen2, enabling organizations to derive valuable insights from high-quality, standardized data.

