**📊 Project Summary**

This project leverages data from **55,500 patient records** to uncover key factors influencing **hospital costs**, **admissions**, and **patient outcomes**. Through data analysis, we aim to identify trends in **medical conditions**, **billing patterns**, and **insurance provider**. 
Dataset from: https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data

**🎯 Goals**

**1. Optimize Resource Allocation**
Efficiently utilize healthcare resources to improve patient outcomes.

**2. Identify Cost Reduction Opportunities**
Pinpoint areas where hospitals can reduce unnecessary expenses.

**3. Enhance Healthcare Management**
Provide actionable strategies to improve care quality and streamline operations.

**📌 Expected Outcome**
This project transforms data insights into practical recommendations for:

- Better **patient care**.
- More **cost-effective hospital management**.
- Improved **decision-making processes** in healthcare.

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
    - I did not perform this step as same patient name can appear due to multiple admissions. Using unique identifiers such as **Admission ID** /**Visit ID would be better** instead of just "Patient Name.".
    - To check if there were multiple admissions. Group by Patient Name & Count Entries - which is present in this dateset.
        
        

**📌 Identifying Key Columns**

Relevant Columns for Analysis
- **Billing Amount** – Helps analyze hospital cost distribution.
- **Admission Type** – Distinguishes emergency vs. routine cases.
- **Medical Condition** – Determines which illnesses drive higher costs.
- **Test Results** – Identifies patterns in medical diagnosis.
- **Age** – Examines cost variations by age group.
- **Insurance Provider** – Compares billing differences across insurers.

Less Relevant Columns:
- **Room Number** – Not meaningful for cost or medical trends. - **Removed**
- **Doctor’s Name** – Not useful for generalized analysis.
- **Hospital Name** – Only relevant if comparing different hospitals.


**📌 Key Analytical Questions**

For analysing Medical Conditions:
- What are the most common medical conditions among different age groups?
- Are specific medical conditions more prevalent in certain demographics (e.g., age, gender)?
- Which medical conditions contribute the most to high hospital costs?
- What is the average billing amount by medical condition?

For analysing operations:
- Is there a correlation between length of stay and billing amount?
- What patterns exist in admission types (emergency vs. routine) across hospitals?
- Are there seasonal trends in hospital admissions?



## 2. Using SQL to analyse
I’m using Microsoft SQL Server Management Studio

SQL queries done: 

- Find the most common medical condition
- Find the average billing cost by medical condition
- Find average length of stay by medical condition
- Find most commonly prescribed medications
- Find the most common admission types
- Identify patient demographics
    - Which age group is most affected by each condition?
    - What is the average age of patients for each condition?
- Distribution by gender
    - Are some conditions more common in males or females?
- Find Insurance provider distribution among patients
- Monthly admission trend
- Determine which hospitals have the highest average billing amount per patient. (Using Windows function)
- Find patients and their medical condition who had multiple admissions (Using self join)
