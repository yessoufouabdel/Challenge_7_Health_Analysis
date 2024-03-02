![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/8ef6b2b1-d4bc-45ab-8cef-dcee8e3f6aab)![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/e12334e3-41ec-4953-a1a9-d8174ee26e7c)![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/8ab01c9e-4aa0-4b72-982f-132696f6df21)![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/946b1c03-9b3a-45cc-9950-918d2e99ec81)**1.** Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT 
	patient_name 
FROM [dbo].[Visits] AS V 
	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
WHERE diagnosis_name='COVID-19'
```
</details>

**Results:**

 patient_name|
----------------|
David Kim|
John Smith|


**2.** Write a SQL query to retrieve the number of visits made by each patient, ordered by the number of visits in descending order
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT 
	patient_name, 
	COUNT([visit_id]) AS 'Number of Visit(s)'
FROM [dbo].[Visits] AS V 
	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
GROUP BY patient_name
ORDER BY COUNT([visit_id]) DESC
```
</details>

**Results:**

 patient_name|Number of Visit(s)|
----------------|----------------|
John Smith|3|
Mike Johnson|3|
Jane Doe|2|
David Kim|1|
Lisa Jones|1|


**3.** Write a SQL query to calculate the average age of patients who have been diagnosed with Pneumonia
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT 
	AVG(age) 'Average Age'
FROM [dbo].[Visits] AS V 
	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
WHERE diagnosis_name='Pneumonia'
```
</details>

**Results:**
Average Age|
----------------|
50|

**4.** Write a SQL query to retrieve the top 3 most common symptoms among all visits.
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT TOP 
	3 [symptom_name], 
	COUNT(V.[symptom_id]) AS No. of Symptoms
FROM [dbo].[Visits] AS V 
	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
	JOIN [dbo].[Symptoms] AS S ON S.[symptom_id]=V.[symptom_id]
GROUP BY [symptom_name]
ORDER BY COUNT(V.[symptom_id]) DESC
```
</details>

**Results:**

 symptom_name|No. of Symptoms|
----------------|----------------|
Cough|4|
Fever|3|
Fatigue|2|

**5.** Write a SQL query to retrieve the patient who has the highest number of different symptoms reported.
<details>
	<summary>Click here to expand answer!</summary>

```sql
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
```
</details>

**Results:**

patient_name|
----------------|
John Smith|
Mike Johnson|


**6.** Write a SQL query to calculate the percentage of patients who have been diagnosed with COVID-19 out of the total number of patients.
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT 
	(CAST(COUNT(P.[patient_id])AS FLOAT)/(SELECT COUNT([patient_id])
FROM [dbo].[Patients])*100) AS '% Covid Patients'
FROM [dbo].[Visits] AS V 
	JOIN [dbo].[Patients] AS P ON V.patient_id=P.patient_id
	JOIN [dbo].[Diagnoses] AS D ON V.diagnosis_id=D.diagnosis_id
WHERE diagnosis_name='COVID-19'
```
</details>

**Results:**

% Covid Patients|
----------------|
6|



**7.** Write a SQL query to retrieve the top 5 cities with the highest number of visits, along with the count of visits in each city.
<details>
	<summary>Click here to expand answer!</summary>

```sql
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
```
</details>

**Results:**

City|Number of Visits
----------------|----------------|
Seattle|6|
Miami|3|
Chicago|1|



**8.** Write a SQL query to find the patient who has the highest number of visits in a single day, along with the corresponding visit date.
<details>
	<summary>Click here to expand answer!</summary>

```sql
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
```
</details>

**Results:**

patient_name|visit_date
----------------|----------------|
Mike Johnson|2022-05-20|



**9.** Write a SQL query to retrieve the average age of patients for each diagnosis, ordered by the average age in descending order.
<details>
	<summary>Click here to expand answer!</summary>

```sql
SELECT 
	diagnosis_name, 
	AVG(age) AS avg_age
FROM 
	[dbo].[Visits] V 
	JOIN [dbo].[Patients] P ON V.patient_id=P.patient_id
	JOIN [dbo].[Diagnoses] D ON V.diagnosis_id=D.diagnosis_id
GROUP BY diagnosis_name
ORDER BY avg_age DESC
```
</details>

**Results:**

diagnosis_name|avg_age
----------------|----------------|
COVID-19|52|
Pneumonia|50|
Influenza|45|
Common Cold|44|
Bronchitis|30|


**10.** Write a SQL query to calculate the cumulative count of visits over time, ordered by the visit date.
<details>
	<summary>Click here to expand answer!</summary>

```sql
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
```
</details>

**Results:**

visit_date|no_of_visit|cumulative_count
----------------|----------------|----------------|
2022-01-01|1|1|
2022-01-02|2|3|
2022-01-03|2|5|
2022-05-13|1|6|
2022-05-20|2|8|
2022-08-19|1|9|
2022-12-01|1|10|
