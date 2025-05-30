use snapdeal_sales_data;
SELECT * FROM snapdeal_sales_data;
RENAME TABLE `snapdeal sales data` TO snapdeal_sales_data;

# Q1. Show all orders where the sales amount is greater than ₹500
select * from snapdeal_sales_data
where sales>500;

# Q2. Show products where profit per unit (Profit ÷ Quantity) is more than ₹50.

select * from snapdeal_sales_data
where (profit/quantity) > 50;

# Q3. List orders from the 'South' or 'East' region where quantity is more than 2.
select * from snapdeal_sales_data
where (region = "south" or region= "east") and quantity >2;

# Q4. Show total sales per region.
select region, sum(sales)
from snapdeal_sales_data
group by region;

# Q5. Show categories where total profit is more than ₹10,000.

select category, sum(profit)
from snapdeal_sales_data
group by category
having sum(profit) > 10000;

#Q6. Show top 5 products by highest profit.

select * , profit
from snapdeal_sales_data
order by profit desc 
limit 5;

# Q7. Show average discount given per category.

select category, avg(discount)
from snapdeal_sales_data
group by category;

# Q8. Show sub-categories with more than 5 units sold and total profit > ₹5,000, sorted by profit.

select Subcategory, sum(profit) as "total_profit"
FROM snapdeal_sales_data
where quantity >5
group by Subcategory
having sum(profit) > 5000
order by "total_profit" asc; 

# 9.Show orders with feedback and their ratings
select a.customer_name, b.feedback_date, b.rating, a.product_name
from snapdeal_sales_data as a
inner join customer_feedback as b
on a.customer_id=b.customer_id;

# 10. Show all orders and feedback if available

select *, b.feedback_date
from snapdeal_sales_data as a
left join customer_feedback as b
on a.customer_id=b.customer_id;

# 11.Show all feedback entries and matching order details
select *, a.product_name
from snapdeal_sales_data as a
right join customer_feedback as b
on a.customer_id=b.customer_id;

# 12. Show all orders and all feedbacks, matched or not

select *
from snapdeal_sales_data as a
left join customer_feedback as b
on a.customer_id=b.customer_id
union 
select *
from snapdeal_sales_data as a
right join customer_feedback as b
on a.customer_id=b.customer_id;

# 13. Combine Customer_IDs from both tables (without duplicates)

SELECT Customer_ID from customer_feedback
UNION
SELECT Customer_ID from snapdeal_sales_data;

# 14. Show orders where the customer gave a rating below 3

select *
from snapdeal_sales_data
where Customer_ID in (select Customer_ID from customer_feedback where rating <3);

# 15. Use CTE to calculate average rating per customer, then filter

with my_cte as (select customer_id, avg(rating) as av from customer_feedback group by customer_id)
select Customer_ID, av from my_cte;

# 16. Label feedback ratings as 'Positive' if greater than 3, 'Neutral' if greater than 2, or 'Negative' 

select Customer_ID, rating,
case
   when Rating >3 then 'Positive'
   when Rating >2 then 'Neutral'
   else 'Negative'
end as other
from customer_feedback;

 # 17.Filter orders based on dynamic discount level Discount more than or 0.3 THEN High and if Discount BETWEEN 0.1 AND 0.29 THEN Medium
# otherwise Low. 

select *,
 case
   when Discount >= 0.3 THEN 'High'
   when Discount BETWEEN 0.1 AND 0.29 THEN 'Medium'
   else 'Low'
end as 'dynamic discount level'
from snapdeal_sales_data;


# Q18. Running average of ratings over time per customer

select customer_id, rating,
avg(rating) over (order by 'rating') as 'average'
from customer_feedback; 

# 19. Show next Ship_Mode for the same customer

select  Customer_ID, Customer_Name,
 lead (Ship_Mode) over (order by Ship_Mode) as 'next_Ship_Mode'
from snapdeal_sales_data;

# 20. Show the last region used by each customer
select Customer_ID, region,
LAST_VALUE (region) over (order by region) as 'last_region'
from snapdeal_sales_data;

# 21. Number each customer’s orders
select *,
ROW_NUMBER() OVER(ORDER BY Customer_ID) AS 'ROW_NUMBER'
from snapdeal_sales_data;

select * from snapdeal_sales_data;
select * from customer_feedback;

