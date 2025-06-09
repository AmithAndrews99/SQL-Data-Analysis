create database movie_dataset;
use movie_dataset;

show tables;

-- i. Write a SQL query to find when the movie 'American Beauty' released. Return
-- movie release year.
select * from movie;

select mov_title,mov_dt_rel
from movie
where mov_title = 'American Beauty';

-- ii. Write a SQL query to find those movies, which were released before 1998. Return
-- movie title.
select mov_title
from movie
where mov_year < 1998;


-- iii. Write a query where it should contain all the data of the movies which were
-- released after 1995 and their movie duration was greater than 120.
select * from movie;

select * 
from movie
where mov_year > 1995 and mov_time > 120;


-- iv. Write a query to determine the Top 7 movies which were released in United
-- Kingdom. Sort the data in ascending order of the movie year.

select * from movie;
select mov_title
from movie
where mov_rel_country = 'UK'
order by mov_year asc
limit 7;



-- v. Set the language of movie language as 'Chinese' for the movie which has its
-- existing language as Japanese and the movie year was 2001.

update movie
set mov_lang = 'Chinese' 
where mov_lang ='Japanese' and mov_year = 2001;


-- vi. Write a SQL query to find name of all the reviewers who rated the movie
-- 'Slumdog Millionaire'.

select * from movie;
select * from reviewer;
select * from ratings;

select *
from reviewer
inner join ratings on reviewer.rev_id=ratings.rev_id
inner join movie using (mov_id)
where mov_title = 'Slumdog Millionaire';


-- vii. Write a query which fetch the first name, last name & role played by the
-- actor where output should all exclude Male actors.
select *from cast;
select * from actor;

select act_fname, act_lname,role,act_gender
from cast
inner join actor using (act_id)
where act_gender='F';



-- viii. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'.
-- Fetch all the fields of actor table. (Hint: Use the IN operator).

    select actor.* 
    from actor
    where act_id in(
    
    select cast.act_id
    from cast 
    join movie on cast.mov_id = movie.mov_id
    where movie.mov_title = 'Annie Hall');


-- ix. Write a SQL query to find those movies that have been released in countries other
-- than the United Kingdom. Return movie title, movie year, movie time, and date of
-- release, releasing country.

select mov_title,mov_year,mov_time,mov_dt_rel,mov_rel_country
from movie
where mov_rel_country not in ('UK');


-- x. Print genre title, maximum movie duration and the count the number of
-- movies in each genre. (HINT: By using inner join)

-- genre,movie,movie genre

select gen_title,max(mov_time) as MAX_Duration,count(mov_id)_No_of_Movies
from genres
inner join movie_genres on genres.gen_id=movie_genres.gen_id
inner join movie using(mov_id)
group by gen_title;

-- xi. Create a view which should contain the first name, last name, title of the
-- movie & role played by particular actor.




-- xii. Write a SQL query to find the movies with the lowest ratings
select * from ratings;

select mov_title,rev_stars
from ratings
inner join movie using(mov_id)
order by rev_stars asc;

-- xiii. Finally Mail the script to jeevan.raj@imarticus.com

