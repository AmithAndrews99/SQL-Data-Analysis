create database if not exists cereals_data;
use cereals_data;

show tables;
select * from cereals_data;

-- 1. Add index name fast on name
-- index is used for faster retrieval of data
create index fast on cereals_data (name);
describe cereals_data;

select max(length(name)) from cereals_data;

select name
from cereals_data
where length(name)= (select max(length(name)) from cereals_data);

alter table cereals_data modify name varchar (40);
create index fast on cereals_data(name);

-- 2. Describe the schema of table
describe cereals_data;

-- 3. Create view name as see where users can not see type column [first run appropriate query
-- then create view]

-- 4. Rename the view as saw

-- 5. Count how many are cold cereals
select type,count(*)
from cereals_data
where type = 'C';

-- 6. Count how many cereals are kept in shelf 3
select count(*) as in_shelf3
from cereals_data
where shelf=3;

-- 7. Arrange the table from high to low according to ratings
select * from cereals_data
order by rating desc;

-- 8. Suggest some column/s which can be Primary key
select name,mfr
from cereals_data
order by mfr;
-- in this case name is the most appropriate primary key as its uniquely produced by each manufactere

-- 9. Find average of calories of hot cereal and cold cereal in one query
select type,avg(calories) as avg_calorie 
from cereals_data
group by type;

-- 10. Add new column as HL_Calories where more than average calories should be categorized as
-- HIGH and less than average calories should be categorized as LOW
select name,case 
when calories>(select avg(calories) as Avg_Calories from cereals_data) then 'High' else 'low' end as HL_Calories
from cereals_data;

-- 11. List only those cereals whose name begins with B
select name 
from cereals_data 
where name like'B%';

-- 12. List only those cereals whose name begins with F
select name 
from cereals_data 
where name like 'F%';

-- 13. List only those cereals whose name ends with s
select name
from cereals_data
where name like '%s';

-- 14. Select only those records which are HIGH in column HL_calories and mail to
-- jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>]

-- 15. Find maximum of ratings
select max(rating)
from cereals_data;

-- 16. Find average ratings of those were High and Low calories
select HL_calories,avg(rating) as AVG_Rating from (

select name,case when calories >(select avg(calories) from cereals_data) then 'High' else 'Low' end as HL_Calories, rating 
from cereals_data) as t
group by HL_calories;


-- 17. Craete two examples of Sub Queries of your choice and give explanation in the script
-- itself with remarks by using #

select name, rating
from cereals_data
where rating > (
    select avg(rating)
    from cereals_data
)
;
-- This query retrieves the names of cereals with a rating higher than the average rating across all cereals.
-- Subquery: This calculates the average rating of all cereals


-- 18. Remove column fat
alter table cereals_data
drop column fat;

-- 19. Count records for each manufacturer [mfr]
select mfr, count(*) as count_records
from cereals_data
group by mfr;

-- 20. Select name, calories and ratings only
select name,calories,rating
from cereals_data;










