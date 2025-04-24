-- 1. Retrieve all customer names and their email addresses.
SELECT full_name AS customer_name, email AS email_adresses FROM customers;


-- 2. Get a list of products with aliases: product_name as Item and price as Cost.
SELECT product_name AS Item, price AS cost FROM products;



-- 3. Find all products in the 'Beverages' category.
SELECT * 
FROM products
WHERE category='Beverages';


-- 4. Show all products that cost more than $5.
SELECT * 
FROM products
WHERE price>5;


-- 5. Retrieve all orders with total amount greater than or equal to $10.
SELECT * 
FROM orders
WHERE total_amount>=10;


-- 6. Are there any customers without phone numbers?
SELECT * 
FROM customers
WHERE phone IS NULL;


-- 7. Find all products priced between $3 and $6.
SELECT * 
FROM products
WHERE price BETWEEN 3 AND 6;

SELECT * 
FROM products
WHERE price>=3 AND price<=6;



-- 8. Find products named 'French Fries', 'Veg Burger', or 'Margherita Pizza'.
SELECT * 
FROM products
WHERE product_name IN ('French Fries', 'Veg Burger', 'Margherita Pizza');

SELECT * 
FROM products
WHERE product_name='French Fries' OR product_name='Veg Burger' OR product_name='Margherita Pizza';


-- 9. Find customers whose name starts with ‘A’.
SELECT * 
FROM customers
WHERE full_name LIKE 'A%';

----9.A Find customers whose name ends with ‘A’.
SELECT * 
FROM customers
WHERE full_name LIKE '%A';

----9.B Find customers whose name starts with ‘A’ and ends with ‘A’.
SELECT * 
FROM customers
WHERE full_name LIKE '%A%';

----9.C Find customers whose name second digit is ‘A’ .
SELECT * 
FROM customers
WHERE full_name LIKE '_a%';


-- 10. List all customers who have placed at least one order.
SELECT * 
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);


-- 11. Find all orders that are not in 'Delivered' status.
SELECT * 
FROM orders
WHERE status NOT IN (SELECT status
						FROM orders
						WHERE status='Delivered');
	
SELECT * 
FROM orders
WHERE status IN ('Confirmed', 'Shipped', 'Pending', 'Cancelled');

SELECT * 
FROM orders
WHERE status !='Delivered';


-- 12. Show products that are not priced between $4 and $6.
SELECT * 
FROM products
WHERE price<4 OR price>6;

SELECT * 
FROM products
WHERE price NOT BETWEEN 4 AND 6;


-- 13. List products not in 'Main Course', 'Snacks', or 'Beverages' categories.
SELECT * 
FROM products
WHERE category NOT IN ('Main Course', 'Snacks','Beverages');


-- 14. Find customers whose names don’t start with ‘S’.
SELECT * 
FROM customers
WHERE full_name NOT LIKE 'S%';

-- 15. Find 'total_price' for each order item
SELECT *, (quantity*unit_price) AS total_price
FROM order_items;


-- 16. List the top 10 most expensive products, sorted descending by price.
SELECT * 
FROM products
Order BY price DESC
LIMIT 10;


-- 17. Show customers sorted alphabetically by name.
SELECT * 
FROM customers
ORDER BY full_name;

-- 18. Show the 5 most recent customers based on 'created_at'.
SELECT * 
FROM customers
ORDER BY created_at DESC
LIMIT 5;

-- 19. Display any 3 random products.
SELECT * 
FROM products
Order BY RANDOM()
LIMIT 3;