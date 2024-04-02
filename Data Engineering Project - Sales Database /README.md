## Data Pipeline For On-Premise SQL Database

### Overview
This project aims to create a comprehensive data transformation pipeline for Azure Data Lake Storage Gen2. The pipeline will handle data ingestion, processing, transformation, and storage using ADF , Synapse Analytics and Azure Databricks.

### Technologies Required
- Apache Spark
- Azure Databricks
- Azure Data Lake Storage Gen2
- Azure Synapse Analytics
- Azure Data Factory
- Azure Key Vault
  
`Azure Services:`
![resources](Files/Resources.png)
  
#### Pipeline 1 :AdventureWorks Database Integration And Transformation
- **Data Ingestion:** Raw data from the AdventureWorks database on an on-premise SQL Server will be ingested into Azure Data Lake Storage Gen2 (`ingested-data` container) using Azure Data Factory's self-hosted integration runtime using Azure Key Vault secrets. \
  
`Database Preview:`

![raw_database](Files/Raw_Database.png)

`Create Self-hosted Integeration Runtime on local Machine:`

![IR](Files/self_hosted_ir.png)

`Connect To Local Database`:
![connect_on_premise_database](Files/connect_to_on_premise_database.png)
![alt_text](Files/after_connect_to_on_premise_database.png)

- **Data Extraction:** Using Azure Data Factory's Lookup activity, the pipeline will retrieve the table names and schemas of the SalesLT schema from the AdventureWorks database. The foreach activity will iterate over each table and use the Copy activity to load the data into Azure Data Lake Storage Gen2 as Parquet files. 

`Create Lookup Activity:`

![lookup](Files/lookup_table.png)

![alt_text](Files/lookup_table_preview_data.png)

- lookup activity generate json file that conatins all table names present in database with the help of Query. \
  
`Add Dynamic Content in Pipeline Expression builder:`

![alt_text](Files/for_each_output_pipeline_exp_for_each_table.png)

`For-Each activity for copy each tables:`

![alt_text](Files/for_each_copy_each_table_expression.png)

`Load the tables as parquet files in the datalake-gen2:`

![alt_text](Files/parquet_table_sink.png)

- **Data Transformation :** Using Spark DataFrame operations, the data will be standardized, cleaned, and being stored in the `transformation-1` container.
  
- **Data Normalization:** Column names in the transformed data will be normalized to ensure consistency.
  
- **Data Loading:** Transformed data will be loaded into the `transformation-2` container in Delta format. \
`Converting Parquet tables to Delta format using Databricks adds additional capabilities, such as ACID transactions, time travel, and schema enforcement, making it easier to manage and evolve your data pipelines over time.`

- You can see the transformation code  click [HERE.](Files/databricks_transformation.py) 
![alt_text](Files/pipeline_run.png)


#### Pipeline 2 : Create Views for Each table
- **Create Views:** Views will be created in Azure Synapse Analytics to enable querying of the Delta files stored in Azure Data Lake Storage Gen2. \

`Create Get Metadata Activity to get the the tables name: `
Get Metadata Activity Output
![output_getmetadata](Files/get_metadata_output.png)

`For-Each activity for create Stored Procedure for each tables in datalake-gen2:`

![alt_text](Files/run_2_pipeline_for_ech_st_procedure.png)

### Objectives
- Ingest raw data into Azure Data Lake Storage Gen2.
- Process and transform raw data into a parquet format.
- If Date column is present in tables transform into YYYY-MM-DD format
- Normalize column names in the transformed data from camelCase to Snake_Case
- Load transformed data into Azure Data Lake Storage Gen2 in Delta format.
- Create views in Azure Synapse Analytics for querying transformed data.

### Benefits
- Improved data quality and consistency : Standardize data formats, such as dates
- Enhanced data accessibility and query performance : Normalize column names
- Scalable and efficient data processing : Convert to Delta Format.

### Conclusion
These projects provide robust data transformation pipelines for Azure Data Lake Storage Gen2, enabling organizations to derive valuable insights from high-quality, standardized data.

