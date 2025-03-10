SELECT * 
FROM healthcare_data 
WHERE Billing_Amount < 0;

DELETE FROM healthcare_data 
WHERE Billing_Amount < 0;

-- View duplicate entries
WITH DuplicatePatients AS (
    SELECT Name, Date_of_Admission, Medical_Condition, Insurance_Provider
    FROM healthcare_data
    GROUP BY Name, Date_of_Admission, Medical_Condition, Insurance_Provider
    HAVING COUNT(*) > 1
)
SELECT h.*
FROM healthcare_data h
JOIN DuplicatePatients d
    ON h.Name = d.Name
    AND h.Date_of_Admission = d.Date_of_Admission
    AND h.Medical_Condition = d.Medical_Condition
    AND h.Insurance_Provider = d.Insurance_Provider
ORDER BY h.Name, h.Date_of_Admission;
-- Shows 10977 rows, with only the age differing and every other column having the same results > Duplicate entries

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Name, Date_of_Admission, Medical_Condition, Insurance_Provider
                              ORDER BY Name) AS Name
    FROM healthcare_data
)
-- Delete duplicates, keeping only the first occurrence (RowNum = 1)
DELETE FROM healthcare_data
WHERE Name IN (SELECT Name FROM CTE WHERE RowNum > 1);

DELETE FROM healthcare_data
WHERE Name IS NULL OR Date_of_Admission IS NULL;

-- Duplicate check:
SELECT Name, COUNT(*) AS Duplicate_Count
FROM healthcare_data
GROUP BY Name, Date_of_Admission, Medical_Condition, Insurance_Provider
HAVING COUNT(*) > 1;



--Patients who had multiple readmissions: 
SELECT a.Name, a.Medical_Condition, a.Date_of_Admission AS First_Admit, b.Date_of_Admission AS Repeat_Admission
FROM healthcare_data a
JOIN healthcare_data b 
    ON a.Name = b.Name 
    AND a.Date_of_Admission < b.Date_of_Admission;
--10721 readmission records 

SELECT COUNT(*) FROM healthcare_data;
-- 41382 patient records

SELECT COUNT(DISTINCT(Hospital))
FROM healthcare_data;
--33757 Hospitals

SELECT TOP 5 Hospital, COUNT(*) AS Total_Admissions, SUM(Billing_Amount) AS Total_Revenue
FROM healthcare_data
GROUP BY Hospital
ORDER BY Total_Admissions DESC, Total_Revenue DESC;
-- Top performing hospitals in terms of admission and revenue: LLC Smith, Ltd Smith, Johnson PLC, Smith Ltd, Smith Group 


-- Find the most common medical condition:
SELECT Medical_Condition, COUNT(Medical_Condition) AS count_conditions
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY count_conditions DESC;
--#1 Arthritis 7059, #2 Diabetes 6953, #3 Cancer 6867  #4 HTN 6858 #5 Obesity 6837, #6 Asthma 6808

-- Find the average billing cost by medical condition:
SELECT Medical_Condition, ROUND(AVG(Billing_Amount),0)
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY AVG(Billing_Amount) DESC;
--#1 Obesity $25844, #2 Asthma $25805 #3 Diabetes $25716, #4 HTN $25546, #5 Arthritis $25523, #6 Cancer $25366

--Find the most common admission types:
SELECT Admission_Type, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY Admission_Type
ORDER BY Admission_Count DESC;
--#1 Urgent 13955, #2 Elective 13944, #3 Emergency 13483 

-- Find the average billing cost by admission type:
SELECT Admission_Type, ROUND(AVG(Billing_Amount),0)
FROM healthcare_data
GROUP BY Admission_Type
ORDER BY AVG(Billing_Amount) DESC;
--#1 Elective $25718, #2 Emergency $25595, #3 Urgent $25583

-- Find the highest billing cost by hospital:
SELECT Hospital, ROUND(AVG(Billing_Amount),0)
FROM healthcare_data
GROUP BY Hospital
ORDER BY AVG(Billing_Amount) DESC;
--#1 PLC Garner $52182, #2 Ruiz-Anthony $52154, #3 George-Gonzalez $52102

--Find average length of stay by medical condition
SELECT Medical_Condition, AVG(Length_of_Stay_days)
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY AVG(Length_of_Stay_days) DESC;
--All conditions had an average LOS of 15 days (could be due to synthetic data) 

--Identify the patient distribution by age:
SELECT Age_Category, COUNT(Age_Category) AS Patient_count
FROM healthcare_data
GROUP BY Age_Category;
--Geriatrics: 12775, Adults 28607

SELECT MIN(Age) FROM healthcare_data;
--18 years old have all been grouped as Adults

--Which age group is most affected by each condition?
SELECT Medical_Condition, Age_Category, COUNT(*) AS Total_Patients
FROM healthcare_data
GROUP BY Medical_Condition, Age_Category
ORDER BY Medical_Condition, Total_Patients DESC;

----Distribution by gender
SELECT Gender, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY Gender
ORDER BY Admission_Count DESC;
--Female: 20726, Male 20656

--Are some conditions more common in males or females?
SELECT Medical_Condition, Gender, COUNT(*) AS Total_Cases
FROM healthcare_data
GROUP BY Medical_Condition, Gender
ORDER BY Medical_Condition, Total_Cases DESC;

--To see if there is a monthly trend (using a line graph to see the trend would be better)
SELECT MONTH(Date_of_Admission) AS Month, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY MONTH(Date_of_Admission)
ORDER BY Month;

--Find most commonly prescribed medications
SELECT Medication, COUNT(Medication) AS Med_Count
FROM healthcare_data
GROUP BY Medication
ORDER BY Med_Count DESC;
-- #1 Lipitor 8320, #2 Paracetamol 8277, #3 Penicillin 8270, #4 Aspirin 8268, #5 Ibuprofen 8247
