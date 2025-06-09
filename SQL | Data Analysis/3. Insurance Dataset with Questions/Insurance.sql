create database insurance;
use insurance;

select * from insurance;


-- 1. Count for each categories of ‘region
select region,count(*)
from insurance
group by region;


-- 2. Find 50 records of highest ‘age’ and export data/table to desktop
select *
from insurance
order by age desc
limit 50;

-- 3. Add index name ‘quick’ on ‘id’


-- 4. Describe the schema of table
describe insurance;


-- 5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run
-- appropriate query then create view]



-- 6. Rename the view as ‘type’
-- 7. Count how many are ‘northwest’ insurance holders
select region, count(*)
from insurance
where region = 'northwest';


-- 8. Count how many insurance holders were ‘femail’
select sex,count(*)
from insurance
where sex = 'female';


-- 9. Create Primary key on a suitable column
alter table insurance
add constraint pk_insurance_id primary key (id);

desc insurance;


-- 10. Create a new column ‘ratio’ which is age multiply by bmi
select age,bmi,age*bmi as ratio
from insurance;


-- 11. Arrange the table from high to low according to charges
select * 
from insurance
order by charges desc;


-- 12. Find MAX of ‘charges’
select max(charges)
from insurance;


-- 13. Find MIN of ‘charges’
select min(charges)
from insurance;


-- 14. Find average of ‘charges’ of male and female
select gender,avg(charges) as AVG
from insurance
group by gender;


-- 15. Write a Query to rename column name sex to Gender
alter table insurance
change column sex Gender enum('male','Female');

-- 16. Add new column as HL_Charges where more than average charges should be
-- categorized as HIGH and less than average charges should be categorized as LOW

select id,charges,case when charges> (
select avg(charges) as AVG_Charges
from insurance) then 'High' else 'low' end as HL_Charges
from insurance;


-- 17. Change location/position of ‘smoker’ and bring before ‘children’
alter table insurance
modify column smoker text after children;


-- 18. Show top 20 records

select * 
from insurance
order by charges desc
limit 20;


-- 19. Show bottom 20 records

select * 
from insurance
order by charges asc
limit 20;

-- 20. Randomly select 20% of records and export to desktop

SELECT *
FROM insurance
WHERE MOD(id, 5) = 0 



-- 21. Remove column ‘ratio’



-- 22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in
-- the script itself with remarks by using #





-- 23. Create a view called Female_HL_Charges that shows only those data where
-- HL_Charges is High, Female, Smokers and with 0 children


-- 24. Update children column if there is 0 children then make it as Zero Children, if 1
-- then one_children, if 2 then two_children, if 3 then three_children, if 4 then
-- four_children if 5 then five_children else print it as More_than_five_children.

ALTER TABLE insurance
ADD COLUMN children_description VARCHAR(255) AFTER children;

select * from insurance;

update insurance 
set children_description =
case when children = 0 then 'Zero Children'
	 when children = 1 then 'One Child'
	 when children = 2 then 'Two Children'
	 when children = 3 then 'Three Children'
	 when children = 4 then 'Four Children'
	 when children = 5 then 'Five Children'
	 else 'More than Five Children'
    end; 

-- 25. Mail the script to jeevan.raj@imarticus.com by EOD.



-- write a query to rename 'sex' to 'gender' 
alter table insurance
change column sex gender varchar(10);

select * from insurance;

-- write a query to print the third highest charges.

select * from insurance
order by charges desc
limit 1
offset 3;

-- write a query to print the third highest charges uding dense rank.

select charges, dense_rank() over (order by charges desc) as rnk
from insurance;

select charges
from (
    select charges, dense_rank() over (order by charges desc) as rnk
    from insurance
) as ranked
where rnk = 3;







select * from insurance;

#static code

alter table insurance add column Age_Category varchar(50);

select 
max(age) as MaxAge,
min(age) as MinAge, 
max(age)-min(age) as Diff_Age, 
round(max(age)-min(age)/3) as Age_bin
from insurance;

update insurance set Age_Category = case
when age<33 then "Younger"
when age<49 then "Middle"
else "Older" end;

#Dynamic code

with CTE as (
select 
max(age) as MaxAge,
min(age) as MinAge, 
max(age)-min(age) as Diff_Age, 
round((max(age)-min(age))/3) as Age_bin
from insurance)
update insurance set Age_Category =case
  when age< (select MinAge + Age_bin from CTE) then "Younger"
  when age<(select MinAge + Age_bin*2 from CTE) then "Middle"
else "Older" 
end;

select * from insurance;


-- create a column is health. 
-- If the age is less than avg(age) and bmi is greater than avg(bmi) ---> unhealthy else healthy 

alter table insurance add column Health varchar(50);


with CTES as (
select 
avg(age) as Avg_Age,
avg(bmi) as Avg_bmi
from insurance)
update insurance set Health =case
  when age< (select Avg_Age from CTES) and bmi<(select Avg_bmi from CTES) then "Unhealthy"
else "Healthy" 
end;

select * from insurance;



