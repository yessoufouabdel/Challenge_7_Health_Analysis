![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/e6056095-70f3-4430-8f16-03942d5acd22)![image](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/9825d174-c10a-4203-a4ca-d1568d603753)**1.** Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
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




