-- ============================================================
-- challenge.sql
-- Tool: SQLite (compatible with bais_sqlite_lab.db)
-- Validation: Queries were written against the provided schema
--   and validated by cross-checking join logic, alias usage,
--   and aggregate results for internal consistency (e.g.,
--   confirming department averages match manual spot-checks,
--   and that category revenue sums are non-negative and ordered).
-- ============================================================


-- ============================================================
-- TASK 1: Top 5 Customers by Total Spend
-- Logic: Multiply quantity × unit_price at the item level,
--   sum up to the order, then roll up to the customer.
--   All order statuses are included (no filter applied).
--   Excluding cancelled orders would require a business
--   decision; see INSIGHTS.md for commentary.
-- ============================================================

SELECT
    c.first_name || ' ' || c.last_name   AS customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spend
FROM customers      AS c
JOIN orders         AS o  ON o.customer_id  = c.id
JOIN order_items    AS oi ON oi.order_id    = o.id
GROUP BY
    c.id,
    c.first_name,
    c.last_name
ORDER BY total_spend DESC
LIMIT 5;


-- ============================================================
-- TASK 2: Total Revenue by Product Category (All Orders)
-- Logic: Sum quantity × unit_price at the item level,
--   grouped by the category of the ordered product.
-- ============================================================

SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items    AS oi
JOIN products       AS p  ON p.id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- ============================================================
-- TASK 2 VARIANT: Revenue by Category — Delivered Orders Only
-- Logic: Same as above, restricted to orders with
--   status = 'Delivered' to capture only realized revenue.
-- ============================================================

SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS delivered_revenue
FROM order_items    AS oi
JOIN orders         AS o  ON o.id         = oi.order_id
JOIN products       AS p  ON p.id         = oi.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY delivered_revenue DESC;


-- ============================================================
-- TASK 3: Employees Earning Above Their Department Average
-- Logic: Use a correlated subquery (or CTE) to compute each
--   department's average salary, then compare at the row level.
-- ============================================================

WITH dept_avg AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    e.first_name,
    e.last_name,
    d.name                          AS department_name,
    e.salary                        AS employee_salary,
    ROUND(da.avg_salary, 2)         AS department_avg_salary
FROM employees  AS e
JOIN departments AS d  ON d.id = e.department_id
JOIN dept_avg    AS da ON da.department_id = e.department_id
WHERE e.salary > da.avg_salary
ORDER BY
    d.name      ASC,
    e.salary    DESC;


-- ============================================================
-- TASK 4: Cities with the Most Gold Loyalty Customers
-- Logic: Filter to Gold loyalty level, count per city.
-- ============================================================

SELECT
    city,
    COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY
    gold_customer_count DESC,
    city                ASC;


-- ============================================================
-- TASK 4 EXTENSION: Loyalty Distribution by City
-- Logic: Pivot loyalty counts (Gold / Silver / Bronze) per city
--   using conditional aggregation for geographic comparison.
-- ============================================================

SELECT
    city,
    COUNT(CASE WHEN loyalty_level = 'Gold'   THEN 1 END) AS gold_count,
    COUNT(CASE WHEN loyalty_level = 'Silver' THEN 1 END) AS silver_count,
    COUNT(CASE WHEN loyalty_level = 'Bronze' THEN 1 END) AS bronze_count,
    COUNT(*)                                              AS total_customers
FROM customers
GROUP BY city
ORDER BY
    gold_count   DESC,
    city         ASC;
