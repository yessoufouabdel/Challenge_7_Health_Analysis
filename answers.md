**1.** Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
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
