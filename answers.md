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
