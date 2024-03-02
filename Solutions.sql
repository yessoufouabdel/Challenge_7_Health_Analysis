--Question: 1. Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
  SELECT 
  	patient_name 
  FROM [dbo].[Visits] AS V 
  	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
  	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
  WHERE diagnosis_name='COVID-19'

  
-- Question: 2. Write a SQL query to retrieve the number of visits made by each patient, ordered by the number of visits in descending order.
  SELECT 
  	patient_name, 
  	COUNT([visit_id]) AS 'Number of Visit(s)'
  FROM [dbo].[Visits] AS V 
  	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
  GROUP BY patient_name
  ORDER BY COUNT([visit_id]) DESC


-- Question: 3. Write a SQL query to calculate the average age of patients who have been diagnosed with Pneumonia
  SELECT 
  	AVG(age) 'Average Age'
  FROM [dbo].[Visits] AS V 
  	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
  	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
  WHERE diagnosis_name='Pneumonia'


-- Question: 4. Write a SQL query to retrieve the top 3 most common symptoms among all visits.
  SELECT TOP 
  	3 [symptom_name], 
  	COUNT(V.[symptom_id])
  FROM [dbo].[Visits] AS V 
  	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
  	JOIN [dbo].[Symptoms] AS S ON S.[symptom_id]=V.[symptom_id]
  GROUP BY [symptom_name]
  ORDER BY COUNT(V.[symptom_id]) DESC


-- Question: 5. Write a SQL query to retrieve the patient who has the highest number of different symptoms reported.
  SELECT 
  	patient_name
  FROM
  (
  	SELECT 
  		patient_name
  		, COUNT(DISTINCT [symptom_id]) No_of_Symptoms
  		, RANK() OVER (ORDER BY COUNT(DISTINCT [symptom_id]) DESC ) AS myRank
  	FROM [dbo].[Patients] P 
  		JOIN [dbo].[Visits] V ON P.patient_id=V.patient_id
  	GROUP BY [patient_name]
  ) AS TempTable
  WHERE myRank=1


-- Question: 6. Write a SQL query to calculate the percentage of patients who have been diagnosed with COVID-19 out of the total number of patients.
  SELECT 
    (CAST(COUNT(P.[patient_id])AS FLOAT)/(SELECT COUNT([patient_id]) FROM [dbo].[Patients])*100) AS '% Covid Patients'
  FROM [dbo].[Visits] AS V 
    JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
    JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
  WHERE diagnosis_name='COVID-19'


-- Question: 7. Write a SQL query to retrieve the top 5 cities with the highest number of visits, along with the count of visits in each city.
    
  SELECT 
  	City,
  	[Number of Visits]
  FROM
  (
  	SELECT 
  		P.city, 
  		COUNT(V.visit_id) 'Number of Visits', 
  		DENSE_RANK() OVER (ORDER BY COUNT(V.visit_id) DESC) AS MyRank
  	FROM [dbo].[Visits] V 
  		JOIN [dbo].[Patients] P ON V.patient_id=P.patient_id
  	GROUP BY P.city
  ) AS TempTable
  WHERE MyRank <= 5


-- Question: 8. Write a SQL query to find the patient who has the highest number of visits in a single day, along with the corresponding visit date.
  SELECT 
  	patient_name,
  	[visit_date]
  FROM
  (
  	SELECT 
  		[patient_name], 
  		[visit_date],
  		COUNT(V.visit_id) VisitCount, 
  		RANK() OVER (ORDER BY COUNT(V.visit_id) DESC) AS MyRank
  	FROM 
  		[dbo].[Visits] V 
  		JOIN [dbo].[Patients] P ON V.patient_id=P.patient_id
  	GROUP BY [patient_name], [visit_date]
  ) AS TempTable
  WHERE MyRank = 1


-- Question: 9. Write a SQL query to retrieve the average age of patients for each diagnosis, ordered by the average age in descending order.
  SELECT 
  	diagnosis_name, 
  	AVG(age) AS avg_age
  FROM 
  	[dbo].[Visits] V 
  	JOIN [dbo].[Patients] P ON V.patient_id=P.patient_id
  	JOIN [dbo].[Diagnoses] D ON V.diagnosis_id=D.diagnosis_id
  GROUP BY diagnosis_name
  ORDER BY avg_age DESC


-- Question: 10. Write a SQL query to calculate the cumulative count of visits over time, ordered by the visit date.
  WITH cte AS
  (
  	SELECT 
  	visit_date, COUNT(visit_date) AS no_of_visit
  	FROM 
  	[dbo].[Visits]
  	GROUP BY visit_date
  )
  SELECT 
  	*, 
  	SUM(no_of_visit) 
      OVER(ORDER BY visit_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_count
  FROM cte



