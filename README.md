📊 **SQL Assessment for Data Analyst Position**  
MySQL-based solutions for real-world analytics tasks including customer segmentation, inactivity detection, and CLV estimation.  
Designed for clarity, accuracy, and performance.

---

This repository contains solutions to the SQL Proficiency Assessment designed to evaluate the ability to work with relational databases and extract business insights through SQL. Each solution demonstrates proficiency in data querying, aggregation, joins, filtering, CTEs, business-driven analytical logic using clean and efficient MySQL queries.

## 📁 Repository Structure

<pre>
DataAnalytics-Assessment/
│ 
├── Assessment_Q1.sql │  High-Value Customers with Multiple Products 
├── Assessment_Q2.sql │  Transaction Frequency Analysis 
├── Assessment_Q3.sql │  Account Inactivity Alert 
├── Assessment_Q4.sql │  Customer Lifetime Value (CLV) Estimation 
│
└── README.md         │  Approach, explanation, and challenges </pre>

---

## ✅ Assessment_Q1.sql — High-Value Customers with Multiple Products

### Objective  
Identify customers who have both a **funded savings plan** and a **funded investment plan**, sorted by total deposits.

### Approach  
- Counted distinct funded savings plans (`is_regular_savings = 1`) and funded investment plans (`is_a_fund = 1`) per customer.
- Joined `savings_savingsaccount`, `plans_plan`, and `users_customuser` to extract relevant relationships.
- Filtered for **confirmed transactions only** (`confirmed_amount > 0`).
- Aggregated deposits by summing `confirmed_amount`, converting from **kobo to naira**, and rounding to 2 decimal places.
- Used `HAVING` to retain customers with **at least one of each plan type**.
- Sorted the final result by `total_deposits` in descending order to highlight high-value customers.

### Challenges  
- Making sure plans were accurately classified as savings or investment using boolean flags (`is_regular_savings`, `is_a_fund`), avoiding overlap or mislabeling. 
- Avoiding double-counting by using `DISTINCT` when aggregating plan counts.  
- Converting monetary values from kobo to naira and rounding properly for reporting.  
- Filtering for customers who had both plan types required a thoughtful use of `HAVING` rather than `WHERE`.

---

## ✅ Assessment_Q2.sql — Transaction Frequency Analysis

### Objective  
Segment customers based on how often they transact:

- **High Frequency** (≥10 transactions/month)  
- **Medium Frequency** (3–9 transactions/month)  
- **Low Frequency** (≤2 transactions/month)

### Approach  
- Used `savings_savingsaccount` to count transactions per customer.
- Calculated **tenure in months** by finding the date difference between each customer's first and last transaction.
- Applied `GREATEST(..., 1)` to avoid division by zero for single-month customers.
- Computed `avg_transactions_per_month` and used a `CASE` statement to assign frequency categories.
- Grouped and summarized by frequency category, including count and average frequency.
- Used `FIELD()` to enforce custom sorting order (High → Medium → Low).

### Challenges  
- Handled divide-by-zero risks for customers with activity in a single month using `GREATEST(..., 1)`.  
- Excluded transactions missing dates to avoid skewing results.  
- Built frequency categories with a clean `CASE` expression and ensured logical sorting using `FIELD()`.  
- Had to strike a balance between technical accuracy and business-friendly output.

---

## ✅ Assessment_Q3.sql — Account Inactivity Alert

### Objective  
Identify **active** savings or investment plans that have **not received any transactions** in the last 365 days.

### Approach  
- Found the most recent transaction for each plan using `MAX(transaction_date)`.
- Joined the result with `plans_plan` to access plan details.
- Classified each plan as `Savings`, `Investment`, or `Unknown` based on flags (`is_regular_savings`, `is_a_fund`).
- Calculated `inactivity_days` using `DATEDIFF(CURRENT_DATE, last_transaction_date)`.
- Filtered only **active plans** (i.e., not deleted or archived).
- Selected plans with `inactivity_days > 365` for flagging.

### Challenges  
- Accurately identifying “active” plans meant checking multiple flags (`is_deleted`, `is_archived`, `is_deleted_from_group`).  
- Used `MAX(transaction_date)` to get the latest activity per plan, ensuring only plans with real history were analyzed.  
- Categorizing each plan into “Savings,” “Investment,” or “Unknown” helped simplify the output.  
- Needed to handle plans with no recent activity but still technically valid.

---

## ✅ Assessment_Q4.sql — Customer Lifetime Value (CLV) Estimation

### Objective  
Estimate CLV for each customer using the formula:

CLV = (Total Transactions / Tenure in Months) × 12 × (0.1% of Total Value)

### Approach  
- Aggregated confirmed transactions per user from `savings_savingsaccount`.
- Calculated tenure from `users_customuser.date_joined` to `CURRENT_DATE` in months, ensuring a minimum of 1.
- Computed total transaction value, and applied the formula using:
  - `0.1%` profit per transaction
  - Conversion from **kobo to naira**
  - Rounding to 2 decimal places
- Joined aggregated transaction data with user records.
- Sorted customers in descending order of `estimated_clv`.

### Challenges  
- Prevented errors from low-tenure customers by enforcing a minimum 1-month tenure.  
- Estimated profit using a fixed margin (0.1%) and factored it into CLV calculation.  
- Managed unit conversion from kobo to naira and ensured rounding to 2 decimal places.  
- Ensured that transaction aggregation was scoped only to confirmed deposits (`confirmed_amount > 0`) for consistency.

---

## ⚙️ How to Run

These SQL scripts are written for a MySQL-compatible environment.  
Ensure the following tables exist and are populated:

- `users_customuser`  
- `plans_plan`  
- `savings_savingsaccount`  
- `withdrawals_withdrawal`

No schema modification is required. Each script is self-contained and can be executed independently.

---

## ✍️ Author Notes

This assessment was completed with a focus on clarity, accuracy, and SQL best practices.  
Every solution includes refined inline comments for transparency and reviewability.

Feel free to reach out if you would like further explanation or see optimization opportunities.
