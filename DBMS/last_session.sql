--Question 1
SELECT 
    EXTRACT(MONTH FROM submit_date) AS mth, 
    product_id AS product, 
    AVG(stars)::NUMERIC(10,2) AS avg_stars
FROM 
    reviews 
GROUP BY 
    EXTRACT(MONTH FROM submit_date), 
    product_id;

--Question 2
WITH Yearly_Spend AS (
  -- Step 1: Get the total spend per product for each year
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    SUM(spend) AS curr_year_spend
  FROM 
    user_transactions
  GROUP BY 
    EXTRACT(YEAR FROM transaction_date), 
    product_id
),
Lagged_Spend AS (
  -- Step 2: Use LAG() to fetch the previous year's total spend
  SELECT 
    year,
    product_id,
    curr_year_spend,
    LAG(curr_year_spend, 1) OVER (
      PARTITION BY product_id 
      ORDER BY year
    ) AS prev_year_spend
  FROM 
    Yearly_Spend
)

-- Step 3: Calculate the YoY growth rate and format the output
SELECT 
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND(
    ((curr_year_spend - prev_year_spend) / prev_year_spend) * 100.0, 
    2
  ) AS yoy_rate
FROM 
  Lagged_Spend
ORDER BY 
  product_id, 
  year ASC;

-- Question 3
SELECT 
  sender_id,
  COUNT(message_id) AS message_count
FROM 
  messages
WHERE 
  EXTRACT(MONTH FROM sent_date) = 8 
  AND EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY 
  sender_id
ORDER BY 
  message_count DESC
LIMIT 2;
