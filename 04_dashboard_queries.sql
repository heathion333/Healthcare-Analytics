/*
Project: Healthcare Analytics – Patient Outcomes & Recovery Trends
File: 04_dashboard_queries.sql
Purpose: Generate visual-ready metrics for dashboards tracking patient recovery and risk.
Business Value: Enables hospital leaders to monitor performance, identify trends, and act on high-risk patterns in real time.
*/
-- KPI: Overall average recovery time
SELECT ROUND(AVG(DATEDIFF(day, admission_date, discharge_date)), 1) AS avg_recovery_days
FROM stage_patient_data;
-- KPI: % of patients readmitted within 30 days
SELECT ROUND(100.0 * SUM(CASE WHEN readmission_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmission_rate_pct
FROM patient_outcomes;
-- Monthly trend of average recovery time
SELECT FORMAT(admission_date, 'yyyy-MM') AS month,
       ROUND(AVG(DATEDIFF(day, admission_date, discharge_date)), 1) AS avg_recovery_days
FROM stage_patient_data
GROUP BY FORMAT(admission_date, 'yyyy-MM')
ORDER BY month;
-- Recovery time by department
SELECT department,
       ROUND(AVG(DATEDIFF(day, admission_date, discharge_date)), 1) AS avg_recovery_days
FROM stage_patient_data
GROUP BY department
ORDER BY avg_recovery_days DESC;
-- Distribution of patient outcome statuses
SELECT outcome_status,
       COUNT(*) AS patient_count
FROM patient_outcomes
GROUP BY outcome_status;
