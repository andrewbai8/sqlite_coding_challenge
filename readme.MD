# SQL Business Analytics Challenge

## Project Description
This project analyzes a simulated business database using SQL to uncover key insights about customers, products, employees, and sales performance. The goal was to apply real-world data analysis techniques to support better business decision-making.

The project includes multiple queries that focus on revenue generation, customer behavior, employee compensation, and geographic trends.

---

## Technologies Used
- SQL (SQLite)
- Relational Database Concepts
- INNER JOINs
- Aggregations (SUM, AVG, COUNT)
- Common Table Expressions (CTEs)
- GROUP BY and ORDER BY

---

## How to Run the Project
1. Open your SQL environment (SQLite recommended)
2. Load the database file: `bais_sqlite_lab.db`
3. Open the file: `challenge.sql`
4. Run each query by task number
5. Review the outputs to analyze results and insights

---

## Key Insights

### Task 1 · Top 5 Customers by Total Spend
- A small group of customers generates a large portion of total revenue
- All order statuses were included to avoid assuming business rules

### Task 2 · Revenue by Product Category
- Some product categories generate significantly more revenue than others
- Filtering only "Delivered" orders changes category rankings
- Revenue was calculated using `quantity × unit_price` for accuracy

### Task 3 · Employees Above Department Average
- Salary distribution varies across departments
- Some departments have more high earners than others
- A CTE was used to simplify the calculation and comparison

### Task 4 · Cities with Most Gold Loyalty Customers
- Certain cities have a higher concentration of high-value customers
- These locations are strong targets for marketing and retention
- Tie-breaking was added for consistent output ordering

---

## What I Learned
- How to turn business questions into SQL queries
- The importance of using correct transactional data for revenue calculations
- How filtering data impacts insights and decision-making
- How to use CTEs to write cleaner, more readable queries
- How SQL can support real business strategies like marketing and customer retention