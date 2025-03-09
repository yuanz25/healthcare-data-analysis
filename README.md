**📊 Project Summary**

This project leverages data from **55,500 patient records** to uncover key factors influencing **hospital costs**, **admissions**, and **patient outcomes**.
Dataset from: https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data

**🎯 Goals**

**1. Optimize Resource Allocation**
Efficiently utilize healthcare resources to improve patient outcomes through identifying factors that influence hospital billing amounts. Pinpoint areas where hospitals can reduce unnecessary expenses.
>
> Key metrics:
>- Average billing amount by medical condition, hospital and admission type
>- Average length of stay by condition 


**2. Patient Demographics & Admission Trends**
> Understand patient demographics to improve services
>
> Key metrics:
> - Patient distribution by age and gender
> - Most common medical conditions by age group
> - Admission type breakdown by gender and hospital
> - Average length of stay by medical condition



**📌 Expected Outcome**
This project transforms data insights into practical recommendations for more **cost-effective hospital management** and better **patient care**.



**Data Dictionary**

| Column Name | Description | Data Type | Example |
| --- | --- | --- | --- |
| **Name** | Patient's full name | String | John Smith |
| **Age** | Patient's age in years | Integer | 45 |
| **Gender** | Patient's gender | String | Male/Female |
| **Blood Type** | Blood group | String | A+, B-, O+ |
| **Medical Condition** | Primary diagnosis | String | Diabetes |
| **Date of Admission** | Hospital entry date | Date | 2024-01-15 |
| **Doctor** | Attending physician | String | Dr. Jones |
| **Hospital** | Treatment facility | String | City Hospital |
| **Insurance Provider** | Insurance company | String | Blue Cross |
| **Billing Amount** | Total charges | Float | 15000.50 |
| **Room Number** | Assigned room | Integer | 302 |
| **Admission Type** | Category of admission | String | Emergency/Routine |
| **Discharge Date** | Exit date | Date | 2024-01-20 |
| **Medication** | Prescribed drugs | String | Insulin |
| **Test Results** | Medical test outcomes | String | Normal |


**1. Data Cleanup & Initial Exploration using Excel/Power Query**

(a) Inspect the **column names and data types**.
- Convert date, number, and currency columns to proper structured format.
- Changed formatting of “Billing Amount” from Numbers > Currency
- Create calculated columns.
  (i) “Age Category” range:
            
            
             0-18 years → Paediatrics
             19-65 years → Adults
             65+ years → Geriatrics #Different hospitals may have different cut-offs
            
            
  (ii) “Length of Stay” column:
            - Ensure both the “Admission Date” and “Discharge Date” columns are in date format
            - New Custom Column: [Discharge Date] - [Admission Date]
            - Under Transform: Change data type to “Days”

        
(b) Detect **inconsistent or strange data**.
- Standardized text formatting (For Name: removed extra spaces using TRIM, converted to “Capitalize Each Word”).
- Standardized number formatting (Billling amount to currency) 
- Examine summary statistics for all variables and identify if any missing values (fill in with appropriate data or remove irrelevant column).
- Noticed multiple records with the same patient names but varying Age, Admission Date, and other details. This was flagged as a **potential data quality issue ** due to inconsistent handling of duplicate entries. Ideally, using a unique identifier such as Admission ID or Visit ID would resolve this issue. Decided not to remove duplicates based solely on Patient Name, since multiple admissions are common for the same patient.
    
      

**📌 More Analytical Questions to explore on with Pivot Tables**
View [here]([url](https://github.com/yuanz25/healthcare-data-analysis/blob/main/Analysing%20Healthcare%20Data%20with%20Pivot%20Tables.xlsx)) for Excel file 

For analysing Operations:
- Is there a correlation between length of stay and billing amount?
- What patterns exist in admission types (emergency vs. routine) across hospitals?
- Are there seasonal trends in hospital admissions?

For analysing Medical Conditions:
- What are the most common medical conditions among different age groups?
- Are specific medical conditions more prevalent in certain demographics (e.g., age, gender)?
- Which medical conditions contribute the most to high hospital costs?
- What is the average billing amount by medical condition?

![Dashboard Analysis](https://github.com/yuanz25/healthcare-data-analysis/blob/main/Exploratory%20Analysis%20using%20Pivot%20Dashboard.png)
**Key Insights**
1.  Admission Trends by Month: Identifies seasonal fluctuations and peak periods. February is usually the lull period.
2.  A scatter plot analysis showing a weak R² value suggests no strong relationship between a patient’s length of stay and their billing amount.
3.  Medical conditions such as Arthritis, Diabetes, and Cancer have the highest admission counts.
4.  Demographic Breakdown by Age & Gender displays not much significant disparities in the prevalence of various medical conditions. 


## 2. Using SQL to do further data cleaning and aggregation 
I’m using Microsoft SQL Server Management Studio. 

**Negative Billing Amounts:** 
- Identified that several entries for Billing Amount were negative, which could be indicative of data errors (refunds, billing adjustments, etc.).
- Removed these entries from the dataset to prevent them from skewing the analysis and visualizations, particularly when focusing on understanding patient costs and billing trends.
- This decision was made with the goal of providing a more accurate representation of the actual charges incurred during hospital stays.


**Duplicate Patient Records:**
- Used Common Table Expression CTE to identify duplicate patient records in the dataset. Duplicates were defined as having the same Name, Date of Admission, Medical Condition, and Insurance Provider. 
- The query revealed **10,977 rows** with duplicates where all columns were identical except for Age, suggesting that these were likely the same patients with inconsistent data entry.
- To resolve this, we decided to retain only the first occurrence of each duplicate record. We used CTE with the ROW_NUMBER() Windows function where the MAX(Age) to keep only the maximum age, assuming it's updated over time.
- After cleaning the duplicates, a query was run to verify that no duplicates remained in the dataset




Key SQL Skills Demonstrated:
**Data Aggregation & Grouping**: Used GROUP BY, COUNT(), AVG(), and SUM() to analyze trends in medical conditions, billing costs, and patient demographics.

**Filtering & Conditional Logic**: Applied WHERE, HAVING, and CASE statements to refine data analysis.

**Date & Time Analysis**: Utilized MONTH(), YEAR(), and DATEDIFF() to track patient admissions and calculate length of stay.

**Joins & Relationships**: Used Self Joins to identify repeat patient admissions and standard INNER JOIN for demographic segmentation.

**Window Functions**: Implemented RANK(), DENSE_RANK(), and PARTITION BY to rank hospitals based on billing costs and compare patient statistics.



**Optimizing Resource Allocation**
- Average Medical Cost by Medical Condition: #1 Obesity $25844, #2 Asthma $25805 #3 Diabetes $25716, #4 HTN $25546, #5 Arthritis $25523, #6 Cancer $25366
- Average Medical Cost by Hospital: #1 PLC Garner $52182, #2 Ruiz-Anthony $52154, #3 George-Gonzalez $52102
- Average Medical cost by Admission Type: #1 Elective $25718, #2 Emergency $25595, #3 Urgent $25583
  
📌 Insight: Chronic conditions like obesity, asthma, and diabetes drive hospital costs, suggesting a **focus on preventive care programs, patient education, and lifestyle interventions** to reduce long-term healthcare spending.

**Patient Demographics & Admission Trends**
- Top Medical Conditions: #1 Arthritis 7059, #2 Diabetes 6953, #3 Cancer 6867  #4 HTN 6858 #5 Obesity 6837, #6 Asthma 6808
- Patient distribution by age: Geriatrics: 12775, Adults 28607
- Patient distribution by gender: Female: 20726, Male 20656 
- Average Length of Stay by Medical Conditon: All conditions had an average LOS of 15 days (could be due to synthetic data. If this were real data, a uniform LOS would indicate rigid hospital policies rather than patient-specific discharge planning, which could be inefficient.) 
