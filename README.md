**📊 Project Summary**

This project leverages data from **55,500 synthetic patient hospitalization records** to uncover key factors influencing **hospital costs**, **admissions**, and **patient outcomes**.
Dataset from: https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data

**🎯 Goals**

**1. Optimize Resource Allocation**

> Identify areas to reduce healthcare costs.
> 
> Key metrics:
> - Average billing amount by medical condition, hospital and admission type


**2. Patient Demographics & Admission Trends**
> Understand patient demographics to pinpoint areas for improving patient care.
>
> Key metrics:
> - Admission count by medical condition
> - Patient distribution by age and gender
> - Average length of stay by medical condition



**📌 Expected Outcome**
This project transforms data insights into practical recommendations for more cost-effective hospital management and better patient care.



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

---

**1. Data Cleanup & Initial Exploration using Excel/Power Query**

(a) Inspect the **column names and data types** 
- Determine key columns to work with.
- Examine summary statistics for all variables and identify if any missing values (fill in with appropriate data or remove irrelevant column).

- Create calculated columns.
  (i) “Age Category” range:
            
            
             0-18 years → Paediatrics
             19-65 years → Adults
             65+ years → Geriatrics #Different hospitals may have different cut-offs
            
            
  (ii) “Length of Stay” column:
            - Ensure both the “Admission Date” and “Discharge Date” columns are in date format
            - New Custom Column: [Discharge Date] - [Admission Date]
            - Under Transform: Change data type to “Days”

        
(b) Detect **inconsistent data**.
- Standardized text formatting (For Name: removed extra spaces using TRIM, converted to “Capitalize Each Word”) and number formatting (Billling amount to currency) 

- Noticed multiple records with the same patient names but varying Age, Admission Date, and other details. This was flagged as a **potential data quality issue** due to inconsistent handling of duplicate entries. Ideally, using a unique identifier such as Admission ID or Visit ID would resolve this issue. Decided not to remove duplicates based solely on Patient Name at this step, since multiple admissions are possible for the same patient.
    
      

## 2. Using SQL to do further data cleaning and aggregation 
I’m using Microsoft SQL Server Management Studio. 

**Negative Billing Amounts:** 
- Identified that 108 data entries for Billing Amount were negative, which could be indicative of data errors (refunds, billing adjustments, etc.).
- Removed these entries from the dataset to prevent them from skewing the analysis and visualizations, particularly when focusing on understanding patient costs and billing trends.
- This decision was made with the goal of providing a more accurate representation of the actual charges incurred during hospital stays, although it would not make much of an impact as it only consists of 0.2% of dataset.


**Duplicate Patient Records:**
- Used Common Table Expression CTE and Self-Join to identify duplicate patient records in the dataset. Duplicates were defined as having the same Name, Date of Admission, Medical Condition, and Insurance Provider by using GROUPBY function. 
- The query revealed **10,977 rows** with duplicates where all columns were identical except for Age, suggesting that these were likely the same patients with inconsistent data entry.
- To resolve this, we decided to retain only the first occurrence of each duplicate record. We used CTE with the ROW_NUMBER() Windows function where the MAX(Age) to keep only the maximum age, assuming it's updated over time.
- After cleaning the duplicates, a query was run to verify that no duplicates remained in the dataset.



Key SQL Skills Demonstrated:
**Data Aggregation & Grouping**: Used GROUP BY, COUNT(), AVG(), and SUM() to analyze trends in medical conditions, billing costs, and patient demographics.

**Filtering & Conditional Logic**: Applied WHERE, HAVING, and CASE statements to refine data analysis.

**Date & Time Analysis**: Utilized MONTH(), YEAR(), and DATEDIFF() to track patient admissions and calculate length of stay.

**Joins & Relationships**: Used Self Joins to identify repeat patient admissions and standard INNER JOIN for demographic segmentation.

**Window Functions**: Implemented RANK(), DENSE_RANK(), and PARTITION BY to rank hospitals based on billing costs and compare patient statistics.

---

**Optimizing Resource Allocation**
- Average Medical Cost by **Medical Condition**: #1 Obesity ($25,844), #2 Asthma ($25,805) #3 Diabetes ($25,716), #4 HTN ($25,546), #5 Arthritis ($25,523), #6 Cancer ($25,366)
- Average Medical Cost by **Hospital**: #1 PLC Garner ($52,182), #2 Ruiz-Anthony ($52,154), #3 George-Gonzalez ($52,102)
- Average Medical Cost by **Admission Type**: #1 Elective ($25,718), #2 Emergency ($25,595), #3 Urgent ($25,583)
  
📌 Insight: Chronic conditions like obesity, asthma, and diabetes drive hospital costs, suggesting a **focus on preventive care programs, patient education, and lifestyle interventions** to reduce long-term healthcare spending.


**Patient Demographics & Admission Trends**
- Top Medical Conditions: #1 Arthritis 7059, #2 Diabetes 6953, #3 Cancer 6867  #4 HTN 6858 #5 Obesity 6837, #6 Asthma 6808

📌 Insight: Better care programs or pain management plans can be implemented for Arthritis patients to reduce the admissions (likely due to pain exacerbations). 


- Average Length of Stay by Medical Conditon: All conditions had an average LOS of 15 days.
  
📌 Insight: This could be due to synthetic data resulting in no pattern. If this were real data, a uniform LOS would indicate rigid hospital policies rather than patient-specific discharge planning, which could be inefficient. 


- Patient distribution by gender: Female: 20726, Male 20656
- Patient distribution by age: Geriatrics: 12775, Adults 28607
    
📌 Insight: Geriatrics make up about 1/3 of the patient profile, hence hospitals can enhance geriatric care. 

---

## 3. Visualization on a Pivot Table Dashboard 
![Dashboard Analysis](https://github.com/yuanz25/healthcare-data-analysis/blob/main/Pivot%20Table%20Chart.png)

**Key Insights**
1.  Admission Trends by Month to identify seasonal fluctuations and peak periods. February is often a lull season, and July-August has a spike in admissions.
2.  A scatter plot analysis showing a weak R² value suggests no relationship between a patient’s length of stay and their billing amount, which can be used in financial counselling when patients wish to discharge against medical advice (AOR).
3.  Medical conditions such as Arthritis and Diabetes have the highest admission counts - better preventive and disease management programs can be implemented to target these conditions.
4.  More Geriatrics (aged 65+) care specializations can be considered. Demographic Breakdown by Age & Gender displays not much significant disparities throughout the various medical conditions. 
e
