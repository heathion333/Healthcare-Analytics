/*
Project: Healthcare Analytics – Patient Outcomes & Recovery Trends
File: 02_patient_outcomes.sql
Purpose: Analyze patient recovery metrics and identify readmission patterns.
Business Value: Helps hospitals track recovery efficiency, flag high-risk patients,
and optimize post-discharge care to reduce readmissions.
*/
-- Recovery time in days
SELECT patient_id,
       DATEDIFF(day, admission_date, discharge_date) AS recovery_days
INTO patient_outcomes
FROM stage_patient_data;
-- Identify patients readmitted within 30 days
WITH admissions AS (
    SELECT patient_id, admission_date,
           LEAD(admission_date) OVER (PARTITION BY patient_id ORDER BY admission_date) AS next_admission
    FROM stage_patient_data
)
UPDATE patient_outcomes
SET readmission_flag = CASE
    WHEN DATEDIFF(day, admission_date, next_admission) <= 30 THEN 1
    ELSE 0
END;
-- Outcome categories based on recovery time
UPDATE patient_outcomes
SET outcome_status = CASE
    WHEN recovery_days <= 5 THEN 'Recovered'
    WHEN recovery_days BETWEEN 6 AND 14 THEN 'Complicated'
    ELSE 'Ongoing'
END;
-- Average recovery time by department
SELECT department,
       AVG(DATEDIFF(day, admission_date, discharge_date)) AS avg_recovery_days
FROM stage_patient_data
GROUP BY department;
