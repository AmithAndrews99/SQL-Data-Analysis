drop database weather_disease;
create database weather_disease;
use weather_disease;
select * from weather_related_disease;

#1 What is the average temperature and humidity for patients diagnosed with Malaria?
select prognosis ,avg(Temperature)as avg_temperature, avg(humidity)as avg_humidity from weather_related_disease where prognosis = 'malaria';

#2 How does wind speed vary among patients with Sinusitis vs. Common Cold?
SELECT prognosis,COUNT(*) AS total_patients, AVG(wind_speed) AS avg_wind_speed, MIN(wind_speed) AS min_wind_speed, MAX(wind_speed) AS max_wind_speed
FROM weather_related_disease WHERE prognosis IN ('Sinusitis', 'Common Cold') GROUP BY prognosis;

#3 Calculate the average temperature, humididty , wind_speed for each disease.
select prognosis , avg(temperature)as avg_temperature, avg(humidity)as avg_humidity , avg(wind_speed)as avg_wind_speed from weather_related_disease group by prognosis;

#4 List the top 5 most common combinations of symptoms for patients with Influenza.
select chills, fatigue, headache, cough, sore_throat, runny_nose, fever, count(*) as combination_count from weather_related_disease 
where prognosis = 'influenza' group by chills, fatigue, headache, cough, sore_throat, runny_nose, fever order by combination_count desc limit 5;

#5 How many patients showed symptoms of fatigue, dizziness, and vomiting at the same time?
select * from weather_related_disease;
select count(*)as symptoms_fatigue_dizziness_vomiting from weather_related_disease  where fatigue = 1 and dizziness = 1 and vomiting =1;

#6 Which age group (0–20, 21–40, etc.) shows the highest incidence of Dengue?
select case when age between 0 and 20 then' 0-20' when age between 20 and 40 then '20-40' when age between 40 and 60 then '40-60' else '60+' end as age_group ,
count(*) as dengue_cases from weather_related_disease where prognosis ='dengue' group by age_group order by dengue_cases desc limit 1; 

#7 Use a CASE statement to classify patients into 'Child', 'Adult', and 'Senior' age groups. Then count how many in each group were diagnosed with Eczema.
select case when age between 0 and 18 then 'child' when age between 19 and 50 then 'adult' else 'senior' end as age_groups , count(*) as Eczema_cases from 
weather_related_disease group by age_groups ;

#8 Write a query that flags patients as “High Risk” if they have at least two comorbidities (e.g., diabetes, asthma_history, hiv_aids).
select age, gender, prognosis, case when(diabetes +asthma_history + hiv_aids) >= 2 then 'high risk' else 'low risk' end as risk_status from weather_related_disease;

#9  How many patients experienced at least 3 out of 5 major symptoms: chills, fatigue, headache, fever, cough?
select count(*) as experienced_3_major_symptoms from weather_related_disease where (chills + fatigue + headache + fever + cough ) >=3 ;

#10 Create a view that summarizes for each prognosis: total number of cases, average age, average temperature, and average humidity.
create view prognosis_summary as select prognosis, count(*) as total_case, avg(temperature) as avg_temperature , avg(humidity) as avg_humidity from 
weather_related_disease group by prognosis;
select * from prognosis_summary;  

#11 How many patients experienced both abdominal pain and vomiting but were not diagnosed with food poisoning?
select count(*) as Not_diagnossed_with_food_poisoning from weather_related_disease where abdominal_pain = 1 and vomiting = 1 and prognosis != 'food poisioning'; 

#12 Which symptom is most frequently observed in patients diagnosed with Heat Stroke?
select 'nausea' as symptom, COUNT(*) as frequency from weather_related_disease where prognosis = 'Heat Stroke' and nausea = 1
union all select 'joint_pain', COUNT(*) from weather_related_disease where prognosis = 'Heat Stroke' and joint_pain = 1
order by frequency desc limit 1;

#13 What’s the average wind speed experienced by patients under 18 diagnosed with Malaria?
select avg(wind_speed)as avg_wind_speed from weather_related_disease where prognosis = 'Malaria' and age <+ 18;

#14 Count how many patients had no symptoms
SELECT COUNT(*) AS no_symptom_patients
FROM weather_related_disease
WHERE 
    nausea = 0 AND
    joint_pain = 0 AND
    abdominal_pain = 0 AND
    high_fever = 0 AND
    chills = 0 AND
    fatigue = 0 AND
    runny_nose = 0 AND
    pain_behind_the_eyes = 0 AND
    dizziness = 0 AND
    headache = 0 AND
    chest_pain = 0 AND
    vomiting = 0 AND
    cough = 0 AND
    shivering = 0 AND
    severe_headache = 0 AND
    weakness = 0 AND
    trouble_seeing = 0 AND
    fever = 0 AND
    body_aches = 0 AND
    sore_throat = 0 AND
    sneezing = 0 AND
    diarrhea = 0 AND
    rapid_breathing = 0 AND
    rapid_heart_rate = 0 AND
    pain_behind_eyes = 0 AND
    swollen_glands = 0 AND
    rashes = 0 AND
    sinus_headache = 0 AND
    facial_pain = 0 AND
    shortness_of_breath = 0 AND
    reduced_smell_and_taste = 0 AND
    skin_irritation = 0 AND
    itchiness = 0 AND
    throbbing_headache = 0 AND
    confusion = 0 AND
    back_pain = 0 AND
    knee_ache = 0;
    
#15 What is the total number of patients for each type of diagnosis, and how many of them have a history of asthma?
SELECT prognosis, 
       COUNT(*) AS total_patients, 
       SUM(CASE WHEN asthma_history = 1 THEN 1 ELSE 0 END) AS asthma_patients
FROM weather_related_disease
GROUP BY prognosis;


