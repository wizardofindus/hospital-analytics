CREATE DATABASE hospital_analytics;
USE hospital_analytics;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    department VARCHAR(50),
    diagnosis VARCHAR(100),
    admission_date DATE,
    length_of_stay INT,
	discharge_date DATE,
    treatment_cost FLOAT,
    readmitted INT,
    month_ VARCHAR(20),
    day_name VARCHAR(20),
    age_group VARCHAR(20),
    stay_category VARCHAR(20),
    cost_category VARCHAR(20),
    year_ INT,
    month_num INT,
    weekend BOOLEAN,
    high_risk INT,
    dept_load_index FLOAT,
    cost_per_day FLOAT
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/USER/Documents/cleaned_hospital_data.csv'
INTO TABLE patients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from patients;

select count(*) from patients;

#Total Patients:

SELECT COUNT(*) AS total_patients FROM patients;

# Avg Length of Stay:

SELECT AVG(length_of_stay) AS avg_stay FROM patients;

# Readmission Rate:

SELECT 
  ROUND(SUM(readmitted)/COUNT(*) * 100, 2) AS Percentage_readmission_rate
FROM patients;

#Avg Treatment Cost:

SELECT AVG(treatment_cost) AS avg_cost FROM patients;

#High-Risk Patients:

SELECT COUNT(*) AS high_risk_patients
FROM patients
WHERE high_risk = 1;

#Time-Based Analysis:

# Monthly Admissions Trend:

SELECT 
  DATE_FORMAT(admission_date, '%Y-%m') AS month,
  COUNT(*) AS total_admissions
FROM patients
GROUP BY month
ORDER BY month;

# Day of Week Analysis:

SELECT 
  DAYNAME(admission_date) AS day,
  COUNT(*) AS admissions
FROM patients
GROUP BY day
ORDER BY admissions DESC;

# Department Performance:

# Patients by Department:

SELECT 
  department,
  COUNT(*) AS total_patients
FROM patients
GROUP BY department
ORDER BY total_patients DESC;

# Avg Cost by Department:

SELECT 
  department,
  ROUND(AVG(treatment_cost),2) AS avg_cost
FROM patients
GROUP BY department
ORDER BY avg_cost DESC;

# Avg Stay by Department:

SELECT 
  department,
  AVG(length_of_stay) AS avg_stay
FROM patients
GROUP BY department;

# Readmission Analysis:

# Readmission by Age Group:

SELECT 
  age_group,
  COUNT(*) AS total,
  SUM(readmitted) AS readmissions,
  ROUND(SUM(readmitted)/COUNT(*) * 100,2) AS rate
FROM patients
GROUP BY age_group
order by rate desc;

# Insight: Senior age patients have highest re-admission tendency.

# Readmission by Department:

SELECT 
  department,
  ROUND(SUM(readmitted)/COUNT(*) * 100,2) AS readmission_rate
FROM patients
GROUP BY department
ORDER BY readmission_rate DESC;

# Cost Analysis:

# Cost by Stay Category:

SELECT 
  stay_category,
  AVG(treatment_cost) AS avg_cost
FROM patients
GROUP BY stay_category
order by avg_cost desc;

# Insight: treatment cost increases as length of stay increases.

# Top Expensive Patients(Top 10):

SELECT *
FROM patients
ORDER BY treatment_cost DESC
LIMIT 10;

# Cost per Day Analysis:

SELECT 
  department,
  AVG(cost_per_day) AS avg_cost_per_day
FROM patients
GROUP BY department
order by avg_cost_per_day desc;

# Insight: ICU department has the highest cost per day,General department has the lowest.


# Advanced Business Queries:

# High-Risk Pattern Detection:

SELECT 
  department,
  COUNT(*) AS high_risk_count
FROM patients
WHERE high_risk = 1
GROUP BY department
ORDER BY high_risk_count DESC;

# Department Load vs Cost:

SELECT 
  department,
  AVG(dept_load_index) AS load_index,
  AVG(treatment_cost) AS avg_cost
FROM patients
GROUP BY department;


# Patient Segmentation:

SELECT 
  age_group,
  stay_category,
  COUNT(*) AS patient_count
FROM patients
GROUP BY age_group, stay_category
order by patient_count desc;


# Advanced SQL (Window Functions + Ranking):

# Top Expensive Patients,top 20 (RANK):

SELECT 
    patient_id,
    treatment_cost,
    DENSE_RANK() OVER (ORDER BY treatment_cost DESC) AS Rank_of_patient
FROM patients limit 20;

# Rank Patients Within Each Department(Top 5 per department treatment cost wise):

with CTE as (
SELECT 
    patient_id,
    department,
    treatment_cost,
    RANK() OVER (
        PARTITION BY department 
        ORDER BY treatment_cost DESC
    ) AS dept_rank
FROM patients
)

select * from CTE where dept_rank <=5;

# Running Cost Over Time:

SELECT 
    admission_date,
    SUM(treatment_cost) OVER (
        ORDER BY admission_date
    ) AS cumulative_cost
FROM patients;

# Monthly Running Patients:

SELECT 
    DATE_FORMAT(admission_date, '%Y-%m') AS month,
    COUNT(*) AS monthly_patients,
    SUM(COUNT(*)) OVER (
        ORDER BY DATE_FORMAT(admission_date, '%Y-%m')
    ) AS cumulative_patients
FROM patients
GROUP BY month;

# Flag High-Cost Outliers:

SELECT *
FROM (
    SELECT 
        *,
        AVG(treatment_cost) OVER (PARTITION BY department) AS dept_avg
    FROM patients
) t
WHERE treatment_cost > dept_avg * 1.5;

# Compare with Previous Admission Cost:

SELECT 
    patient_id,
    admission_date,
    treatment_cost,
    LAG(treatment_cost) OVER (ORDER BY admission_date) AS prev_cost
FROM patients
group by patient_id;


# Growth in Cost:

SELECT 
    admission_date,
    treatment_cost,
    treatment_cost - LAG(treatment_cost) OVER (ORDER BY admission_date) AS cost_diff
FROM patients;
