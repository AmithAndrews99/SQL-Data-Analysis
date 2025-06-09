create database fertility_check;
use fertility_check;
select * from fertility;


#1 Select all columns for individuals whose Diagnosis is 'Altered'.
select * from fertility where Diagnosis = 'Altered';

#2 Count how many individuals are diagnosed as 'Normal'.
Select count(*)as normal_diagnosis from fertility where Diagnosis = 'Normal';

#3 Get the average Age of individuals who smoke daily.
select Smoking_habit, avg(Age)As avg_age from fertility where Smoking_habit ='daily';

#4 List all the distinct values present in the Smoking habit column.
select distinct(Smoking_habit) from fertility;

#5 Find the maximum number of hours people spend sitting per day.
select max(Number_of_hours_spent_sitting_per_day) as max_hours_per_day from fertility;

#6 Write a query to show all columns from the table where: Season = 'fall'AND Diagnosis = 'Altered'
select * from fertility where season = 'fall' and diagnosis ='Altered';

#7 Find out how many people:Had Childish diseases = 'yes' AND are older than 30
 select count(*) as no_of_people from fertility where Childish_diseases ='yes' and Age > 30;
 
 #8 Get the average number of sitting hours, grouped by Smoking habit.
 select Smoking_habit, avg(Number_of_hours_spent_sitting_per_day) as avg_sitting_hours from fertility group by smoking_habit;
 
 #9 Count how many people had surgical intervention during the spring season.
 select count(*) as NO_of_people from fertility where Surgical_intervention = 'yes' and season = 'spring';
 
 #10 Count how many people: Never smoke AND drink once a week
 select count(*) as No_of_people from fertility where Smoking_habit ='Never' and Frequency_of_alcohol_consumption ='once a week';
 
 #11 Find the top 3 most common age values in the dataset — i.e., the 3 ages that appear most frequently.
 select age, count(*) as max_frequency from fertility group by age order by max_frequency desc limit 3;
 
 #12 Show the average age for each unique value in the Diagnosis column.
 select diagnosis , avg(age) as avg_age from fertility group by diagnosis;
 
 #13 Find the highest age where the person had high fevers in the last year.
 select max(age) as highest_age_with_fever from fertility where High_fevers_in_the_last_year ='more than 3 months ago';
 
 #14 Find the total number of people who had surgical intervention and high fevers in the last year during the fall season.
 select count(*) as Total_person from fertility where Surgical_intervention = 'yes' and High_fevers_in_the_last_year = 'more than 3 months ago'and  season = 'fall';
 
 # 15 Find the average number of sitting hours for people who smoke daily and have Altered Diagnosis.
update fertility set Number_of_hours_spent_sitting_per_day = '0' where Number_of_hours_spent_sitting_per_day ='342';
select Avg(Number_of_hours_spent_sitting_per_day) as Avg_sitting_hours from fertility where Smoking_habit ='daily' and diagnosis = 'altered';

#16 Find the youngest person (lowest age) who had surgical intervention and smokes daily.
select * from fertility;
select min(age) from fertility where surgical_intervention ='yes' and Smoking_habit ='daily';

#17 Show the total number of people who have had surgical intervention and either daily smoking or more than 3 months ago high fevers 
select count(*) as Total_no_of_people from fertility where Surgical_intervention = 'yes' and (smoking_habit ='daily' or High_fevers_in_the_last_year ='more than 3 months ago');

#18 Find the average number of sitting hours per day for each season.
select season , avg(Number_of_hours_spent_sitting_per_day) from fertility group by season;

#19 Find the percentage of people who had surgical intervention in each season (show the percentage compared to the total in each season).
select season, COUNT(CASE WHEN Surgical_intervention = 'yes' THEN 1 END) * 100.0 / COUNT(*) AS surgery_percentage from fertility group by season;

#20 Display the season, average age, and number of people, but only for seasons where the average age is greater than 30.
select season, avg(age) as avg_age, count(*) as No_of_person  from fertility group by season having avg_age > 30;




 






 
 
 
 







