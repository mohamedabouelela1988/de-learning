-- Phase 1 Day 3 — SQL Foundations
-- Database: de_learning | Table: orders

-- Table creation
-- (see Day 3 lesson notes)

-- SELECT basics
SELECT customer, product, total FROM orders;

-- Filtering
SELECT * FROM orders WHERE status = 'completed' AND country = 'Egypt';
SELECT * FROM orders WHERE country IN ('Saudi Arabia', 'UAE');
SELECT * FROM orders WHERE total BETWEEN 100 AND 500;
SELECT * FROM orders WHERE product LIKE '%Book';
SELECT * FROM orders WHERE status IS NULL;

-- Sorting and limiting
SELECT customer, product, total FROM orders ORDER BY total DESC LIMIT 5;

-- Aggregations
SELECT category, SUM(total) AS revenue FROM orders GROUP BY category ORDER BY revenue DESC;
SELECT country, COUNT(*) AS orders FROM orders GROUP BY country HAVING COUNT(*) > 3;
