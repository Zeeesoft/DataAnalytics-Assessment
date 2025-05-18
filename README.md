📊 **SQL Assessment for Data Analyst Position**  
MySQL-based solutions for real-world analytics tasks including customer segmentation, inactivity detection, and CLV estimation.  
Designed for clarity, accuracy, and performance.

---

This repository contains solutions to the SQL Proficiency Assessment designed to evaluate the ability to work with relational databases and extract business insights through SQL. Each solution demonstrates proficiency in data querying, aggregation, joins, and analytical logic using clean and efficient MySQL queries.

## Repository Structure

DataAnalytics-Assessment/
│
├── Assessment_Q1.sql # High-Value Customers with Multiple Products
├── Assessment_Q2.sql # Transaction Frequency Analysis
├── Assessment_Q3.sql # Account Inactivity Alert
├── Assessment_Q4.sql # Customer Lifetime Value (CLV) Estimation
└── README.md # Approach, explanation, and challenges


---

## ✅ Assessment_Q1.sql — High-Value Customers with Multiple Products

### Objective:
Identify customers who have both a funded **savings plan** and a funded **investment plan**, and calculate their total deposits.

### Approach:
- Classified savings plans using `is_regular_savings = 1` and investment plans using `is_a_fund = 1`.
- Aggregated deposit amounts (`confirmed_amount`) from `savings_savingsaccount` and linked plans via `plan_id`.
- Counted the number of savings and investment plans per customer and calculated total deposits.
- Converted amounts from **kobo to naira** and **rounded to 2 decimal places**.
- Filtered customers with **at least one** savings and **one** investment plan.
- Sorted by total deposit value.

### Challenges:
- Ensured correct classification of plans.
- Used conditional aggregation and distinct counts to avoid duplication.
- Maintained financial formatting standards with proper conversion and rounding.

---

## ✅ Assessment_Q2.sql — Transaction Frequency Analysis

### Objective:
Segment customers based on their **average number of transactions per month**, and categorize them as:

- **High Frequency** (≥10/month)
- **Medium Frequency** (3–9/month)
- **Low Frequency** (≤2/month)

### Approach:
- Counted transactions per user and measured tenure in months using `TIMESTAMPDIFF` between first and last transaction.
- Enforced a **minimum tenure of 1 month**.
- Calculated `avg_transactions_per_month`, rounded to 2 decimal places.
- Used a `CASE` statement to assign frequency categories.
- Grouped by category to compute the number of customers and average frequency per group.

### Challenges:
- Protected against divide-by-zero errors for short-tenure accounts.
- Excluded null transaction dates.
- Ordered frequency categories logically (High → Medium → Low).

---

## ✅ Assessment_Q3.sql — Account Inactivity Alert

### Objective:
Identify active **savings** or **investment** plans with **no inflow transactions in the last 365 days**.

### Approach:
- Defined active plans as: `is_archived = 0`, `is_deleted = 0`, `is_deleted_from_group = 0`.
- Used `MAX(transaction_date)` to determine the last transaction per plan.
- Classified each plan by type (`Savings` or `Investment`) using flags.
- Calculated `inactivity_days` as the number of days since the last transaction.
- Filtered for `inactivity_days > 365`.

### Challenges:
- Accounted for plans with no recent activity while ensuring historical activity existed.
- Used date difference logic (`DATEDIFF`) for precision.

---

## ✅ Assessment_Q4.sql — Customer Lifetime Value (CLV) Estimation

### Objective:
Estimate **Customer Lifetime Value** using the formula:


Where:
- `avg_profit_per_transaction = 0.1% of transaction value`

### Approach:
- Counted transactions and summed transaction value per user.
- Calculated tenure in months from `date_joined` to `CURRENT_DATE`, using `GREATEST(..., 1)` for robustness.
- Computed `estimated_clv` using the provided formula, with all values converted from **kobo to naira** and **rounded to 2 decimal places**.
- Sorted users by estimated CLV.

### Challenges:
- Ensured accurate unit conversion and rounding.
- Handled low-tenure customers to avoid skewed calculations.

---

## ✅ How to Run

You can run each SQL file independently against a MySQL-compatible database schema that contains the following tables:

- `users_customuser`
- `plans_plan`
- `savings_savingsaccount`
- `withdrawals_withdrawal`

Ensure the schema is populated and relationships are respected before executing the queries.

---

## ✅ Author Notes

All queries were written with readability, performance, and correctness in mind. Please reach out if you need further explanations or improvements.
