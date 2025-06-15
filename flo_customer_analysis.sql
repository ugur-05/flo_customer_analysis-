-- SQL Queries for FLO Customer Analytics Project

-- 1. Retrieve the entire FLO table
SELECT * FROM flo;

-- 2. Count of unique customers who made a purchase
SELECT COUNT(DISTINCT master_id) AS customer_count FROM flo;

-- 3. Total revenue and total number of purchases
SELECT 
  SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS total_revenue,
  SUM(order_num_total_ever_offline + order_num_total_ever_online) AS total_orders
FROM flo;

-- 4. Average revenue per order
SELECT 
  SUM(customer_value_total_ever_offline + customer_value_total_ever_online) / 
  SUM(order_num_total_ever_offline + order_num_total_ever_online) AS avg_revenue_per_order
FROM flo;

-- 5. Total revenue and order count by last order channel
SELECT 
  last_order_channel, 
  SUM(customer_value_total_ever_offline + customer_value_total_ever_online) AS total_revenue, 
  SUM(order_num_total_ever_offline + order_num_total_ever_online) AS total_orders
FROM flo
GROUP BY last_order_channel;

-- 6. Yearly order count based on the year of first order date
SELECT 
  YEAR(first_order_date) AS order_year,
  SUM(order_num_total_ever_offline + order_num_total_ever_online) AS total_orders
FROM flo
GROUP BY YEAR(first_order_date)
ORDER BY order_year;

-- 7. Average revenue per order by last order channel
SELECT 
  last_order_channel,
  ROUND(
    SUM(customer_value_total_ever_offline + customer_value_total_ever_online) /
    SUM(order_num_total_ever_offline + order_num_total_ever_online), 1
  ) AS avg_revenue_per_order
FROM flo
GROUP BY last_order_channel;

-- 8. Total online and offline revenue per customer
SELECT 
  master_id,
  customer_value_total_ever_offline AS offline_revenue,
  customer_value_total_ever_online AS online_revenue
FROM flo;

-- 9. Retrieve master_id and order_channel
SELECT master_id, order_channel FROM flo;

-- 10. Records with order channel not equal to 'offline'
SELECT * FROM flo WHERE last_order_channel != 'offline';

-- 11. Customers whose last order channel is not 'offline' and spent more than 1000 online
SELECT * FROM flo 
WHERE last_order_channel <> 'offline' AND customer_value_total_ever_online > 1000;

-- 12. Total online and offline revenue where order_channel is 'mobile'
SELECT 
  SUM(customer_value_total_ever_offline) AS total_offline_revenue,
  SUM(customer_value_total_ever_online) AS total_online_revenue
FROM flo
WHERE order_channel = 'mobile';

-- 13. Retrieve records where interested_in_categories_12 contains the word 'SPOR'
SELECT * FROM flo 
WHERE interested_in_categories_12 LIKE '%SPOR%';

-- 14. Records where offline spending is between 0 and 10000
SELECT * FROM flo 
WHERE customer_value_total_ever_offline BETWEEN 0 AND 10000;

-- 15. Online order count grouped by interested_in_categories_12 and order_channel
SELECT 
  order_channel, 
  interested_in_categories_12, 
  SUM(order_num_total_ever_online) AS total_online_orders
FROM flo
GROUP BY order_channel, interested_in_categories_12;
