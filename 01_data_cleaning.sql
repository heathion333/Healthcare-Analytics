/*
Project: Healthcare Analytics – Patient Outcomes & Recovery Trends
File: 01_data_cleaning.sql
Purpose: Standardize and prepare raw patient data for analysis.
Business Value: Ensures accuracy in reporting recovery times, readmission rates,
and treatment outcomes by removing duplicates, handling nulls, and normalizing formats.
*/

-- Preview raw patient data
SELECT TOP 10 *
FROM raw_patient_data;

-- Remove duplicate patient records based on patient_id + admission_date
WITH deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY patient_id, admission_date ORDER BY last_update DESC) AS rn
    FROM raw_patient_data
)
SELECT *
INTO stage_patient_data
FROM deduped
WHERE rn = 1;

-- Replace missing discharge_date with placeholder for ongoing patients
UPDATE stage_patient_data
SET discharge_date = '2099-12-31'
WHERE discharge_date IS NULL;

-- Ensure date formats are consistent
ALTER TABLE stage_patient_data
ALTER COLUMN admission_date DATE;

ALTER TABLE stage_patient_data
ALTER COLUMN discharge_date DATE;

-- Quick check: no duplicate patient_id + admission_date combos remain
SELECT patient_id, admission_date, COUNT(*) AS record_count
FROM stage_patient_data
GROUP BY patient_id, admission_date
HAVING COUNT(*) > 1;
