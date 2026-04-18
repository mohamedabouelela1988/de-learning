-- Phase 1 Day 4 — JOINs, UNION, Subqueries

-- INNER JOIN: orders with customer details
SELECT o.order_id, o.customer, c.email, c.tier, o.total
FROM orders o
INNER JOIN customers c ON o.customer = c.customer_name;

-- LEFT JOIN: all customers even with no orders
SELECT c.customer_name, c.tier, COUNT(o.order_id) AS orders,
       COALESCE(SUM(o.total), 0) AS revenue
FROM customers c
LEFT JOIN orders o ON c.customer_name = o.customer
GROUP BY c.customer_name, c.tier ORDER BY revenue DESC;

-- LEFT JOIN anti-pattern: customers with no orders
SELECT c.customer_name, c.email FROM customers c
LEFT JOIN orders o ON c.customer_name = o.customer
WHERE o.order_id IS NULL;

-- FULL OUTER: reconciliation
SELECT c.customer_name AS in_customers, o.customer AS in_orders
FROM customers c
FULL OUTER JOIN orders o ON c.customer_name = o.customer
WHERE c.customer_name IS NULL OR o.customer IS NULL;

-- SELF JOIN: employee + manager
SELECT e.emp_name AS employee, e.role, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- UNION ALL: combining datasets
SELECT 'Q1' AS quarter, customer, total FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-03-31'
UNION ALL
SELECT 'Q2', customer, total FROM orders
WHERE order_date BETWEEN '2024-04-01' AND '2024-06-30'
ORDER BY quarter;

-- Subquery in WHERE
SELECT order_id, customer, total FROM orders
WHERE customer IN (SELECT customer_name FROM customers WHERE tier = 'gold');
