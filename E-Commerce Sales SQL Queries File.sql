use AI;
select * from cleandataset;
## SQL Queries ##
     ## Top 10 profitable products ##
select product_name, sum(profit) as top_profit 
from cleandataset
group by product_name
order by top_profit desc
limit 10; 
     ## Top 10 customers by sales ##
select customer_name, sum(sales) as top_sales
from cleandataset
group by customer_name
order by top_sales desc
limit 10;
     ## Region-wise total sales ##
select region, sum(sales) as total_sales
from cleandataset
group by region;
     ## Category-wise average profit ##
select category, avg(profit) as average_profit
from cleandataset
group by category
order by average_profit desc;
     ## Highest discount category ##
select category, max(discount) as Highest_Discount
from cleandataset
group by category
order by Highest_Discount desc
limit 1;
     ## Orders with negative profit ##
select * from cleandataset
where profit < 0;
     ## Monthly sales trend ##
select DATE_FORMAT(order_date,'%M') as month,
sum(sales) as total_sales
from cleandataset
group by DATE_FORMAT(order_date,'%M')
order by month;
select MONTH(STR_TO_DATE(order_date,'%d-%m-%y')) as month,
sum(sales) as total_sales
from cleandataset
group by MONTH(STR_TO_DATE(order_date,'%d-%m-%y'))
order by month; 
     ## Market-wise revenue analysis ##
select market, 
sum(sales) as total_revenue
from cleandataset
group by market
order by total_revenue desc;
     ## Top-performing sub-categories ##
select sub_category, sum(sales) as top_performance
from cleandataset
group by sub_category
order by top_performance desc;
     ## Ship mode usage analysis ##
select ship_mode, count(*) as total_orders
from cleandataset
group by ship_mode
order by total_orders desc;
