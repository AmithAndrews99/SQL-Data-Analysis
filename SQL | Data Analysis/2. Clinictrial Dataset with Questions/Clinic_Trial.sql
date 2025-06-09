create database clinic_trial;
use clinic_trial;

select * from clinictrial;

-- 1. Add index name fast on Name

-- 2. Describe the schema of table
describe clinictrial;

-- 3. Find average of Age
select avg(age) as Avg_Age
from clinictrial;


-- 4. Find minimum of Age
select min(age) as MIN_Age
from clinictrial;


-- 5. Find maximum of Age
select max(age)
from clinictrial;


-- 6. Find average age of those were pregnant and not pregnant
select pregnant,avg(age)
from clinictrial
group by pregnant;


-- 7. Find average blood pressure of those had drug reaction and did not had drug
-- reaction
select drug_reaction,avg(BP)
from clinictrial
group by drug_reaction;


-- 8. Add new column name as ‘Age_group’ and those having age between 16 & 21
-- should be categorized as Low, more than 21 and less than 35 should be
-- categorized as Middle and above 35 should be categorized as High.

select *, case when age between '16' and '21' then 'low' else 'High' end as Age_Group
from clinictrial;


-- 9. Change ‘Age’ of Reetika to 32
update clinictrial
set age=32
where name ='Reetika';



-- 10. Change name of Reena as Shara’
update clinictrial
set name = 'Shara'
where name = 'Reetika';

select * from clinictrial;


-- 11. Remove Chlstrl column
alter table clinictrial
drop column chlstrl;


-- 12. Select only Name, Age and BP
select name,age,BP
from clinictrial;

-- 13. Select ladies whose first name starts with ‘E’
select name
from clinictrial
where name like 'E%';


-- 14. Select ladies whose Age_group were Low
select name,Age_Group from (
select name, case when age between '16' and '21' then 'low' else 'High' end as Age_Group
from clinictrial) as t
where Age_group = 'Low';


-- 15. Select ladies whose Age_group were High
select name,Age_Group from (
select name, case when age between '16' and '21' then 'low' else 'High' end as Age_Group
from clinictrial) as t
where Age_group = 'High';


-- 16. Select ladies whose name starts with ‘A’ and those were pregnant
select *
from clinictrial
where name like 'A%' and Pregnant='Yes';


-- 17. Identify ladies whose BP was more than 120
select name,BP
from clinictrial
where BP>120;

-- 18. Identify ladies whose BP was between 100 and 120
select name,BP
from clinictrial
where BP between 100 and 120;


-- 19. Identify ladies who had low anxiety aged less than 30
select name,anxty_LH,age
from clinictrial
where anxty_LH = 'no' and age<30;

select * from clinictrial;

-- 20. Select ladies whose name ends with ‘i’
select name
from clinictrial
where name like '%i';


-- 21. Select ladies whose name ends with ‘a’
select name
from clinictrial
where name like '%a';


-- 22. Select ladies whose name starts with ‘K’
select name
from clinictrial
where name like 'k%';

SELECT Name FROM clinictrial  
WHERE Name LIKE 'z%' AND Pregnant = 'Yes'
UNION 
SELECT 'Nil' WHERE NOT EXISTS (
    SELECT 1 FROM clinictrial WHERE Name LIKE 'z%' AND Pregnant = 'Yes'
);


-- 23. Select ladies whose name have ‘a’ anywhere
select name from 
clinictrial
where name like '%a%';


-- 24. Order ladies in ascending way based on ‘BP’
select name,BP
from clinictrial
order by BP asc;


-- 25. Order ladies in descending way based on ‘Age’
select name,Age
from clinictrial
order by age desc;