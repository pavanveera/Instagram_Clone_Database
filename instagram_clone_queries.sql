#Working with Instagram Clone Database


#Finding Oldest 5 Users to send them Rewards

SELECT * 
FROM users
ORDER BY created_at 
LIMIT 5;

#What Day of the week do most users register on?

SELECT DAYNAME(created_at), COUNT(id)
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(id) DESC LIMIT 2;

#Finding users who never posted a photo

SELECT username from users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.user_id IS NULL;

#Finding user with Most like on a single photo

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

#How many times does an Average user post

SELECT (select COUNT(*) from photos) / (select COUNT(*) from users) AS avg;

#Finding the 5 most popular hashtags

SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

#Finding the bots - the users who liked every single photo

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 



