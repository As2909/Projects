# SALES OVERVIEW 
### Project overview
* This projec explores different business metrics and how they can be displayed graphically to follow them
* I explore the relation between sales, budget, costumers and products
* We can obtain conclusions that will help us to make better marketing campaigns and improve profits
* The tools used are MsSQL server and Power-BI 

### Objectives:
The goal is to build a sales report that shows summarized information about the business´s current situation to understand how to make more profits. 

The most important indicators are sales, budget, top customers, and top products:

### Data transformation and data preparation
The data was taken from the Microsoft sample data and was extracted using SQL server into csv files to use them in the Power BI dashboard.

Date_table was used to retrieve dates about the performances of the sales through time

Sales_table, product_table and customer_table show information about sales, products and customers in that order

You can see all the SQL queries **[HERE](https://github.com/Roberto121c/Sales_Management/tree/main/Query)**:

[![](images/Sales query.PNG)](https://github.com/Roberto121c/Sales_Management/tree/main/Query)

### Data model:
You can see in this image the data model used in Power BI after the data was extracted

![Data model](images/Data model.png)

### Visualizations 
The final product is a 2 pages dashboard. The first one tell us a general perspective about the sales performance while other two focus in customers and products

You can see the final dashboard clicking **[HERE](https://app.powerbi.com/groups/me/reports/38779509-37e6-43d9-b1cd-b209b48d75cf/ReportSection)** or in the image below

[![Click for a better analysis](images/PB Sales Overview.PNG)](https://app.powerbi.com/groups/me/reports/38779509-37e6-43d9-b1cd-b209b48d75cf/ReportSection
)

### Conclusions
* The best customers are Jordan Turner, Maurice Shan, Janet Munoz, and Lisa Cai
* The best product is the Mountain-200 Black but all color sell well
* During July, September, and November 2020 our sales were less than Budget. I need more information to understand why

