# SQL Challenge — Insights

# this is task 1 · Top 5 Customers by Total Spend

- **A small group of customers drives most of the revenue.** The top 5 customers account for a large portion of total spend, which makes sense — in most businesses, a handful of loyal buyers tend to spend way more than the average customer.
- **I kept all order statuses included.** I didn't filter out cancelled or pending orders because the instructions didn't say to, and I didn't want to assume which statuses count as "real" revenue without knowing the business rules. I noted this just in case it matters.

---

# task 2 · Revenue by Product Category

- **Some categories bring in way more revenue than others.** The results make it easy to see which product categories are performing best, which could help a business decide where to focus marketing or inventory.
- **The Delivered-only version tells a different story.** When I filtered to just Delivered orders, the category ranking shifted a bit. This suggests some categories have more cancelled or unfinished orders, which is worth looking into.
- **I used unit_price from order_items, not the product price.** This is important because prices can change over time — using the price recorded at the time of the order gives more accurate revenue numbers.

---

# task 3 · Employees Earning Above Department Average

- **Not every department has the same number of high earners.** Some departments had several employees above the average, while others had very few. This could mean pay is spread unevenly within certain teams.
- **I used a CTE to calculate department averages first.** This made the query easier to read and debug — I could check the averages separately before comparing them to individual salaries.

---

# Task 4 · Cities with the Most Gold Loyalty Customers

- **Certain cities have a noticeably higher concentration of Gold customers.** These cities are probably the best targets for loyalty perks or special promotions since the most valuable customers are already there.
- **Looking at the full loyalty breakdown by city was helpful.** Some cities have a lot of Gold customers but also a big Bronze base, which means there's room to move people up. Others are mostly Gold already, so the focus there would be on keeping those customers happy.
- **I added a tie-breaker by city name** so the results always come out in the same order if two cities have the same Gold count.

---

## General Notes

- **I calculated revenue as quantity × unit_price at the item level** for both Task 1 and Task 2. This matches how line totals work on a real receipt.
- **I didn't run into any NULL issues** based on the schema, but if the database had missing foreign keys, I'd need to use LEFT JOINs and handle the NULLs carefully so they don't mess up the totals.