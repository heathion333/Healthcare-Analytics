/*
Project: Healthcare Analytics – Patient Outcomes & Recovery Trends
File: 03_recovery_trends.sql
Purpose: Analyze recovery patterns across departments, procedures, and time.
Business Value: Helps hospitals identify bottlenecks, seasonal trends, and areas needing resource optimization.
*/
-- Average recovery time per department
SELECT department,
       COUNT(*) AS patient_count,
       AVG(DATEDIFF(day, admission_date, discharge_date)) AS avg_recovery_days
FROM stage_patient_data
GROUP BY department
ORDER BY avg_recovery_days DESC;

-- Average recovery time per procedure type
SELECT procedure_type,
       COUNT(*) AS procedure_count,
       AVG(DATEDIFF(day, admission_date, discharge_date)) AS avg_recovery_days
FROM stage_patient_data
GROUP BY procedure_type
ORDER BY avg_recovery_days DESC;

-- Monthly average recovery time
SELECT FORMAT(admission_date, 'yyyy-MM') AS month,
       AVG(DATEDIFF(day, admission_date, discharge_date)) AS avg_recovery_days
FROM stage_patient_data
GROUP BY FORMAT(admission_date, 'yyyy-MM')
ORDER BY month;

-- Departments with unusually high recovery times (above 90th percentile)
WITH dept_stats AS (
    SELECT department,
           AVG(DATEDIFF(day, admission_date, discharge_date)) AS avg_recovery_days
    FROM stage_patient_data
    GROUP BY department
),
percentile AS (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY avg_recovery_days) AS p90
    FROM dept_stats
)
SELECT d.department, d.avg_recovery_days
FROM dept_stats d
JOIN percentile p ON d.avg_recovery_days > p.p90;
