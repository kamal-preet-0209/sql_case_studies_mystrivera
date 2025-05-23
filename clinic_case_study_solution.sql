---1. Appointment Delay Analysis >>>>>>>>new fn EPOCH>>>>>>>>>>>
---Question:
---Calculate the average delay (in minutes) between the scheduled appointment time and the actual arrival time for each clinic, and rank the clinics based on the highest average delay.


WITH CTE AS (
	SELECT c.clinic_id, c.clinic_name, ROUND(AVG(EXTRACT (EPOCH FROM (a.arrival_time-a.appointment_time))/60),2) AS average_delay
	FROM clinics c
	JOIN appointments a
	ON c.clinic_id=a.clinic_id
	GROUP BY c.clinic_id
	)
	
SELECT *,
RANK() OVER(ORDER BY average_delay) AS rank_by_delay
FROM CTE;





---2. No-Show or Late Completion Rate
---Question:
---Identify patients who have arrived more than 15 minutes late or whose appointments were not completed within 30 minutes after the scheduled time. List their names, number of such occurrences, and percentage over their total appointments.


SELECT p.patient_id, p.patient_first_name, 
		ROUND(EXTRACT(EPOCH FROM(a.arrival_time-a.appointment_time))/ 60,2) AS delay_time,
		ROUND(EXTRACT(EPOCH FROM(a.completed_time-a.arrival_time))/ 60,2) AS completion_time
FROM patients p
JOIN appointments a
ON p.patient_id=a.appointment_id
WHERE (EXTRACT(EPOCH FROM(a.arrival_time-a.appointment_time))/60)>15 OR
       (EXTRACT(EPOCH FROM(a.completed_time-a.arrival_time))/60)>30;





--3. Doctor Performance Report>>>>>>>>>>>>>DOUBT IN SOLUTION>>>>>>>>>>
--Question:
--For each doctor, calculate:

--Total number of appointments

--Average appointment duration (from arrival to completed time)

--Count of patients they’ve seen more than once

--Return results sorted by doctor with the most patients seen more than once.

WITH CTE AS(
	SELECT doctor_id, patient_id
	FROM appointments
	GROUP BY doctor_id, patient_id
	HAVING COUNT(patient_id)>1
	),

CTE2 AS(
	SELECT doctor_id, COUNT(DISTINCT(patient_id)) AS regular_patients
	FROM CTE
	GROUP BY doctor_id
)

SELECT a.doctor_id, 
	COUNT(a.appointment_id) AS number_of_appointments, 
	ROUND(AVG(EXTRACT(EPOCH FROM(a.completed_time-a.arrival_time))/60),2) AS appointment_duration, COALESCE(c.regular_patients, 0) AS regular_patient_count
FROM appointments a
LEFT JOIN CTE2 c
ON a.doctor_id=c.doctor_id
GROUP BY a.doctor_id, c.regular_patients
ORDER BY regular_patient_count DESC;



--4. Clinic Load by Weekday 
--Question:
--Find out which weekday (Monday–Sunday) is the busiest for each clinic in terms of number of appointments. Return clinic name, weekday, and appointment count.

WITH CTE AS(
	SELECT clinic_id, TO_CHAR(appointment_date, 'Day') AS weekday, COUNT(*) AS appt_count
	FROM appointments
	GROUP BY clinic_id, TO_CHAR(appointment_date, 'Day')
	),
CTE2 AS(
	SELECT clinic_id, MAX(appt_count) AS num_of_appt
	FROM CTE 
	GROUP BY clinic_id
)
	
SELECT c.clinic_name, ct1.weekday, ct2.num_of_appt
FROM CTE ct1
JOIN CTE2 ct2
ON ct2.clinic_id=ct1.clinic_id
AND ct1.appt_count=ct2.num_of_appt
JOIN clinics c
ON c.clinic_id=ct1.clinic_id;





--5. Repeat Patient Frequency Question:
--Find the top 5 patients with the highest number of appointments and display their full name and total appointment count. 
--Include a column to indicate if they are “Frequent” (more than 10 appointments) or “Occasional” (10 or fewer).

WITH CTE AS(
	SELECT CONCAT(p.patient_first_name, ' ',p.patient_last_name), COUNT(a.*) as appointment_count
	FROM appointments a
	JOIN patients p
	ON a.patient_id=p.patient_id
	GROUP BY CONCAT(p.patient_first_name, ' ',p.patient_last_name)
	ORDER BY appointment_count DESC
	LIMIT 5
)

SELECT *, 
CASE 
	WHEN appointment_count>10 THEN 'Frequent'
	ELSE 'Occasional'
	END AS status
FROM CTE;

--6. Time Window Utilization
--Question:
--Group appointments into 3 time windows:

Morning (before 12:00 PM)

Afternoon (12:00 PM–5:00 PM)

Evening (after 5:00 PM)
Count the number of appointments in each window for each clinic.

WITH CTE AS(
		SELECT *,
	CASE
		WHEN appointment_time>'12:00:00' THEN 'Morning'
		WHEN appointment_time BETWEEN '12:00:00' AND '05:00:00' THEN 'Afternoon'
		ELSE 'Evening'
		END AS time_window
	FROM appointments
)

SELECT clinic_id, time_window, COUNT(*) AS num_of_appt
FROM CTE
GROUP BY clinic_id, time_window
ORDER BY clinic_id;


--7. Monthly Trends by Clinic
--Question:
--Using a CTE, show the monthly appointment count trend for each clinic for the past year. Return columns: clinic_name, year_month, appointment_count.


WITH CTE AS(
	SELECT a.*, c.clinic_name
	FROM appointments a
	LEFT JOIN clinics c
	ON a.clinic_id=c.clinic_id
	)
	
SELECT clinic_name, TO_CHAR(appointment_date,'YYYY-MM') AS year_month, COUNT(*) AS appintments_count
FROM CTE
GROUP BY clinic_name, TO_CHAR(appointment_date,'YYYY-MM');


--8. Early vs Late Arrival Ratio
--Question:
--For each doctor, calculate the ratio of: Appointments where patients arrived on time or early, Appointments where patients arrived late. Return doctor’s full name and the ratio (early_or_on_time : late).


WITH CTE AS(
	SELECT *,
		(CASE WHEN arrival_time=appointment_time THEN ROUND(EXTRACT(EPOCH FROM (appointment_time - arrival_time)) / 60, 2) ELSE 0 END) AS on_time_min,
		(CASE WHEN arrival_time<appointment_time THEN ROUND(EXTRACT(EPOCH FROM (appointment_time - arrival_time)) / 60, 2) ELSE 0 END) AS early_min,
		(CASE WHEN arrival_time>appointment_time THEN ROUND(EXTRACT(EPOCH FROM (arrival_time - appointment_time)) / 60, 2) ELSE 0 END) AS late_min
	FROM appointments)

SELECT d.first_name AS doctor_name, (c.on_time_min ||':'|| c.late_min) AS on_time_ratio, (c.early_min ||':'|| c.late_min) AS early_ratio
FROM CTE c
JOIN doctors d
ON d.doctor_id=c.doctor_id;