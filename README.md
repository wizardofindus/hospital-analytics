Hospital Efficiency & Patient Analytics (SQL + Python + Power BI)

Overview:

This project analyzes hospital operations and patient data to uncover insights that improve efficiency, cost management, and patient outcomes.
It combines SQL (data modeling & querying), Python (EDA & feature engineering), and Power BI (interactive dashboarding) in an end-to-end workflow.

---

Objectives:

* Measure hospital performance using key KPIs
* Analyze patient stay duration and treatment costs
* Identify high-risk patients and readmission patterns
* Optimize department-level resource allocation
* Build a decision-ready dashboard for stakeholders

---

Tech Stack:

* **SQL (MySQL)** → Data storage, transformations, analytics queries
* **Python (Pandas, NumPy, Seaborn, Matplotlib)** → EDA, feature engineering
* **Power BI** → Interactive dashboards and business insights
* **GitHub** → Version control and project presentation

---

Dataset:

* Synthetic hospital dataset simulating real-world patient records
* Includes:

  * Patient demographics (age, gender)
  * Admission & discharge dates
  * Department & diagnosis
  * Treatment cost
  * Readmission flag

---

Data Processing:

### SQL

* Data cleaning (invalid dates, cost filtering)
* Aggregations for KPIs
* Advanced queries using **window functions & ranking**

### Python

* Missing value handling
* Feature engineering:

  * Age groups
  * Stay categories
  * High-risk patient flag
  * Cost per day
* Exploratory Data Analysis (EDA)

---

### Dashboard Features (Power BI)

### KPIs:

* Total Patients
* Average Length of Stay
* Readmission Rate
* Average Treatment Cost

Visual Insights:

* Monthly patient trends
* Department performance
* Cost distribution
* Readmission analysis
* High-risk patient segmentation

---

Dashboard Preview:

<img width="872" height="490" alt="Dashboard" src="https://github.com/user-attachments/assets/b7074aae-abce-4f60-9d42-50f9bdebd701" />


---

Key Insights:

* Patients with longer stays → higher treatment cost and readmission risk
* ICU and Cardiology departments show the highest average costs
* Senior patients (60+) are more likely to be high-risk and readmitted
* Certain departments experience higher patient loads, indicating resource bottlenecks
* Seasonal patterns affect admission rates → useful for staffing decisions

---

Project Structure:

```
hospital-analytics/
│
├── data/                # Raw & cleaned datasets
├── sql/                 # SQL scripts (schema, queries, views)
├── python/              # EDA, feature engineering, pipeline
├── powerbi/             # Power BI dashboard file (.pbix)
├── images/              # Dashboard screenshots
├── README.md
└── requirements.txt
```

Author

Sayan Mukherjee.




