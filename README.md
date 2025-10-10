# Healthcare-Analytics
# Healthcare Analytics: Patient Outcomes & Risk Tracker

This repository showcases SQL-driven insights into patient visit patterns, recovery trends, and risk stratification. Built with real-world healthcare logic, it supports hospital administrators in identifying high-risk patients, reducing readmissions, and optimizing care delivery.

## Project Overview

- **Dataset**: Simulated patient visit records with status, procedure, department, and cost
- **Focus**: Missed appointments, recovery time, readmission flags, and patient risk levels
- **Tools Used**: SQL (PostgreSQL), Tableau (optional), Markdown commentary

## Business Logic

This project models how hospitals can use data to improve patient outcomes and operational efficiency:

- Patients who miss multiple appointments are flagged as **High Risk**
- Recovery time is calculated from admission to discharge
- Readmissions within 30 days are flagged for follow-up
- Outcome status is classified as `Recovered`, `Complicated`, or `Ongoing`
- Trends are tracked by department, procedure, and month

This logic supports:
- Reducing missed appointments and readmissions
- Prioritizing patient follow-up and discharge planning
- Modeling cost impact of delayed or missed care
- Strategic resource allocation based on recovery trends

## Repository Structure

## Dashboards

Explore recruiter-facing Tableau dashboards built from SQL logic and healthcare performance data:

- **Hospital Score Explorer**  
  Highlights top-performing hospitals based on readmission scores.  
  [View on Tableau Public](https://public.tableau.com/app/profile/marcus.wright5122/viz/HospitalScoreExplorer/HospitalScoreExplorer)
https://public.tableau.com/app/profile/marcus.wright5122/viz/HospitalPerformanceBenchmarking/HospitalPerformanceBenchmarking
