# Healthcare Aanalysis
![Screenshot_3](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/cb09936d-46db-46b1-9d8d-c7719a7c898b)
## Intro
You are a Healthcare Analyst
You have been asked to analyse the hospital records to track the progress of some common illnesses so you can help inform a public health programme.

## Tables
Here are the tables you will be using:
* Patients
* Visits
* Symptoms
  ![Screenshot_4](https://github.com/yessoufouabdel/Challenge_7_Health_Analysis/assets/5968266/3a0e032e-01a6-4e39-8610-1f934d6708bb)


  

## Create and Insert Data into the Tables with the following script
  CREATE TABLE Patients (
  patient_id INT PRIMARY KEY,
  patient_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  city VARCHAR(50)
  );
  
  CREATE TABLE Symptoms (
  symptom_id INT PRIMARY KEY,
  symptom_name VARCHAR(50)
  );
  
  CREATE TABLE Diagnoses (
  diagnosis_id INT PRIMARY KEY,
  diagnosis_name VARCHAR(50)
  );
  
  CREATE TABLE Visits (
  visit_id INT PRIMARY KEY,
  patient_id INT,
  symptom_id INT,
  diagnosis_id INT,
  visit_date DATE,
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  FOREIGN KEY (symptom_id) REFERENCES Symptoms(symptom_id),
  FOREIGN KEY (diagnosis_id) REFERENCES Diagnoses(diagnosis_id)
  );
  
  -- Insert data into Patients table
  INSERT INTO Patients (patient_id, patient_name, age, gender, city)
  VALUES
  (1, 'John Smith', 45, 'Male', 'Seattle'),
  (2, 'Jane Doe', 32, 'Female', 'Miami'),
  (3, 'Mike Johnson', 50, 'Male', 'Seattle'),
  (4, 'Lisa Jones', 28, 'Female', 'Miami'),
  (5, 'David Kim', 60, 'Male', 'Chicago');
  
  -- Insert data into Symptoms table
  INSERT INTO Symptoms (symptom_id, symptom_name)
  VALUES
  (1, 'Fever'),
  (2, 'Cough'),
  (3, 'Difficulty Breathing'),
  (4, 'Fatigue'),
  (5, 'Headache');
  
  -- Insert data into Diagnoses table
  INSERT INTO Diagnoses (diagnosis_id, diagnosis_name)
  VALUES
  (1, 'Common Cold'),
  (2, 'Influenza'),
  (3, 'Pneumonia'),
  (4, 'Bronchitis'),
  (5, 'COVID-19');
  
  -- Insert data into Visits table
  INSERT INTO Visits (visit_id, patient_id, symptom_id, diagnosis_id, visit_date)
  VALUES
  (1, 1, 1, 2, '2022-01-01'),
  (2, 2, 2, 1, '2022-01-02'),
  (3, 3, 3, 3, '2022-01-02'),
  (4, 4, 1, 4, '2022-01-03'),
  (5, 5, 2, 5, '2022-01-03'),
  (6, 1, 4, 1, '2022-05-13'),
  (7, 3, 4, 1, '2022-05-20'),
  (8, 3, 2, 1, '2022-05-20'),
  (9, 2, 1, 4, '2022-08-19'),
  (10, 1, 2, 5, '2022-12-01');

## Questions

+ 1. Write a SQL query to retrieve all patients who have been diagnosed with COVID-19
+ 2. Write a SQL query to retrieve the number of visits made by each patient, ordered by the number of visits in descending order.
+ 3. Write a SQL query to calculate the average age of patients who have been diagnosed with Pneumonia.
+ 4. Write a SQL query to retrieve the top 3 most common symptoms among all visits.
+ 5. Write a SQL query to retrieve the patient who has the highest number of different symptoms reported.
+ 6. Write a SQL query to calculate the percentage of patients who have been diagnosed with COVID-19 out of the total number of patients.
+ 7. Write a SQL query to retrieve the top 5 cities with the highest number of visits, along with the count of visits in each city.
+ 8. Write a SQL query to find the patient who has the highest number of visits in a single day, along with the corresponding visit date.
+ 9. Write a SQL query to retrieve the average age of patients for each diagnosis, ordered by the average age in descending order.
+ 10. Write a SQL query to calculate the cumulative count of visits over time, ordered by the visit date.





