**📊 Project Summary**

This project leverages data from **55,500 patient records** to uncover key factors influencing **hospital costs**, **admissions**, and **patient outcomes**. Through data analysis, we aim to identify trends in **medical conditions**, **billing patterns**, and **insurance provider**. 
Dataset from: https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data

**🎯 Goals**

**1. Optimize Resource Allocation**
Efficiently utilize healthcare resources to improve patient outcomes.

**2. Identify Cost Reduction Opportunities**
Pinpoint areas where hospitals can reduce unnecessary expenses.


**📌 Expected Outcome**
This project transforms data insights into practical recommendations for:

- Better **patient care**.
- More **cost-effective hospital management**.

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

1. Data Cleanup & Initial Exploration using Excel/Power Query

(a) Inspect the **column names and data types**.

Convert date, number, and currency columns to proper format.
- Changed formatting of “Billing Amount” from Numbers > Currency

Convert categorical data** into structured formats (e.g., date formats, text to numbers).
- Create calculated columns.
  (i) “Age Category” range:
            
            ```
             0-18 years → Paediatrics
             19-65 years → Adults
             65+ years → Geriatrics #Different hospitals may have different cut-offs
            ```
            
  (ii) “Length of Stay” column:
            - Ensure both the “Admission Date” and “Discharge Date” columns are in date format
            - New Custom Column: [Discharge Date] - [Admission Date]
            - Under Transform: Change data type to “Days”

        
(b) Detect **inconsistent or strange data**.
 Standardized text formatting (For Name: removed extra spaces using TRIM, converted to “Capitalize Each Word”).
- Examine summary statistics for all variables and identify if any missing values (fill in with appropriate data or remove irrelevant column).
    
    
(c) Remove duplicates
I did not perform this step as same patient name can appear due to multiple admissions.
Using unique identifiers such as **Admission ID** /**Visit ID would be better** instead of just "Patient Name.". 
        
        
**📌 Identifying Key Columns**

Relevant Columns for Analysis
- **Admission Type** – Distinguishes emergency vs. routine cases.
- **Medical Condition** – Determines which illnesses drive higher costs.
- **Test Results** – Identifies patterns in medical diagnosis.
- **Age** – Examines cost variations by age group.
- **Insurance Provider** – Compares billing differences across insurers.


**📌 Key Analytical Questions**

For analysing Operations:
- Is there a correlation between length of stay and billing amount?
- What patterns exist in admission types (emergency vs. routine) across hospitals?
- Are there seasonal trends in hospital admissions?

For analysing Medical Conditions:
- What are the most common medical conditions among different age groups?
- Are specific medical conditions more prevalent in certain demographics (e.g., age, gender)?
- Which medical conditions contribute the most to high hospital costs?
- What is the average billing amount by medical condition?




## 2. Using SQL to analyse
I’m using Microsoft SQL Server Management Studio. Key SQL Skills Demonstrated:

**Data Aggregation & Grouping**: Used GROUP BY, COUNT(), AVG(), and SUM() to analyze trends in medical conditions, billing costs, and patient demographics.

**Filtering & Conditional Logic**: Applied WHERE, HAVING, and CASE statements to refine data analysis.

**Date & Time Analysis**: Utilized MONTH(), YEAR(), and DATEDIFF() to track patient admissions and calculate length of stay.

**Joins & Relationships**: Used Self Joins to identify repeat patient admissions and standard INNER JOIN for demographic segmentation.

**Window Functions**: Implemented RANK(), DENSE_RANK(), and PARTITION BY to rank hospitals based on billing costs and compare patient statistics.

Key insights:

Top Conditions: #1 Arthritis (9,308 cases), followed by Diabetes (9,304), HTN (9,245), Obesity (9,231), Cancer (9,227), and Asthma (9,185).

Billing Cost per Condition: Obesity ($25,806) incurs the highest average billing cost, followed by Diabetes ($25,638) and Asthma ($25,635).

Length of Stay: Certain conditions require a longer hospital stay, impacting resource allocation and costs.

📌 Insight: Chronic conditions like obesity, diabetes, and arthritis drive hospital costs, suggesting a focus on preventive care programs to reduce long-term healthcare spending.

Certain patients had multiple hospital visits, indicating poor disease management.

📌 Insight: Identifying frequent readmissions and its related medical conditions can help in reducing unnecessary costs by focusing on post-discharge care and chronic disease management. To have targeted interventions for high-readmission patients to improve long-term healthcare outcomes.
