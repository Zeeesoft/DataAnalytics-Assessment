-- Identify active plans with no inflow transaction in the last 365 days
WITH latest_transaction AS (
    SELECT 
        s.plan_id,
        MAX(s.transaction_date) AS last_transaction_date
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.plan_id
),
filtered_plans AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Unknown'
        END AS type,
        lt.last_transaction_date,
        DATEDIFF(CURRENT_DATE, lt.last_transaction_date) AS inactivity_days
    FROM 
        plans_plan p
    JOIN 
        latest_transaction lt ON p.id = lt.plan_id
    WHERE 
        p.is_archived = 0 AND 
        p.is_deleted = 0 AND 
        p.is_deleted_from_group = 0
        AND lt.last_transaction_date < DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    inactivity_days
FROM 
    filtered_plans
ORDER BY 
    inactivity_days DESC;
