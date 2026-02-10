--
USE hospital;

-- View tables
SELECT * FROM appointments;
SELECT * FROM patients;

-- Adding new record
INSERT INTO patients (patient_ID, patient_name, age, gender, admission_date)
VALUES ('P101', 'Chris Johnson', 54, 'Male', '2024-08-20');

-- Deleting a record (corrected ID)
DELETE FROM patients 
WHERE patient_ID = 'P101' AND patient_name = 'Chris Johnson';

SET SQL_SAFE_UPDATES = 0;

-- Making updates
UPDATE appointments 
SET appointment_date = '2024-09-15' 
WHERE appointment_ID = 'A003';

-- Retrieve patient details with their allotted doctors and appointment date
SELECT 
    p.patient_ID,
    p.patient_name,
    a.doctor_name,
    a.appointment_date
FROM patients p
INNER JOIN appointments a
ON p.patient_ID = a.patient_ID;

-- Retrieve patients who do not have any appointments
SELECT 
    p.patient_ID,
    p.patient_name
FROM patients p
LEFT JOIN appointments a
ON p.patient_ID = a.patient_ID
WHERE a.appointment_ID IS NULL;

-- Average age of patients for each department
SELECT 
    a.department,
    AVG(p.age) AS average_age
FROM appointments a
INNER JOIN patients p
ON a.patient_ID = p.patient_ID
GROUP BY a.department
ORDER BY average_age DESC;

-- Percentage of total appointments handled by each doctor
SELECT 
    doctor_name,
    COUNT(appointment_ID) AS doctor_appointments,
    ROUND(
        (COUNT(appointment_ID) * 100.0 / 
        SUM(COUNT(appointment_ID)) OVER ()), 2
    ) AS appointment_percentage
FROM appointments
GROUP BY doctor_name
ORDER BY appointment_percentage DESC;
