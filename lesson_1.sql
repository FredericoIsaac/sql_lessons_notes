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
