🏥 Healthcare Appointment Analysis SQL Case Study
This repository contains a SQL case study based on a healthcare appointment dataset. As a data analyst, your task is to support operational efficiency and patient experience improvements by answering critical questions using SQL.

📘 Case Study Background
This case study delves into a dataset of healthcare appointments to extract meaningful insights that can improve clinic operations and patient satisfaction.
By analyzing appointment schedules, arrival times, and completion times, you’ll uncover areas for optimization and make data-driven recommendations to stakeholders.

🧱 Database Structure
The database includes the following tables:
1. appointments – Records of each appointment, including time scheduled, arrival, and completion.
2. clinics – Details of clinics where appointments take place.
3. doctors – Information about doctors.
4. patients – Information about patients.
5. Funds- Information about funds available.

🧠 Problem Statements
Some of the business questions you'll answer:

Question 1:
Calculate the average delay (in minutes) between the scheduled appointment time and the actual arrival time for each clinic. Rank the clinics based on the highest average delay.

Question 2:
Identify patients who: Arrived more than 15 minutes late, OR Whose appointments were not completed within 30 minutes after the scheduled time. Return their names, number of such occurrences, and percentage over total appointments.

Question 3:
For each doctor, calculate: Total number of appointments, Average appointment duration (from arrival to completion), Number of patients seen more than once. Sort by doctors with the most repeat patients.

Question 4:
Find the busiest weekday (Monday–Sunday) for each clinic based on number of appointments. Return clinic name, weekday, and appointment count.

Question 5:
List the top 5 patients with the most appointments. Show: Full name, Total appointment count, A category: “Frequent” (>10 appointments) or “Occasional” (≤10 appointments)

Question 6:
Group appointments into time windows and count the number per window per clinic: Morning: before 12:00 PM, Afternoon: 12:00 PM–5:00 PM, Evening: after 5:00 PM.

Question 7:
Show the monthly appointment count trend for each clinic for the past year. Return: clinic_name, year_month, appointment_count

Question 8:
For each doctor, calculate the ratio of: Appointments where patients arrived on time or early. Appointments where patients arrived late. Return the doctor’s full name and the ratio (early_or_on_time : late).

📊 Key Insights
1. Clinic Efficiency Varies Significantly
Average appointment delays highlight operational inefficiencies. Clinics with high delays may require process improvements.

2. Patient Adherence Challenges
Frequent late arrivals or extended appointments suggest communication gaps or scheduling inefficiencies.

3. Doctor Workload & Retention Patterns
Repeat patient counts and appointment durations offer insight into doctor efficiency, loyalty, and potential overwork.

4. Traffic Patterns are Predictable
Identifying the busiest days helps plan staffing levels more effectively.

5. Patient Segmentation Highlights Heavy Users
A small segment of “Frequent” patients may represent a core group that can be better engaged through loyalty initiatives.

🛠️ How to Use
-- Clone the repository and connect to your SQL environment (PostgreSQL recommended).
-- Run the SQL schema script to create and populate tables:
appointments
clinics
doctors
patients
funds

Read each problem statement.

Write and execute SQL queries to solve them.


