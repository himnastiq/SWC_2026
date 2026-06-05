---Question 1---------
SELECT 7 AS month, COUNT(DISTINCT u.user_id) AS monthly_active_users
FROM user_actions u
JOIN user_actions p
  ON u.user_id = p.user_id
WHERE EXTRACT(YEAR FROM u.event_date) = 2022
  AND EXTRACT(MONTH FROM u.event_date) = 7
  AND EXTRACT(YEAR FROM p.event_date) = 2022
  AND EXTRACT(MONTH FROM p.event_date) = 6;
  

---Question 2 -------
WITH annual_spending AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date)::INTEGER AS year,
    product_id,
    SUM(spend) AS curr_year_spend
  FROM user_transactions
  GROUP BY 
    EXTRACT(YEAR FROM transaction_date), 
    product_id
)

SELECT 
  year,
  product_id,
  curr_year_spend,
  LAG(curr_year_spend) OVER (
    PARTITION BY product_id 
    ORDER BY year
  ) AS prev_year_spend,
  ROUND(
    (curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year)) 
    / LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year) 
    * 100.0, 
    2
  ) AS yoy_rate
FROM annual_spending
ORDER BY product_id, year;