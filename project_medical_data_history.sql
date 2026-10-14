#1 Show first name, last name, and gender of patients whose gender is 'M'
select first_name,last_name,gender from patients where gender='M';
# Show first name and last name of patients who do not have allergies
select first_name,last_name from patients where allergies is null;
# 3 Show first name of patients that start with the letter 'C'
select first_name from patients where first_name like 'C%';
# 4 Show first name and last name of patients that weigh within 100 to 120 inclusive
select first_name,last_name ,WEIGHT from patients where weight  between 100 and 120;
# 5 Update allergies column replacing NULL with 'NKA'
SELECT patient_id, first_name, last_name,COALESCE(allergies, 'NKA') AS allergies FROM patients;
# 6 Show first name and last name concatenated into one column
select concat(first_name,'  ',last_name) as full_name from patients;
-- 7 Show first name, last name, and full province name of each patient
select p.first_name,p.last_name,pr.province_name from patients p join province_names pr on p.province_id=pr.province_id;
-- 8 Show count of patients born in 2010
select count(*) from  patients where year( birth_date)=2010;
-- 9 Show first name, last name, and height of tallest patient
select first_name,last_name,height from patients order by height desc limit 1;
-- 10 Show all columns for patients with IDs 1,45,534,879,1000
select * from patients where patient_id in(1,45,534,879,1000);
-- 11 Show total number of admissionsadmissions
select count(*) as total_admissions from admissions;
-- 12 Show admissions where admitted and discharged same day
select * from admissions where admission_date=discharge_date;
-- 13 Show total admissions for patient_id 579
select count(*)total_admissions from admissions where patient_id=579;
-- 14 Show unique cities in province_id 'NS'
select distinct city from patients where province_id='NS';
-- 15 Show first name, last name, birth date for patients with height>160 and weight>70
select first_name,last_name,birth_date  from patients where height>160 and weight>70;
-- 16 Show unique birth years ordered ascending
select distinct year(birth_date)as birth_year from patients order by  birth_year asc;
-- 17 Show unique first names occurring only once
select first_name from patients group by first_name having count(first_name)=1;
-- 18 Show patient_id and first_name starting and ending with 's' and length≥6
select patient_id,first_name from patients where first_name like'S%S' and length(first_name)>=6;
-- 19 Show patient_id, first_name, last_name for diagnosis 'Dementia'
select  p.patient_id,p.first_name, p.last_name  from patients p join admissions a on p.patient_id=a.patient_id where a.diagnosis='Dementia';
-- 20 Display every patient's first_name ordered by length then alphabetically
select first_name from patients order by length(first_name),first_name;
-- 21 Show total male and female patients in same row
select sum(case when gender='M' then 1 else 0 end) as male_patients, sum(case when gender='F' then 1 else 0 end) as female_patients from patients;
-- 22 Show total male and female patients in same row 
select sum(case when gender='M' then 1 else 0 end) as male_patients, sum(case when gender='F' then 1 else 0 end) as female_patients from patients;
-- 23 Show patient_id, diagnosis for patients admitted multiple times for same diagnosis
select patient_id,diagnosis from admissions group by patient_id,diagnosis having count(*)>1;
-- 24 Show city and total number of patients ordered by count desc then city asc
select city,count(*) as total_patients from patients  group by city order by total_patients desc,city asc;
-- 25 Show first name, last name, and role for patients and doctors
select first_name,last_name,'patient' as role  from patients union select first_name,last_name,'doctor' as role from doctors;
-- 26 Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(*) as total_diagnosis from patients where allergies is not null group by allergies order by total_diagnosis desc;
-- 27 Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date from patients where year(birth_date) between 1970 and 1979 order by birth_date asc;
-- 28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane
select concat(upper(last_name),',',lower(first_name)) as full_name from patients order by first_name desc;
-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id,sum(height) as total_height from patients group by province_id having sum(height)>=7000;
-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight)-min(weight) as weight_diff from patients where last_name='Maroni';
-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as day_of_month, count(*) as total_admissions from admissions group by day_of_month order by total_admissions desc;
-- 32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT FLOOR(weight / 10) * 10 AS weight_group,COUNT(*) AS total_patients FROM patients GROUP BY weight_group ORDER BY weight_group DESC;
-- 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
select patient_id, weight, height, case when weight / power(height / 100.0, 2) >= 30 then 1 else 0 end as isobese from patients;
-- 34 Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
select p.patient_id, p.first_name, p.last_name, d.specialty from patients p join admissions a on p.patient_id = a.patient_id join doctors d on a.attending_doctor_id = d.doctor_id where a.diagnosis = 'Epilepsy' and d.first_name = 'Lisa';
 
