
SELECT * FROM bike;
SELECT * FROM customer;
SELECT * FROM membership;
SELECT * FROM membership_type;
SELECT * FROM rental;
 
 
--1. Emily would like to know how many bikes the shop owns by category. 
--Can you get this for her? Display the category name and the number of bikes the shop owns in each category (call this column number_of_bikes ). 
--Show only the categories where the number of bikes is greater than 2 .

SELECT category, Count(*) AS number_of_bikes
FROM bike
GROUP BY category
HAVING Count(*)>2
ORDER BY number_of_bikes;


--2. Emily needs a list of customer names with the total number of memberships purchased by each. 
--For each customer, display the customer's name and the count of memberships purchased (call this column membership_count ). 
--Sort the results by membership_count , starting with the customer who has purchased the highest number of memberships. 
--Keep in mind that some customers may not have purchased any memberships yet. In such a situation, display 0 for the membership_count .
SELECT c.name AS customer_name, COUNT(m.id) AS membership_count
FROM customer c
LEFT JOIN membership m
ON c.id=m.customer_id
GROUP BY c.id
ORDER BY membership_count DESC;

--Question 3: Emily is working on a special offer for the winter months. Can you help her prepare a list of new rental prices? For each bike, display the following:

--id
--category
--old_price_per_hour
--new_price_per_hour
--old_price_per_day
--new_price_per_day
--💸 Discount Rules:
--Electric bikes:
--10% discount on hourly rentals
--20% discount on daily rentals
--Mountain bikes:
--20% discount on hourly rentals
--50% discount on daily rentals
--All other bikes:
--50% discount on both hourly and daily rentals
--Make sure to round all new prices to 2 decimal places.


SELECT id, price_per_hour AS old_price_per_hour, price_per_day AS old_price_per_day,
CASE 
	WHEN category='electric' THEN price_per_hour-(price_per_hour*0.1)
	WHEN category='mountain bike' THEN price_per_hour-(price_per_hour*0.2)
	Else price_per_hour-(price_per_hour*0.5)
	END AS new_price_per_hour,
CASE 
	WHEN category='electric' THEN price_per_day-(price_per_day*0.2)
	WHEN category='mountain bike' THEN price_per_day-(price_per_day*0.5)
	Else price_per_day-(price_per_day*0.5)
	END AS new_price_per_day
FROM bike;

--4. Emily is looking for counts of the rented bikes and of the available bikes in each category. 
--Display the number of available bikes (call this column available_bikes_count) and the number of rented bikes (call this column rented_bikes_count) by bike category.

SELECT
COUNT(CASE WHEN status='available' THEN 1 END) AS available_bikes_count,
COUNT(CASE WHEN status='rented' THEN 1 END) AS rented_bikes_count
FROM bike;

--5. Emily is preparing a sales report. She needs to know the total revenue from rentals by month, by year, and across all years.
SELECT EXTRACT(YEAR FROM start_timestamp) AS year, EXTRACT(MONTH FROM start_timestamp) AS month, SUM(total_paid) AS revenue
FROM rental
GROUP BY EXTRACT(MONTH FROM start_timestamp), EXTRACT(YEAR FROM start_timestamp)
ORDER BY EXTRACT(Year FROM start_timestamp), EXTRACT(MONTH FROM start_timestamp);

--6. Emily has asked you to get the total revenue from memberships for each combination of year, month, and membership type.
SELECT EXTRACT(MONTH FROM m.start_date) AS month, EXTRACT(YEAR FROM m.start_date) AS year, mt.name AS membership_type_name, SUM(m.total_paid) AS total_revenue
FROM membership m
JOIN membership_type mt
ON m.membership_type_id=mt.id
GROUP BY EXTRACT(MONTH FROM m.start_date), EXTRACT(YEAR FROM m.start_date),mt.name
ORDER BY EXTRACT(MONTH FROM m.start_date), EXTRACT(YEAR FROM m.start_date),mt.name;

--8. Emily wants to segment customers based on the number of rentals and see the count of customers in each segment. Use your SQL skills to get this!

WITH CTE AS(
	SELECT customer_id,
	CASE
		WHEN COUNT(customer_id)>10 THEN 'more than 10'
		WHEN COUNT(customer_id) BETWEEN 5 AND 10 THEN 'between 5 and 10'
		ELSE 'fewer than 5'
		END AS rental_count_category
	FROM rental
	GROUP BY customer_id
)

SELECT rental_count_category, COUNT(customer_id) as customer_count
FROM CTE
GROUP BY rental_count_category
ORDER BY COUNT(customer_id);





























