-- Query 1: List all customers who live in Texas
SELECT c.first_name, c.last_name, a.address
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'Texas';

-- Query 2: Get all payments above $6.99 with the Customer's Full Name
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, p.amount
FROM payment AS p
JOIN customer AS c ON p.customer_id = c.customer_id
WHERE p.amount > 6.99;

-- Query 3: Show all customers' names who have made payments over $175
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE c.customer_id IN (
    SELECT p.customer_id
    FROM payment AS p
    GROUP BY p.customer_id
    HAVING SUM(p.amount) > 175
);

-- Query 4: List all customers that live in Nepal
SELECT c.first_name, c.last_name
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
WHERE ci.city = 'Nepal';

-- Query 5: Which staff member had the most transactions?
SELECT s.first_name, s.last_name, COUNT(r.rental_id) AS transaction_count
FROM staff AS s
JOIN rental AS r ON s.staff_id = r.staff_id
GROUP BY s.staff_id
ORDER BY transaction_count DESC
LIMIT 1;

-- Query 6: How many movies of each rating are there?
SELECT f.rating, COUNT(f.film_id) AS count
FROM film AS f
GROUP BY f.rating;

-- Query 7: Show all customers who have made a single payment above $6.99
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE EXISTS (
    SELECT 1
    FROM payment AS p
    WHERE p.customer_id = c.customer_id AND p.amount > 6.99
    GROUP BY p.customer_id
    HAVING COUNT(p.payment_id) = 1
);

-- Query 8: How many free rentals did our store give away?
SELECT COUNT(*) AS free_rentals_count
FROM payment
WHERE amount = 0.00;
