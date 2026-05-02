select *
from customer

--Q1 What is the total revenue generateed by male vs female customer?
select gender ,sum(purchase_amount) as revenue
from customer
group by gender

--Q2 Which customer used a discount but still spent more than the average purchase amount?
select customer_id, purchase_amount
from customer 
where discount_applied = 'Yes' and purchase_amount >= (select avg(purchase_amount) from customer);

--Q3 What are the top 5 products with highest average review rating?
select item_purchased, round(avg(review_rating::numeric),2) 
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;

--Q4 Compare the average Purchase Amount between Standard and Express Shipping.
select shipping_type, round(avg(purchase_amount),2)
from customer 
where shipping_type in ('Standard','Express') 
group by shipping_type;

--Q5 Do subscribed customer spend more? Compare average spend and total revenue between subscribers abd non-subscribers.
select subscription_status,
count(customer_id) as total_customer,
round(avg(purchase_amount),2) as avg_spend,
sum(purchase_amount) as total_revenue
from customer
group by subscription_status
order by total_revenue,avg_spend;

--Q6 What are the top 3 most purchased products?
select count(category),item_purchased 
from customer
group by category,item_purchased
order by count(category) desc 
limit 3;