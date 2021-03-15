/* Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd. */
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/* Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/* Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order) */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/* Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order) */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/* Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000 */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500 */
SELECT *
FROM orders
WHERE total_amt_usd < 500
ORDER BY total_amt_usd DESC
LIMIT 10;

/* Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table */
SELECT name, website, primary_poc
FROM accounts
WHERE name LIKE 'Exxon Mobil';

/* Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields */
SELECT id, account_id, standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

/* Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also */
SELECT id , account_id, 
	poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd ) AS post_per
FROM orders
LIMIT 10;

/* All the companies whose names start with 'C' */
SELECT name
FROM accounts
WHERE name LIKE 'C%';

/* All companies whose names contain the string 'one' somewhere in the name */
SELECT name
FROM accounts
WHERE name LIKE '%one%';

/* All companies whose names end with 's' */
SELECT name
FROM accounts
WHERE name LIKE '%s';

/* Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* All the companies whose names do not start with 'C' */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

/* All companies whose names do not contain the string 'one' somewhere in the name */
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

/* All companies whose names do not end with 's' */
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

/* Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0 */
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/* Using the accounts table, find all the companies whose names do not start with 'C' and end with 's' */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/* write a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29 */
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 and 29
ORDER BY gloss_qty DESC;

/* Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/* Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table */
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/* Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000 */
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana' */
SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
			AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
				 AND primary_poc NOT LIKE '%eana%');

/* Try pulling all the data from the accounts table, and all the data from the orders table */
SELECT *
FROM accounts
JOIN orders
ON account_id = accounts.id;

/* Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table */
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty ,
		accounts.website , accounts.primary_poc 
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen */
SELECT a.primary_poc, a.name,
	w.occurred_at, w.channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.name = 'Walmart';

/* Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name */
SELECT r.name region, s.name represent, a.name company
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero */
SELECT r.name region, a.name account, o.total_amt_usd / (o.total+ 0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01) */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
LEFT JOIN (region r JOIN sales_reps s ON r.id = s.region_id JOIN accounts a ON s.id = a.sales_rep_id)
ON a.id = o.account_id
WHERE o.standard_qty > 100;


/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01) */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
LEFT JOIN (region r JOIN sales_reps s ON r.id = s.region_id JOIN accounts a ON s.id = a.sales_rep_id)
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01) */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
LEFT JOIN (region r JOIN sales_reps s ON r.id = s.region_id JOIN accounts a ON s.id = a.sales_rep_id)
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

/* What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values */
SELECT DISTINCT w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = 1001;

/* Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd */
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY o.occurred_at;

/* Find the total amount of poster_qty paper ordered in the orders table */
SELECT SUM(o.poster_qty) AS total_posters_sales
FROM orders o;

/* Find the total amount of standard_qty paper ordered in the orders table */
SELECT SUM(o.standard_qty) AS total_standard_sales
FROM orders o;

/* Find the total dollar amount of sales using the total_amt_usd in the orders table */
SELECT SUM(o.total_amt_usd) AS total_dollar_sales
FROM orders o;

/* Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table */
SELECT o.standard_amt_usd + o.gloss_amt_usd total_amount_gloss_standard
FROM orders o;

/* Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator */
SELECT SUM(o.standard_amt_usd)/SUM(o.standard_qty) AS standard_amt_usd_per_unit
FROM orders o;

/* When was the earliest order ever placed? You only need to return the date */
SELECT MIN(o.occurred_at)
FROM orders o;

/* Try performing the same query as in question 1 without using an aggregation function */
SELECT o.occurred_at
FROM orders o
ORDER BY o.occurred_at
LIMIT 1;

/* When did the most recent (latest) web_event occur */
SELECT MAX(w.occurred_at)
FROM web_events w;

/* Try to perform the result of the previous query without using an aggregation function */
SELECT w.occurred_at
FROM web_events w
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount */
SELECT AVG(o.standard_amt_usd), AVG(o.gloss_amt_usd), AVG(o.poster_amt_usd), AVG(o.standard_qty), AVG(o.gloss_qty), AVG(o.poster_qty)
FROM orders o;

/* What is the MEDIAN total_usd spent on all orders */
SELECT PERCENTILE_CONT(0.5)
WITHIN GROUP (ORDER BY o.total_amt_usd)
FROM orders o;

/* Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order */
SELECT a.name, MIN(o.occurred_at)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, o.occurred_at
ORDER BY o.occurred_at
LIMIT 1;

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;

/* Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name */
SELECT a.name, SUM(o.total_amt_usd) total_sales
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_sales DESC;

/* Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name */
SELECT MAX(w.occurred_at), w.channel, a.name
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY w.channel, a.name, w.occurred_at
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT w.occurred_at, w.channel, a.name
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used */
SELECT w.channel, COUNT(*) n_times_channel
FROM web_events w
GROUP BY w.channel;

/* Who was the primary contact associated with the earliest web_event */
SELECT a.primary_poc, MIN(w.occurred_at)
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.primary_poc, w.occurred_at
ORDER BY w.occurred_at
LIMIT 1;

SELECT a.primary_poc
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

/* What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest */
SELECT a.name, MIN(o.total_amt_usd) AS total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE o.total_amt_usd > 0
GROUP BY a.name
ORDER BY total_usd;

/* Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps */
SELECT r.name region, COUNT(s.name) sales_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY sales_reps;

/* For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account */
SELECT a.name, AVG(o.standard_qty) avg_standard, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_poster
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type */
SELECT a.name, AVG(o.standard_amt_usd) avg_standard, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_poster
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

/* Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first */
SELECT s.name rep, w.channel, COUNT(*) n_times
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY n_times DESC;

/* Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first. */
SELECT r.name region, w.channel, COUNT(*) n_times
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON w.account_id = a.id
GROUP BY r.name, w.channel
ORDER BY n_times DESC;

/* Use DISTINCT to test if there are any accounts associated with more than one region */
/* The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. */
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

SELECT DISTINCT id, name
FROM accounts;

/* Have any sales reps worked on more than one account */
/* Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query */
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;

/* How many of the sales reps have more than 5 accounts that they manage */
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;
	 
/* How many accounts have more than 20 orders */
SELECT COUNT(*) 
FROM (SELECT a.name
	  FROM accounts a
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY a.name
	  HAVING COUNT(o) > 20) AS Table1;

/* Which account has the most orders */
SELECT MAX(num_orders)
FROM (SELECT a.name, COUNT(o) num_orders
	  FROM accounts a
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY a.name) AS Table1;

SELECT a.name, COUNT(o) num_orders
	  FROM accounts a
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY a.name
	  ORDER BY num_orders DESC
	  LIMIT 1;

/* Which accounts spent more than 30,000 usd total across all orders */
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, o.total_amt_usd
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

/* Which accounts spent less than 1,000 usd total across all orders */
SELECT a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000;

/* Which account has spent the most with us */
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;

/* Which account has spent the least with us */
SELECT a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;

/* Which accounts used facebook as a channel to contact customers more than 6 times */
SELECT a.name, w.channel, COUNT(w.occurred_at) n_times
FROM accounts a
JOIN web_events w
ON a.id= w.account_id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook' AND COUNT(w.occurred_at) > 6
ORDER BY n_times DESC;

/* Which account used facebook most as a channel */
SELECT a.name, w.channel, COUNT(w.occurred_at) n_times
FROM accounts a
JOIN web_events w
ON a.id= w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
ORDER BY n_times DESC
LIMIT 1;

/* Which channel was most frequently used by most accounts */
SELECT w.channel, COUNT(w.occurred_at) n_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY w.channel
ORDER BY n_times DESC
LIMIT 1;

/* Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals */
SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) total_orders
FROM orders
GROUP BY DATE_PART('year', occurred_at)
ORDER BY total_orders;

/* Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset */
SELECT DATE_PART('month', occurred_at), SUM(total_amt_usd) total_orders
FROM orders
GROUP BY DATE_PART('month', occurred_at)
ORDER BY total_orders DESC
LIMIT 10;

/* Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset */
SELECT DATE_PART('year', occurred_at), COUNT(*) total_orders
FROM orders
GROUP BY DATE_PART('year', occurred_at)
ORDER BY total_orders DESC;

/* Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset */
SELECT DATE_PART('month', occurred_at), COUNT(*) total_orders
FROM orders
GROUP BY DATE_PART('month', occurred_at)
ORDER BY total_orders DESC;

/* In which month of which year did Walmart spend the most on gloss paper in terms of dollars */
SELECT MAX(Table1.month_gloss)
FROM(SELECT DATE_PART('year', o.occurred_at), DATE_PART('month', o.occurred_at), SUM(o.gloss_amt_usd) month_gloss, a.name
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY DATE_PART('month', o.occurred_at), DATE_PART('year', o.occurred_at), a.name
	HAVING a.name = 'Walmart'
	ORDER BY DATE_PART('year', o.occurred_at), DATE_PART('month', o.occurred_at))
	AS Table1;

/* Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000 */
SELECT a.id, o.total_amt_usd, CASE WHEN o.total_amt_usd >= 3000 THEN 'Large' ELSE 'Small' END AS lvl_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id;

/* Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000' */
SELECT COUNT(*) AS order_count, CASE 
		WHEN o.total >= 2000 THEN 'At Least 2000'
		WHEN o.total >= 1000 AND o.total < 2000 THEN 'Between 1000 and 2000'
		ELSE 'Less than 1000' END AS size_orders
FROM orders o
GROUP BY 2;

/* We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first */
SELECT a.name, SUM(o.total_amt_usd) AS total_spent, CASE 
			WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
			WHEN SUM(o.total_amt_usd) >= 100000 AND SUM(o.total_amt_usd) <= 200000 THEN '200,000 and 100,000'
			ELSE 'under 100,000' END AS level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent DESC;
			
/* We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first */
SELECT a.name, DATE_PART('year', o.occurred_at), SUM(o.total_amt_usd) AS total_order, CASE 
			WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
			WHEN SUM(o.total_amt_usd) >= 100000 AND SUM(o.total_amt_usd) <= 200000 THEN '200,000 and 100,000'
			ELSE 'under 100,000' END AS level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE DATE_PART('year', o.occurred_at) BETWEEN 2016 AND 2017
GROUP BY a.name, o.occurred_at
ORDER BY total_order DESC;
			
/* We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table */
SELECT s.name, COUNT(*) AS total_orders, CASE 
		WHEN COUNT(*) >= 200  THEN 'top' 
		ELSE 'not' END AS top_sales_rep
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY total_orders DESC;

/* The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria! */
SELECT s.name, COUNT(*) AS total_orders, SUM(total_amt_usd) total_sales, CASE 
		WHEN COUNT(*) >= 200 AND SUM(total_amt_usd) >= 750000 THEN 'top' 
		WHEN (COUNT(*) > 150 OR COUNT(*) < 200) AND (SUM(total_amt_usd) >= 500000 OR SUM(total_amt_usd) < 750000) THEN 'middle'
		ELSE 'low' END AS top_sales_rep
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY total_sales DESC;

/* Find the number of events that occur for each day for each channel, now create a subquery that simply provides all of the data from your first query, Now find the average number of events for each channel.  Since you broke out by day earlier, this is giving you an average per day */
SELECT channel, AVG(num_events) AS avg_events
FROM (SELECT DATE_TRUNC('day', occurred_At) AS day, 
	  channel, COUNT(*) AS num_events
	  FROM web_events
	  GROUP BY DATE_TRUNC('day', occurred_At), channel) AS table1
GROUP BY channel
ORDER BY avg_events DESC;


/* On which day-channel pair did the most events occur */
SELECT DATE_TRUNC('day', occurred_At) as day, channel, COUNT(*) AS num_events
FROM web_events
GROUP BY DATE_TRUNC('day', occurred_At), channel
ORDER BY num_events DESC;

/* Pull the first month/year combo from the orders table Then to pull the average for each */
SELECT AVG(standard_qty) std_avvg, AVG(poster_qty) pst_avg, AVG(gloss_qty) gls_avg, SUM(total_amt_usd) total_spent
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (
	SELECT DATE_TRUNC('month', MIN(occurred_at))
	FROM orders);

/* Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales */
SELECT region, MAX(total_selled) total_amt
FROM (SELECT s.name rep_name, r.name region, SUM(o.total_amt_usd) total_selled
	  FROM region r
	  JOIN sales_reps s
	  ON r.id = s.region_id
	  JOIN accounts a
	  ON a.sales_rep_id = s.id
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY s.name, r.name) AS table1
GROUP BY region;

/* For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed */
SELECT r.name region, SUM(o.total_amt_usd) total_sales, COUNT(o.total) total_orders
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY r.name
ORDER BY total_sales DESC
LIMIT 1;

/* How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer */
SELECT COUNT(*) num_accounts
FROM (SELECT a.name
	 FROM accounts a
	 JOIN orders o
	 ON a.id = o.account_id
	 GROUP BY a.name
	 HAVING SUM(o.total) > (
		 					SELECT total
							FROM (SELECT a.name, SUM(o.standard_qty) as total_std, SUM(o.total) AS total
								  FROM accounts a
								  JOIN orders o
								  ON a.id = o.account_id
								  GROUP BY a.name) AS table2
							ORDER BY total_std DESC
							LIMIT 1
						   )
	 ) AS table1;

/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel */
SELECT table1.name, w.channel, COUNT(w.occurred_at) n_times
FROM web_events w
JOIN (SELECT a.name, a.id id, SUM(o.total_amt_usd) total_spent
	  FROM accounts a
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY a.name, a.id
	  ORDER BY total_spent DESC
	  LIMIT 1) AS table1
ON table1.id = w.account_id
GROUP BY w.channel, table1.name
ORDER BY n_times DESC;

/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts */
SELECT AVG(total_spent)
FROM (SELECT a.name, SUM(o.total_amt_usd) total_spent
	  FROM accounts a
	  JOIN orders o
	  ON a.id = o.account_id
	  GROUP BY a.name
	  ORDER BY total_spent DESC
	  LIMIT 10) AS table1;

/* What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders */
SELECT AVG(total_amt_usd)
FROM orders;
/* AVG of all orders: 3348.0196513310185185 */

SELECT a.name, AVG(o.total_amt_usd) avg_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY avg_spent DESC;

/* Average of the companies spent per order on AVG
"Pacific Life"	19639.936923076923
"Fidelity National Financial"	13753.411250000000
"Kohl's"	12872.165714285714
"State Farm Insurance Cos."	12423.394444444444
*/

SELECT a.name, AVG(o.total_amt_usd) avg_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING AVG(o.total_amt_usd) > (SELECT AVG(total_amt_usd)
							   FROM orders)
ORDER BY avg_spent DESC;

/* The companies that AVG per order is bigger then the AVG per order global:
"Pacific Life"	19639.936923076923
"Fidelity National Financial"	13753.411250000000
*/
SELECT AVG(avg_spent)
FROM(SELECT a.name, AVG(o.total_amt_usd) avg_spent
	 FROM accounts a
	 JOIN orders o
	 ON a.id = o.account_id
	 GROUP BY a.name
	 HAVING AVG(o.total_amt_usd) > (SELECT AVG(total_amt_usd)
									FROM orders)
	 ) AS table1;

/* WITH STATEMENTS INSTEAD OF SUBQUERIES: */

/* Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales */
WITH t1 AS (
	SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
	FROM sales_reps s
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1,2
	ORDER BY 3 DESC),
	
t2 AS (
	SELECT region_name, MAX(total_amt) total_amt
	FROM t1
	GROUP BY 1)

SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

/* For the region with the largest sales total_amt_usd, how many total orders were placed */
WITH t1 AS (
	SELECT r.name region_name, SUM(o.total_amt_usd) total_amt, COUNT(*) total_orders
	FROM sales_reps s
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1
	ORDER BY 2 DESC)
	
SELECT *
FROM t1
LIMIT 1;

/* How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer? */
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
  
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))

SELECT COUNT(*)
FROM t2;

/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel? */
WITH t1 AS (
	SELECT a.id AS id_, SUM(o.total_amt_usd) total_spent
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY a.id
	ORDER BY total_spent DESC
	LIMIT 1
	),
	
	t2 AS (
	SELECT t1.id_, channel, COUNT(occurred_at) n_times
		FROM web_events w
		JOIN t1
		ON t1.id_ = w.account_id
		GROUP BY channel, t1.id_
		ORDER BY n_times DESC
	)
	
SELECT *
FROM t2;

/* What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts */
WITH t1 AS (
	SELECT a.id, SUM(o.total_amt_usd) total_spent
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY a.id
	ORDER BY total_spent DESC
	LIMIT 10
	)
	
SELECT AVG(t1.total_spent)
FROM t1;

/* What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders */
WITH t1 AS (
	SELECT AVG(o.total_amt_usd) total_avg_spent
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	),
	t2 AS (
	SELECT o.account_id, AVG(o.total_amt_usd) AS total_spent
		FROM orders o
		GROUP BY 1
		HAVING AVG(o.total_amt_usd) > (SELECT total_avg_spent FROM t1)	
	)


SELECT AVG(t2.total_spent)
FROM t2;

/* In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. Pull these extensions and provide how many of each website type exist in the accounts table */
WITH t1 AS (
	SELECT website,
	RIGHT(website, 3) AS net_address
	FROM accounts)

SELECT net_address, COUNT(net_address) count_domain
FROM t1
GROUP BY net_address
ORDER BY count_domain;

/* There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number) */
WITH t1 AS(
	SELECT name,
	LEFT(name, 1) AS letter_dist
	FROM accounts
	)

SELECT letter_dist, COUNT(letter_dist)
FROM t1
GROUP BY letter_dist
ORDER BY letter_dist;

/* Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter */
WITH t1 AS (
	SELECT name,
	CASE WHEN LEFT(name, 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 1 ELSE 0 END AS num,
	CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 0 ELSE 1 END AS letter
	FROM accounts
		)
SELECT SUM(num) nums, SUM(letter) letters
FROM t1;

/* Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else */
WITH t1 AS (
	SELECT name,
	CASE WHEN LEFT(UPPER(NAME), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END AS vowels,
	CASE WHEN LEFT(UPPER(NAME), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 0 ELSE 1 END AS not_vowels
	FROM accounts
	)

SELECT SUM(vowels) AS vowels, SUM(not_vowels) AS other_letters
FROM t1;

/* Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc */
SELECT primary_poc,
	POSITION(' ' IN primary_poc) AS space_pos,
	LEFT(primary_poc, POSITION(' ' IN primary_poc) -1) as first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) as last_name
FROM accounts;

/* Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns */
SELECT LEFT(name, POSITION(' ' IN name)) as first_name,
	RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) as last_name
FROM sales_reps;

/* Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com */
WITH t1 AS (
	SELECT primary_poc, name,
	LEFT(primary_poc, POSITION(' ' IN primary_poc) -1) as first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) as last_name
	FROM accounts
	)

SELECT primary_poc,
	name,
	CONCAT(LOWER(first_name),'.',LOWER(last_name),'@',LOWER(name),'.com')
	FROM t1;

/* You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1 */
WITH t1 AS (
	SELECT primary_poc, name,
	LEFT(primary_poc, POSITION(' ' IN primary_poc) -1) as first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) as last_name,
	REPLACE(name, ' ', '_') AS new_name
	FROM accounts
	)

SELECT primary_poc,
	name,
	CONCAT(LOWER(first_name),'.',LOWER(last_name),'@',LOWER(new_name),'.com')
	FROM t1;

/* We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces */
WITH t1 AS (
	SELECT primary_poc, name,
	LEFT(primary_poc, POSITION(' ' IN primary_poc) -1) as first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) as last_name
	FROM accounts
	),
	t2 AS (
	SELECT primary_poc, name,
		LEFT(LOWER(first_name), 1) AS con_pass_1,
		RIGHT(LOWER(first_name), 1) AS con_pass_2,
		LEFT(LOWER(last_name), 1) AS con_pass_3,
		RIGHT(LOWER(last_name), 1) AS con_pass_4,
		LENGTH(first_name) AS con_pass_5,
		LENGTH(last_name) AS con_pass_6,
		REPLACE(UPPER(name), ' ', '') AS con_pass_7
	FROM t1
	)

SELECT primary_poc,
	name,
	con_pass_1 || con_pass_2 || con_pass_3 || con_pass_4 || con_pass_5 || con_pass_6 || con_pass_7 AS password
FROM t2
