-- ================================================
-- Q1: Identify customers with both funded savings 
--     and funded investment plans, sorted by total deposits
-- ================================================

SELECT 
    u.id AS owner_id,
    u.name,
    
    -- Count of distinct funded savings plans per customer
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.id END) AS savings_count,
    
    -- Count of distinct funded investment plans per customer
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.id END) AS investment_count,
    
    -- Sum of all confirmed deposits (converted from kobo to naira and rounded)
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits

FROM 
    savings_savingsaccount s

-- Join to associate savings transactions with their respective plans
JOIN 
    plans_plan p ON s.plan_id = p.id

-- Join to get user details for each transaction
JOIN 
    users_customuser u ON s.owner_id = u.id

-- Only consider funded plans (positive deposit amount)
WHERE 
    s.confirmed_amount > 0

-- Group by user to aggregate counts and deposit totals
GROUP BY 
    u.id, u.name

-- Ensure user has at least one savings and one investment plan
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.id END) > 0
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.id END) > 0

-- Highlight customers with highest deposits first
ORDER BY 
    total_deposits DESC;
