--select * from pizza_sales


--select sum(total_price) as Total_Revenue


--select sum(total_price) / count(distinct(order_id)) as Avr_Order_Value from pizza_sales

--select sum(quantity) as Total_pizza_Sold
--from pizza_sales

--select cast(cast(sum(quantity) as Decimal(10,2))  / cast(count(distinct order_id) as Decimal(10,2)) as Decimal(10,2)) as Avg_Pizzas_Per_Order
--from pizza_sales




--select * from pizza_sales

--select datename(dw, order_date) as Order_Day, count(distinct order_id) as Total_Orders
--from pizza_sales
--group by Datename(dw, order_date)

--select datename(month, order_date) as Month, count(Distinct order_id) as Total_Orders
--from pizza_sales
--group by datename(month, order_date)
--order by Total_orders desc


--select* from pizza_sales

--select pizza_category, cast(sum(total_price) as Decimal (10)) as Total_Sales,
--cast(sum(total_price) * 100 / ( select sum(total_price) from pizza_sales where month(order_date) = 1) as Decimal(10,2))  as PCT
--from pizza_sales
--where month(order_date) = 1
--group by pizza_category
--order by Total_sales desc


--select pizza_size, cast(sum(total_price) as Decimal (10)) as Total_Sales,
--cast(sum(total_price) * 100 / ( select sum(total_price) from pizza_sales where Datepart(quarter, order_date) = 1) as Decimal(10,2))  as PCT
--from pizza_sales
--where Datepart(quarter, order_date) = 1
--group by pizza_size
--order by PCT desc


--select * from pizza_sales


--select Top 5  pizza_name, sum(total_price) as Total_Revenue
--from pizza_sales
--group by pizza_name 
--order by Total_Revenue desc



--select Top 5  pizza_name, sum(total_price) as Total_Revenue
--from pizza_sales
--group by pizza_name 
--order by Total_Revenue asc

--select * from pizza_sales

--select Top 5  pizza_name, sum(quantity) as Total_quantity 
--from pizza_sales
--group by pizza_name 
--order by Total_Quantity desc

--select Top 5  pizza_name, sum(quantity) as Total_quantity 
--from pizza_sales
--group by pizza_name 
--order by Total_Quantity asc


--select Top 5  pizza_name, count(Distinct order_id) as Total_Quantity 
--from pizza_sales
--group by pizza_name 
--order by Total_Quantity desc

--select Top 5  pizza_name, count(Distinct order_id) as Total_Quantity 
--from pizza_sales
--group by pizza_name 
--order by Total_Quantity asc


