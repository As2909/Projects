
from pyspark.sql.functions import *
from pyspark.sql.types import *

# connect to datalakegen2 containers 
try:
  configs = {
  "fs.azure.account.auth.type": "CustomAccessToken",
  "fs.azure.account.custom.token.provider.class": spark.conf.get("spark.databricks.passthrough.adls.gen2.tokenProviderClassName")
  }

  dbutils.fs.mount(
    source = "abfss://ingested-data@etlstorage507.dfs.core.windows.net/",
    mount_point = "/mnt/ingested-data",
    extra_configs = configs)
except:
  print("Already Mounted ingested-data Container")
try:
  configs = {
  "fs.azure.account.auth.type": "CustomAccessToken",
  "fs.azure.account.custom.token.provider.class": spark.conf.get("spark.databricks.passthrough.adls.gen2.tokenProviderClassName")
  }

  dbutils.fs.mount(
    source = "abfss://transformation-1@etlstorage507.dfs.core.windows.net/",
    mount_point = "/mnt/transformation-1",
    extra_configs = configs)
except:
  print("Already Mounted transformation-1 Container")
try:
  configs = {
    "fs.azure.account.auth.type": "CustomAccessToken",
    "fs.azure.account.custom.token.provider.class": spark.conf.get("spark.databricks.passthrough.adls.gen2.tokenProviderClassName")
  }

  dbutils.fs.mount(
    source = "abfss://transformation-2@etlstorage507.dfs.core.windows.net/",
    mount_point = "/mnt/transformation-2",
    extra_configs = configs)
except:
  print("Already Mounted transformation-2 Container")


#### Transformation_1
table_names = []
# Select the path of all tables
files_path = dbutils.fs.ls("/mnt/ingested-data/SalesLT/")

# Insert the all table_name in table_names_list
for i in files_path:
  table_names.append(i.name.split("/")[0])
for i in table_names:
    path = "/mnt/ingested-data/SalesLT/" + i + "/" + i + ".parquet"
    df = spark.read.format("parquet").load(path)
    columns = df.columns

    for col in columns:
        if "Date" in col or "date" in col:
            df = df.withColumn(col, date_format(from_utc_timestamp(col, "UTC"), "yyyy-MM-dd"))

    output_path = "/mnt/transformation-1/SalesLT/" + i + "/"
    df.write.format("delta").mode("overwrite").save(output_path)


#### Transformation_2
table_names = []

level_1_transformed_path = dbutils.fs.ls("mnt/transformation-1/SalesLT/")
for i in level_1_transformed_path:
    table_names.append(i.name.split("/")[0])
for table in table_names:
    path = "/mnt/transformation-1/SalesLT/" + table
    print(path)
    df_path = spark.read.format("delta").load(path)

    # Get the list of column names
    col_names = df_path.columns

    for old_col in col_names:
        # Convert column name from ColumnName to Column_Name format
        new_col = "".join([
                        "_" + char 
                        if char.isupper() and not old_col[i - 1].isupper()
                        else char for i, char in enumerate(old_col)])\
                        .lstrip("_")
        df_path = df_path.withColumnRenamed(old_col, new_col)

    final_output_path = "/mnt/transformation-2/SalesLT/" + table + "/"
    df_path.write.format("delta").mode("overwrite").save(final_output_path)
