
-- CASE STUDY: Gym Members' Exercise Tracking Analysis

-- Description:
-- The following dataset represents anonymized data collected from a fitness center to track the workout patterns and fitness progress of its members.
-- The dataset captures demographic details, physiological metrics, and workout-related attributes such as heart rate, session duration, calories burned,
-- workout type, and experience level.

-- Key Columns:
-- Age: Age of the gym member
-- Gender: Gender of the gym member
-- Weight (kg): Member's weight
-- Height (m): Member's height
-- Max_BPM: Maximum heart rate recorded during workouts
-- Avg_BPM: Average heart rate recorded during workouts
-- Resting_BPM: Resting heart rate
-- Session_Duration (hours): Duration of workout session
-- Calories_Burned: Calories burned per session
-- Workout_Type: Type of workout performed (Yoga, HIIT, Cardio, Strength, etc.)
-- Fat_Percentage: Body fat percentage
-- Water_Intake (liters): Daily water intake
-- Workout_Frequency (days/week): Number of days a member works out in a week
-- Experience_Level: Fitness experience on a scale of 1 (Beginner) to 5 (Expert)
-- BMI: Body Mass Index

create database gym_members;
use gym_members;

alter table gym_members_exercise_tracking RENAME TO gym_members;

select * from gym_members;

-- Q1: How many total members are there?
select count(*) as total_members 
from gym_members;

-- Q2: What is the average BMI of all members?
select round(avg(BMI), 2) as average_BMI 
from gym_members;

-- Q3: How many distinct workout types are present?
select count(distinct Workout_Type) as workout_types 
from gym_members;

-- Q4: List the average calories burned for each workout type.
select Workout_Type, round(avg(Calories_Burned),2) as avg_calories 
from gym_members 
group by Workout_Type order by avg_calories desc;

-- Q5: What is the maximum session duration recorded?
select max(`Session_Duration (hours)`) as max_duration 
from gym_members;

-- Q6: What is the gender distribution in the dataset?
select Gender, count(*) as count 
from gym_members 
group by Gender;

-- Q7: What is the average fat percentage by gender?
select Gender, round(avg(Fat_Percentage), 2) as avg_fat 
from gym_members 
group by Gender;

-- Q8: List all members whose BMI is considered overweight (BMI > 25).
SELECT * from gym_members 
where BMI > 25;

-- Q9: What is the average resting BPM for each experience level?
select Experience_Level, round(avg(Resting_BPM), 2) as avg_resting_bpm 
from gym_members 
group by Experience_Level;

-- Q10: List the top 5 members who burned the most calories.
select * FROM gym_members 
order by Calories_Burned desc limit 5;

-- Q11: Using a CTE, find the average session duration for each workout type, then filter only those with more than 1.2 hours on average.
with avg_duration as (
  select Workout_Type, avg(`Session_Duration (hours)`) as avg_session
  from gym_members
  group by Workout_Type
)
select * from avg_duration where avg_session > 1.2;

-- Q12: Using a window function, assign a rank to each member based on calories burned (highest to lowest).
select *, rank() over (order by Calories_Burned desc) as calorie_rank 
from gym_members;

-- Q13: Using a CTE, find members who burn more than the average calories burned.
with avg_calories as(
select avg(Calories_Burned) as avg_val from gym_members
)
select * from gym_members 
where Calories_Burned > (select avg_val from avg_calories);

-- Q14: What is the average water intake for each experience level, and show the overall average as well using window function?
select *, round(avg(`Water_Intake (liters)`) over (), 2) as overall_avg_water
from (
  select Experience_Level, round(avg(`Water_Intake(liters)`), 2) as level_avg
  from gym_members
  group by Experience_Level
) as sub;

-- Q15: Find members whose Max_BPM is in the top 10% of all Max_BPM values using NTILE window function.
select * from (
  select *, ntile(10) over (order by Max_BPM desc) as bpm_tile
  from gym_members
) as t where bpm_tile = 1;

-- Q16: Using a CTE, identify the top 3 members within each experience level based on calories burned. 
-- Display their Member ID, Experience Level, and Calories Burned.
with ranked_members as (
  select Experience_Level, Calories_Burned,
         rank() over (partition by Experience_Level order by Calories_Burned desc) as rank_within_level
  from gym_members
)
select Experience_Level, Calories_Burned
from ranked_members
where rank_within_level <= 3;


-- Q17: For each workout type, find the member with the highest calories burned using ROW_NUMBER.
select * from (
  select *, row_number() over (partition by Workout_Type order by Calories_Burned desc) as rn
  from gym_members
) as ranked
where rn = 1;

-- Q18: For each workout type, calculate the difference between a member’s calories burned and the average calories 
-- burned for that workout type using window functions.
select Workout_Type, Calories_Burned,
       round(avg(Calories_Burned) over (partition by Workout_Type), 2) as avg_burn_per_type,
       Calories_Burned - round(avg(Calories_Burned) over (partition by Workout_Type), 2) as difference_from_avg
from gym_members;


-- Q19: Rank all members based on their session duration, and list the top 5 members who spend the most time working out.
with ranked_sessions as (
  select Age, `Session_Duration (hours)`,
         rank() over (order by `Session_Duration (hours)` desc) as duration_rank
  from gym_members
)
select * from ranked_sessions
where duration_rank <= 5;


-- Q20: Using CTEs, find the total Calories_Burned for each Experience_Level.
with level_totals as (
  select 
    Experience_Level, 
    SUM(Calories_Burned) as total_calories
  from gym_members
  group by Experience_Level
)
select * from level_totals;




