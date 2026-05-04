# SQL Challenge — Insights

## Task 1 · Top 5 Customers by Total Spend

- **Revenue is highly concentrated among a small group of customers.** The top 5 customers contribute a significant share of total revenue, reflecting a common pattern where a small portion of customers drives the majority of sales.
- **All order statuses were included in the analysis.** Orders were not filtered by status (e.g., cancelled or pending) to avoid making assumptions about what qualifies as recognized revenue without defined business rules.

---

## Task 2 · Revenue by Product Category

- **Revenue varies significantly across product categories.** Some categories outperform others, highlighting where the business may want to prioritize marketing, inventory, or expansion efforts.
- **Filtering to delivered orders changes the results.** When limiting the analysis to only "Delivered" orders, category rankings shift, suggesting that certain categories may have higher rates of cancellations or incomplete orders.
- **Transaction-level pricing improves accuracy.** Revenue was calculated using `unit_price` from `order_items` rather than the product table to ensure accuracy, since prices can change over time.

---

## Task 3 · Employees Earning Above Department Average

- **Salary distribution differs across departments.** Some departments have multiple employees earning above the average, while others have very few, indicating potential differences in compensation structure or role distribution.
- **Using a CTE improved clarity and structure.** Department averages were calculated separately using a CTE, making the query easier to read, validate, and debug.

---

## Task 4 · Cities with the Most Gold Loyalty Customers

- **High-value customers are concentrated in specific cities.** Certain locations have a higher number of Gold-tier customers, making them strong targets for retention strategies and loyalty programs.
- **City-level loyalty breakdown provides deeper insight.** Some cities have a mix of loyalty levels, indicating opportunities to convert lower-tier customers, while others are already heavily concentrated with Gold customers and may benefit more from retention efforts.
- **Consistent ordering was ensured with a tie-breaker.** A secondary sort by city name was added to maintain consistent results when counts are equal.

---

## General Notes

- **Revenue was calculated as `quantity × unit_price` at the item level.** This reflects how real-world transactions are recorded and ensures more accurate analysis.
- **No NULL issues were encountered in this dataset.** However, in cases with missing relationships, LEFT JOINs and proper NULL handling would be necessary to prevent inaccurate totals.