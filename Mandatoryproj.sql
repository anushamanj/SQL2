/*1.Create an ER diagram or draw a schema for the given database.*/


/*2.We want to reward the user who has been around the longest, Find the 5 oldest users.*/

select id, username,created_at as longest from users 
order by longest limit 5;



/*3.To target inactive users in an email ad campaign, find the users who have never posted a photo.*/

select * from users 
where id not in 
(select distinct user_id from photos);

/*4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?*/

select u.id,u.username,a.mostlikes from users u
inner join photos p on p.user_id=u.id
inner join
(select photo_id,count(*) mostlikes from likes 
group by photo_id
order by mostlikes desc
limit 1) a
on a.photo_id=p.id;



/*5.The investors want to know how many times does the average user post.*/

select (select count(*) from photos)/(select count(*) from users) as average;


/*6 .A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.*/

select pt.tagscount,t.tag_name from
(select tag_id,count(tag_id) as tagscount from photo_tags
group by tag_id) as pt
inner join tags t on pt.tag_id=t.id
order by tagscount desc
limit 5;



/*7.To find out if there are bots, find users who have liked every single photo on the site.*/

select u.username from likes l
inner join users u on u.id=l.user_id
group by u.username
having count(*)=(select count(*) from photos);


/*8.Find the users who have created instagram id in may and select top 5 newest joinees from it?*/

Select u.* from users u where month(created_at)='05'
order by created_at desc
limit 5;


/*9.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?*/

Select distinct ci.* from 
(select * from users where username like 'C%' and username regexp '[0-9]$') as Ci
inner join 
photos p on ci.id=p.user_id 
inner join 
likes l on ci.id=l.user_id



/*10.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.*/

select u.id,u.username from users u
where (select count(*) from photos p where p.user_id=u.id ) between 3 and 5
order by u.id asc
limit 30;


