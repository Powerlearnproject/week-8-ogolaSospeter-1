SELECT r.name AS region, hf.name AS facility, s.service_name, COUNT(pv.patient_id) AS visits
FROM PatientVisits pv
JOIN Patients p ON pv.patient_id = p.id
JOIN Services s ON pv.service_id = s.id
JOIN HealthcareFacilities hf ON s.facility_id = hf.id
JOIN Regions r ON p.region_id = r.id
GROUP BY r.name, hf.name, s.service_name;

SELECT r.name AS region, COUNT(DISTINCT p.id) AS num_patients, COUNT(pv.service_id) AS total_visits
FROM Patients p
LEFT JOIN PatientVisits pv ON p.id = pv.patient_id
JOIN Regions r ON p.region_id = r.id
GROUP BY r.name;

SELECT r.name AS region, s.service_name, COUNT(pv.patient_id) AS visits
FROM PatientVisits pv
JOIN Services s ON pv.service_id = s.id
JOIN Regions r ON (SELECT p.region_id FROM Patients p WHERE p.id = pv.patient_id) = r.id
GROUP BY r.name, s.service_name;

SELECT r.name AS region,
       COUNT(DISTINCT hf.id) AS num_facilities,
       COUNT(DISTINCT p.id) AS num_patients,
       SUM(CASE WHEN pv.visit_date IS NOT NULL THEN 1 ELSE 0 END) AS total_visits
FROM Regions r
LEFT JOIN Patients p ON p.region_id = r.id
LEFT JOIN PatientVisits pv ON p.id = pv.patient_id
LEFT JOIN HealthcareFacilities hf ON r.name = hf.location
GROUP BY r.name;


-- Retrieve healthcare service usage by region
SELECT r.name AS region, hf.name AS facility, s.service_name, COUNT(pv.patient_id) AS visits
FROM PatientVisits pv
JOIN Patients p ON pv.patient_id = p.id
JOIN Services s ON pv.service_id = s.id
JOIN HealthcareFacilities hf ON s.facility_id = hf.id
JOIN Regions r ON p.region_id = r.id
GROUP BY r.name, hf.name, s.service_name;

-- Aggregate number of patients and visits by region
SELECT r.name AS region, COUNT(DISTINCT p.id) AS num_patients, COUNT(pv.service_id) AS total_visits
FROM Patients p
LEFT JOIN PatientVisits pv ON p.id = pv.patient_id
JOIN Regions r ON p.region_id = r.id
GROUP BY r.name;

-- Analyze service utilization by region
SELECT r.name AS region, s.service_name, COUNT(pv.patient_id) AS visits
FROM PatientVisits pv
JOIN Services s ON pv.service_id = s.id
JOIN Regions r ON (SELECT p.region_id FROM Patients p WHERE p.id = pv.patient_id) = r.id
GROUP BY r.name, s.service_name;
