-- Find customers with at least one funded savings and one funded investment plan
SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100.0, 2) AS total_deposits -- rounded to 2 decimal places
FROM 
    savings_savingsaccount s
JOIN 
    plans_plan p ON s.plan_id = p.id
JOIN 
    users_customuser u ON s.owner_id = u.id
WHERE 
    s.confirmed_amount > 0
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN s.id END) > 0
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN s.id END) > 0
ORDER BY 
    total_deposits DESC;
