-- ================================================
-- Q2: Classify customers by average transaction frequency
--     and group them into frequency categories
-- ================================================

WITH customer_transactions AS (
    --CTE to Get transaction count and activity window per customer
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        MIN(DATE(s.transaction_date)) AS first_transaction,
        MAX(DATE(s.transaction_date)) AS last_transaction
    FROM 
        savings_savingsaccount s
    WHERE 
        s.transaction_date IS NOT NULL
    GROUP BY 
        s.owner_id
),

transactions_per_month AS (
    -- Calculate tenure in months and average monthly frequency
    SELECT 
        c.owner_id,
        u.name,
        c.total_transactions,
        GREATEST(TIMESTAMPDIFF(MONTH, c.first_transaction, c.last_transaction), 1) AS tenure_months,
        ROUND(c.total_transactions / GREATEST(TIMESTAMPDIFF(MONTH, c.first_transaction, c.last_transaction), 1), 2) AS avg_transactions_per_month
    FROM 
        customer_transactions c
    JOIN 
        users_customuser u ON u.id = c.owner_id
),

categorized AS (
    -- Categorize customers based on transaction frequency
    SELECT 
        *,
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        transactions_per_month
)

-- Aggregate results by frequency category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM 
    categorized
GROUP BY 
    frequency_category
-- Ensure logical display order
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
