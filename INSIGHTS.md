# SQL Challenge — Insights

## Task 1 · Top 5 Customers by Total Spend

- **Lifetime value is highly concentrated.** The top 5 customers likely account for a disproportionate share of total revenue, a classic Pareto pattern. These accounts warrant priority treatment in retention and upsell programs.
- **Status was not filtered.** All order statuses (Pending, Processing, Delivered, Cancelled, etc.) are included in lifetime spend. If cancelled orders do not result in payment, excluding them would give a truer "realized revenue" figure — but without confirmed business rules, filtering was avoided and noted here instead.

---

## Task 2 · Revenue by Product Category

- **Category ranking shifts when restricted to Delivered orders.** Comparing the all-orders run to the Delivered-only variant reveals which categories carry more in-flight or cancelled volume. A category that drops significantly in the Delivered variant has a higher-than-average cancellation or return risk worth investigating.
- **Use unit_price from order_items, not products.price.** Line totals are calculated as `quantity × unit_price` at the item level rather than joining to the current product price, ensuring historical pricing accuracy even if product prices have changed since the order was placed.

---

## Task 3 · Employees Earning Above Department Average

- **Above-average earners are unevenly distributed across departments.** Some departments may surface many above-average earners (indicating a small, highly-paid cluster skewing the mean), while others surface very few (a flatter, more uniform pay band). This signals where compensation review may be warranted.
- **CTE approach keeps the query readable and auditable.** The `dept_avg` CTE computes averages once and is referenced in a clean join, avoiding repeated subqueries and making it straightforward to validate intermediate results.

---

## Task 4 · Cities with the Most Gold Loyalty Customers

- **Gold customer density varies significantly by city.** Cities with the highest Gold counts are strong candidates for loyalty reward events, targeted promotions, or in-person engagement — they represent a concentrated base of high-value customers.
- **The loyalty distribution extension adds strategic nuance.** A city might rank high in Gold customers but also carry a large Bronze base, suggesting strong overall engagement with room to move customers up the loyalty ladder. Conversely, a city with mostly Gold and few Bronze customers may already be saturated with top-tier customers.
- **Tie-breaking by city name** in the Gold ranking ensures deterministic, reproducible results whenever two cities share the same Gold count — important for consistent reporting across runs.

---

## General Data Quality Notes

- **`unit_price` in `order_items` is used as the source of truth** for all revenue calculations (Tasks 1 & 2), not `products.price`. This correctly handles price changes over time and any per-order discounts captured at order time.
- **No NULL handling was required** based on the schema as provided (all join keys are declared as non-nullable). If the real database has optional foreign keys, `LEFT JOIN` with `COALESCE(SUM(...), 0)` should be substituted to avoid silently dropping rows.
