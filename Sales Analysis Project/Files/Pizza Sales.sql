-- Select all columns from the pizza_sales table
SELECT * FROM pizza_sales;

-- Calculate the total revenue from pizza sales
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- Calculate the average order value
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Avg_Order_Value FROM pizza_sales;

-- Calculate the total number of pizzas sold
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- Calculate the average number of pizzas per order
SELECT 
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
        AS DECIMAL(10,2)
    ) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

-- Select the order day and total orders for each day of the week
SELECT 
    DATENAME(dw, order_date) AS Order_Day, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(dw, order_date);

-- Select the month and total orders for each month
SELECT 
    DATENAME(month, order_date) AS Month, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(month, order_date)
ORDER BY Total_Orders DESC;

-- Calculate the total sales and percentage of total sales for each pizza category in January
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10)) AS Total_Sales,
    CAST(
        SUM(total_price) * 100 / (
            SELECT SUM(total_price) 
            FROM pizza_sales 
            WHERE MONTH(order_date) = 1
        ) AS DECIMAL(10,2)
    ) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Sales DESC;

-- Calculate the total sales and percentage of total sales for each pizza size in the first quarter
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10)) AS Total_Sales,
    CAST(
        SUM(total_price) * 100 / (
            SELECT SUM(total_price) 
            FROM pizza_sales 
            WHERE DATEPART(quarter, order_date) = 1
        ) AS DECIMAL(10,2)
    ) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

-- Select the top 5 pizza names by total revenue
SELECT 
    TOP 5 pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC;

-- Select the bottom 5 pizza names by total revenue
SELECT 
    TOP 5 pizza_name, 
    SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC;

-- Select the top 5 pizza names by total quantity sold
SELECT 
    TOP 5 pizza_name, 
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity DESC;

-- Select the bottom 5 pizza names by total quantity sold
SELECT 
    TOP 5 pizza_name, 
    SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity ASC;

-- Select the top 5 pizza names by total number of orders
SELECT 
    TOP 5 pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Orders DESC;

-- Select the bottom 5 pizza names by total number of orders
SELECT 
    TOP 5 pizza_name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Orders ASC;
