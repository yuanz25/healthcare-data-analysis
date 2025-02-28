--View table
SELECT TOP 10 * FROM healthcare_data;

-- Find the most common medical condition
SELECT Medical_Condition, COUNT(Medical_Condition) AS count_conditions
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY count_conditions DESC;
--#1 Arthritis 9308, #2 Diabetes 9304, #3 HTN 9245, #4 Obesity 9231 #5 Cancer 9227, #6 Asthma 9185

--Find the average billing cost by medical condition
SELECT Medical_Condition, ROUND(AVG(Billing_Amount),0)
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY AVG(Billing_Amount) DESC;
--#1 Obesity $25806, #2 Diabetes $25638 #3 Asthma $25635, #4 Arthritis $25497, #5 HTN $25497, #6 Cancer $25162

--Find average length of stay by medical condition
SELECT Medical_Condition, AVG(Length_of_Stay_days)
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY AVG(Length_of_Stay_days) DESC;

--Find most commonly prescribed medications
SELECT Medication, COUNT(Medication) AS Med_Count
FROM healthcare_data
GROUP BY Medication
ORDER BY Med_Count;
--#1 Penicillin 11068, #2 Paracetamol 11071, #3 Aspirin 11094, #4 Ibuprofen 11127, Lipitor 11140, #5

--Find the most common admission types:
SELECT Admission_Type, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY Admission_Type
ORDER BY Admission_Count DESC;
--#1 Elective 18655, #2 Urgent 18576, #3 Emergency 18269

--Identify the patient demographics
SELECT Age_Category, COUNT(Age_Category) AS Patient_count
FROM healthcare_data
GROUP BY Age_Category;
--Geriatrics 17087, Adults 38297, Paediatrics 116

--Which age group is most affected by each condition?
SELECT Medical_Condition, Age_Category, COUNT(*) AS Total_Patients
FROM healthcare_data
GROUP BY Medical_Condition, Age_Category
ORDER BY Medical_Condition, Total_Patients DESC;

--What is the average age of patients for each condition?
SELECT Medical_Condition, AVG(Age) AS Avg_Age
FROM healthcare_data
GROUP BY Medical_Condition
ORDER BY Avg_Age DESC;


--Distribution by gender
SELECT Gender, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY Gender
ORDER BY Admission_Count DESC;
--Male 27774, Female 27726

--Are some conditions more common in males or females?
SELECT Medical_Condition, Gender, COUNT(*) AS Total_Cases
FROM healthcare_data
GROUP BY Medical_Condition, Gender
ORDER BY Medical_Condition, Total_Cases DESC;


--Find Insurance provider distribution among patients:
SELECT Insurance_Provider, COUNT(*) AS Patient_Count
FROM healthcare_data
GROUP BY Insurance_Provider
ORDER BY Patient_Count DESC;
--Cigna 11249, Medicare 11154, UnitedHealthcare 11125, Blue Cross 11059, Aetna 10913

--Monthly admission trend:
SELECT MONTH(Date_of_Admission) AS Month, COUNT(*) AS Admission_Count
FROM healthcare_data
GROUP BY MONTH(Date_of_Admission)
ORDER BY Month;

--Find the most expensive hospital billing using Window Functions:
SELECT Hospital, 
       ROUND(AVG(Billing_Amount),2) AS Avg_Bill,
       RANK() OVER (ORDER BY AVG(Billing_Amount) DESC) AS Rank_Billing
FROM healthcare_data
GROUP BY Hospital;

--Find patients and their medical condition who had multiple admissions using self join:
SELECT a.Name, a.Medical_Condition, a.Date_of_Admission AS First_Admit, b.Date_of_Admission AS Repeat_Admission
FROM healthcare_data a
JOIN healthcare_data b 
    ON a.Name = b.Name 
    AND a.Date_of_Admission < b.Date_of_Admission;

