📊 **SQL Assessment for Data Analyst Position**  
MySQL-based solutions for real-world analytics tasks including customer segmentation, inactivity detection, and CLV estimation.  
Designed for clarity, accuracy, and performance.

---

This repository contains solutions to the SQL Proficiency Assessment designed to evaluate the ability to work with relational databases and extract business insights through SQL. Each solution demonstrates proficiency in data querying, aggregation, joins, and analytical logic using clean and efficient MySQL queries.

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


---

## ✅ Assessment_Q1.sql — High-Value Customers with Multiple Products

### **Objective:**
Identify customers who have at least one **funded savings plan** and one **funded investment plan**, and calculate their total deposits.

### **Approach:**
- Joined `savings_savingsaccount`, `plans_plan`, and `users_customuser`.
- Filtered for funded plans (`confirmed_amount > 0`).
- Identified savings plans via `is_regular_savings = 1`, and investment plans via `is_a_fund = 1`.
- Counted distinct savings and investment plans per customer.
- Aggregated total deposits (converted from kobo to naira, rounded to 2 decimal places).
- Used `HAVING` to ensure customers had at least one of each plan type.

### **Challenges:**
- Used conditional aggregation to avoid misclassification.
- Handled monetary conversion and formatting precisely.
- Prevented duplication through distinct transaction counts.

---

## ✅ Assessment_Q2.sql — Transaction Frequency Analysis

### **Objective:**
Segment customers based on their **average number of transactions per month**:

- **High Frequency** (≥10/month)
- **Medium Frequency** (3–9/month)
- **Low Frequency** (≤2/month)

### **Approach:**
- Counted transactions and calculated activity duration using `TIMESTAMPDIFF`.
- Ensured minimum tenure of 1 month to avoid divide-by-zero.
- Categorized users using `CASE` logic based on frequency thresholds.
- Aggregated customers per category and calculated average frequency per group.

### **Challenges:**
- Accounted for same-month users via `GREATEST(..., 1)`.
- Ignored null transaction dates for clean analysis.
- Used `FIELD()` in ordering to control logical output sequence.

---

## ✅ Assessment_Q3.sql — Account Inactivity Alert

### **Objective:**
Identify **active savings or investment plans** with **no transactions in the last 365 days**.

### **Approach:**
- Defined active plans using plan flags (`is_archived`, `is_deleted`, `is_deleted_from_group`).
- Retrieved most recent transaction using `MAX(transaction_date)`.
- Labeled plans as "Savings" or "Investment" using type flags.
- Calculated `inactivity_days` with `DATEDIFF`.
- Filtered for plans with `inactivity_days > 365`.

### **Challenges:**
- Ensured only valid transactions were used to detect inactivity.
- Filtered inactive but valid plans based on business status.
- Guarded against plans with no classification by using a fallback label.

---

## ✅ Assessment_Q4.sql — Customer Lifetime Value (CLV) Estimation

### **Objective:**
Estimate **Customer Lifetime Value (CLV)** using the simplified formula:

CLV = (Total Transactions / Tenure Months) × 12 × (0.1% of Total Value)


### **Approach:**
- Joined transaction and user tables via `owner_id`.
- Calculated total confirmed transaction value and count.
- Derived tenure from `date_joined` to `CURRENT_DATE` using `GREATEST` for robustness.
- Applied the CLV formula and converted values from kobo to naira.
- Rounded monetary results to two decimal places.

### **Challenges:**
- Ensured no division by zero for new users.
- Managed unit conversions carefully (kobo → naira).
- Validated logic using formula decomposition for clarity.

---

## ⚙️ How to Run

Each SQL script can be run independently on a MySQL-compatible database that includes the following tables:

- `users_customuser`
- `plans_plan`
- `savings_savingsaccount`
- `withdrawals_withdrawal`

Ensure that foreign key relationships and sample data are in place before executing queries.

---

## ✍️ Author Notes

All queries were written with readability, performance, and correctness in mind. Please reach out if you need further explanations or improvements.
