create database social_media_usage;
use social_media_usage;

select * from social_media_usage;

-- Q1: List all unique apps in the dataset.
select distinct app from social_media_usage;

-- Q2: Count the number of users per app.
select app, count(*) as user_count from social_media_usage group by app;

-- Q3: Find the average daily minutes spent on each app.
select app, avg(daily_minutes_spent) as avg_minutes from social_media_usage group by app;

-- Q4: Find the user who spends the most time daily on social media.
select user_id, app, daily_minutes_spent from social_media_usage order by daily_minutes_spent desc limit 1;

-- Q5: Find the total number of posts made per app.
select app, sum(posts_per_day) as total_posts from social_media_usage group by app;

-- Q6: Using a window function, rank users by daily_minutes_spent within each app.
select user_id, app, daily_minutes_spent, rank() over (partition by app order by daily_minutes_spent desc) as rank_within_app from social_media_usage;

-- Q7: Calculate the running total of likes per day for each app.
select user_id, app, likes_per_day, sum(likes_per_day) over (partition by app order by user_id) as running_likes from social_media_usage;

-- Q8: Find the top 3 users with the highest follows_per_day for each app using row_number.
with ranked as (
  select user_id, app, follows_per_day, row_number() over (partition by app order by follows_per_day desc) as rn
  from social_media_usage
)
select * from ranked where rn <= 3;

-- Q9: Find the average posts_per_day for users who spend more than 200 minutes daily.
select avg(posts_per_day) as avg_posts from social_media_usage where daily_minutes_spent > 200;

-- Q10: Count the number of users who post more than 10 times a day.
select count(*) as high_post_users from social_media_usage where posts_per_day > 10;

-- Q11: Using CTE, find the app with the highest average likes_per_day.
with avg_likes as (
  select app, avg(likes_per_day) as avg_likes from social_media_usage group by app
)
select app from avg_likes where avg_likes = (select max(avg_likes) from avg_likes);

-- Q12: Using CTE, find users whose likes_per_day is above the app average.
with app_avg as (
  select app, avg(likes_per_day) as avg_likes from social_media_usage group by app
)
select s.user_id, s.app, s.likes_per_day from social_media_usage s
join app_avg a on s.app = a.app
where s.likes_per_day > a.avg_likes;

-- Q13: Show the percentage of total users per app.
select app, count(*) * 100.0 / (select count(*) from social_media_usage) as percentage from social_media_usage group by app;

-- Q14: Find the user with the highest combined posts, likes, and follows per day.
select user_id, posts_per_day + likes_per_day + follows_per_day as total_activity from social_media_usage order by total_activity desc limit 1;

-- Q15: List users whose follows_per_day is zero.
select user_id, app from social_media_usage where follows_per_day = 0;

-- Q16: Using a window function, calculate the average daily_minutes_spent per app and display it with each user.
select user_id, app, daily_minutes_spent, avg(daily_minutes_spent) over (partition by app) as app_avg_minutes from social_media_usage;

-- Q17: Create a ranking of all users based on total engagement (posts + likes + follows).
select user_id, app, posts_per_day + likes_per_day + follows_per_day as engagement, rank() over (order by posts_per_day + likes_per_day + follows_per_day desc) as engagement_rank from social_media_usage;

-- Q18: Using a window function, show each user's daily_minutes_spent and the average daily_minutes_spent across all users.
select user_id, app, daily_minutes_spent, avg(daily_minutes_spent) over () as overall_avg_minutes from social_media_usage;

-- Q19: Find the average follows_per_day for users who post less than 5 times a day.
select avg(follows_per_day) as avg_follows from social_media_usage where posts_per_day < 5;

-- Q20: Using a CTE, calculate total daily_minutes_spent per app and show apps above overall average.
with app_totals as (
  select app, sum(daily_minutes_spent) as total_minutes from social_media_usage group by app
),
overall_avg as (
  select avg(total_minutes) as avg_total from app_totals
)
select app, total_minutes from app_totals, overall_avg where total_minutes > avg_total;
