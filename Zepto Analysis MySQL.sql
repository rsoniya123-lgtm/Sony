select * from ai.zepto;
---- data exploration ---

--- count of rows ----
select count(*) from ai.zepto;

--- sample data ---
select * from ai.zepto limit 10;

--- null values ---
select * from ai.zepto
where name IS NULL OR 
category IS NULL 
OR 
mrp IS NULL 
OR 
discountPercent IS NULL
OR 
availableQuantity IS NULL
OR 
discountedSellingPrice IS NULL
OR 
weightInGms IS NULL
OR 
outOfStock IS NULL
OR 
quantity IS NULL;  

--- different product categories ---
select distinct category from ai.zepto order by category;

--- products in stock vs out of stock ---
select outOfStock, count(*) from ai.zepto group by outOfStock;

--- product names present multiple times ---
select name, count(*) as Number_of_Products from ai.zepto
group by name 
having count(*)>1
order by count(*) desc;

--- data cleaning ---

--- products with price = 0
select * from ai.zepto 
where mrp = 0 or discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM ai.zepto
WHERE mrp = 0;

SET SQL_SAFE_UPDATES = 1;

--- convert paise to rupees ---
SET SQL_SAFE_UPDATES = 0;

UPDATE ai.zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

SET SQL_SAFE_UPDATES = 1;
select mrp, discountedSellingPrice from ai.zepto;

--- Q1. Find the top 10 best-value products based on the discount percentage.---
select distinct name, mrp, discountPercent
from ai.zepto
order by discountPercent desc
limit 10;

--- Q2. What are the products with high MRP but Out of Stock ---
select distinct name, mrp
from ai.zepto
where outOfStock = TRUE and mrp < 3000
order by mrp desc;


--- Q3. Calculate estimated revenue for each category ---
select category, sum(discountedSellingPrice  * availableQuantity) as total_revenue
from ai.zepto
group by category
order by total_revenue;

--- Q4. Find all products where MRP is greater than $5000 and discount is less than 10%. ---
select distinct name, mrp, discountPercent
from ai.zepto
where mrp > 5000 and discountPercent < 10
order by mrp desc, discountPercent desc;

--- Q5. Identify th etop 5 categories offering the highest average discount percentage. ---
select category, round(avg(discountPercent),2) as avg_discount
from ai.zepto
group by category
order by avg_discount desc
limit 5;


--- Q6. Find the price per gram fro products above 100g and sort by best value. ---
select distinct name, weightInGms, discountedSellingPrice,
round(discountedSellingPrice/weightInGms, 2) as price_per_gram
from ai.zepto
where weightInGms>=100
order by price_per_gram;

--- Q7. Group the products into categories like low, medium, bulk ---
select distinct name, weightInGms,
case when weightInGms < 1000 then 'Low'
     when weightInGms < 5000 then 'Medium'
     else 'Bulk'
	end as weight_category
from ai.zepto;

--- Q8. What is the total inventory weight per category ---
select category,
sum(weightInGms * availableQuantity) as total_weight
from ai.zepto
group by category
order by total_weight;


