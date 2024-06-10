use sakila;

# --> 1

SELECT first_name, last_name, email
FROM customer;

# --> 2
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name;

# --> 3
#Write the query using multiple join statements
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';

# --> 4
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer c
WHERE customer_id IN (
SELECT customer_id
FROM rental
WHERE inventory_id IN (
SELECT inventory_id
FROM inventory
WHERE film_id IN (
SELECT film_id
FROM film
WHERE film_id IN (
SELECT film_id
FROM film_category
WHERE category_id IN (
SELECT category_id
FROM category
WHERE name = 'Action'
)))))
;

# --> 5
SELECT payment_id, amount,
CASE
WHEN amount BETWEEN 0 AND 2 THEN 'low'
WHEN amount BETWEEN 2 AND 4 THEN 'medium'
ELSE 'high'
END AS label
FROM payment;