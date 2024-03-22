--Number of impressions in 2022 per age group across Facebook and Instagram
SELECT age_bucket_user,
parent_company,
SUM(impressions) AS total_impressions
FROM meta_revenue 
WHERE years = 2022
GROUP BY
age_bucket_user, 
parent_company
ORDER BY age_bucket_user
;

--Number of conversions been trending (upwards/downwards) for FB for the age bucket 18-24 and 25-34 over the last few yrs
SELECT years,
	SUM(conversions) AS total_conversions
FROM meta_revenue 
WHERE age_bucket_user IN ('18-24', '25-34')
	AND parent_company = 'Facebook'
GROUP BY years
ORDER BY years
;

--conversion-per-click metric for Instagram for the age bucket 18-24 over the last few years
SELECT years,
	SUM(conversions)/SUM(clicks) AS click_per_conversion
FROM meta_revenue 
WHERE age_bucket_user = '18-24'
	AND parent_company = 'Instagram'
GROUP BY years
ORDER BY years
;

-- What is the revenue and number of conversions generated per quarter for the SMB sales team in 2022?
SELECT CASE WHEN dates BETWEEN '2022-01-01' AND '2022-03-31' THEN 'Q1'
    WHEN dates BETWEEN '2022-04-01' AND '2022-06-30' THEN 'Q2'
    WHEN dates BETWEEN '2022-07-01' AND '2022-09-30' THEN 'Q3'
	WHEN dates BETWEEN '2022-10-01' AND '2022-12-31' THEN 'Q4'
    ELSE 'Other'
    END AS quarter,
	SUM(revenue) AS total_revenue,
    SUM(conversions) AS total_conversions
FROM meta_revenue
WHERE years = 2022 
	AND sales_team LIKE '%SMB%'
GROUP BY quarter
ORDER BY quarter
;

-- Avg revenue per generated per quarter for the SMB sales team in 2022
SELECT CASE WHEN dates BETWEEN '2022-01-01' AND '2022-03-31' THEN 'Q1'
     WHEN dates BETWEEN '2022-04-01' AND '2022-06-30' THEN 'Q2'
	WHEN dates BETWEEN '2022-07-01' AND '2022-09-30' THEN 'Q3'
     WHEN dates BETWEEN '2022-10-01' AND '2022-12-31' THEN 'Q4'
     ELSE 'Other'
    END AS quarter,
	SUM(revenue)/COUNT(DISTINCT ad_id) AS avg_revenue
FROM meta_revenue
WHERE years = 2022 
	AND sales_team LIKE '%SMB%'
GROUP BY quarter
ORDER BY quarter
;


/*Total revenue, total conversions, total clicks, conversions per click, average revenue per conversion 
for the top 10 clients witth highest revenue in 2022*/
SELECT client_id,
	SUM(revenue) AS total_revenue,
    SUM(conversions) AS total_conversions,
    SUM(clicks) AS total_clicks,
    SUM(conversions)/SUM(clicks) AS conversion_per_click,
    SUM(revenue)/SUM(conversions) AS average_revenue_per_conversion
FROM meta_revenue
WHERE years = 2022 
GROUP BY client_id
ORDER BY total_revenue DESC

LIMIT 10
;

