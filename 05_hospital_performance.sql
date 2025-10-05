/*
Project: Healthcare Analytics – Hospital Performance Benchmarking
File: 05_hospital_performance.sql
Purpose: Analyze hospital-level readmission scores and compare performance across states and metrics.
Business Value: Supports strategic benchmarking, resource allocation, and identification of underperforming facilities.
*/
-- Average score by state
SELECT state,
       ROUND(AVG(score), 1) AS avg_score
FROM hospital_readmissions
GROUP BY state
ORDER BY avg_score DESC;

-- Hospitals performing worse than national average
SELECT hospital_name, city, state, measure_name, score
FROM hospital_readmissions
WHERE [Compared to National] = 'Worse than the National Average';

-- Trend analysis by measure
SELECT measure_name,
       FORMAT([Measure Start Date], 'yyyy-MM') AS start_month,
       COUNT(*) AS hospital_count
FROM hospital_readmissions
GROUP BY measure_name, FORMAT([Measure Start Date], 'yyyy-MM')
ORDER BY start_month;
