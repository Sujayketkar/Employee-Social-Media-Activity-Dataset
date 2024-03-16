create table posts (
Emp_ID VARCHAR(50),
Date_posted DATE)

SELECT * FROM Posts;

--employee posting frequency 
Select Emp_ID, count(Date_posted) AS NUM_POSTS
FROM Posts
WHERE Date_Posted BETWEEN '2023-1-1' AND '2023-03-30'
GROUP BY Emp_ID
ORDER BY Num_Posts DESC

--highly active employees


SELECT DISTINCT Emp_ID, COUNT(DATE_POSTED) AS NUM_POSTS
FROM posts
WHERE Date_posted BETWEEN '2023-01-01' AND '2023-03-30'
GROUP BY Emp_ID, DATE_TRUNC('week', Date_posted)
HAVING count(*)>=7
ORDER BY emp_id ASC;


---find out employees who post every alternate day

WITH ranked_posts AS (
    SELECT 
        emp_id,
        Date_posted,
        ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY Date_posted) AS post_rank
    FROM 
        posts
    WHERE 
        Date_posted BETWEEN '2023-01-01' AND '2023-03-30'
)
SELECT DISTINCT emp_id
FROM ranked_posts
WHERE 
    MOD(post_rank, 2) = 1
    AND Date_posted < '2023-03-30'; -- Ensuring there's a post after the last one


--employees who post on every sunday
SELECT emp_id
FROM posts
WHERE EXTRACT(DOW FROM Date_posted) = 0 -- 0 for Sunday
AND Date_posted BETWEEN '2023-01-01' AND '2023-03-30'
GROUP BY emp_id
HAVING COUNT(*) = (DATE_PART('week',CAST('2023-03-30'AS DATE)) - - DATE_PART('week', CAST('2023-01-01' AS DATE)) + 1);

 --find out all posts by emp-ID 9 in the month of Jan.

SELECT Date_posted
FROM posts
WHERE emp_id = '9'
  AND DATE_PART('month', Date_posted) = 1
  AND Date_posted BETWEEN '2023-01-01' AND '2023-01-31';
  
 --find out all posts by emp-ID 9 in the month of Feb

SELECT Date_posted
FROM posts
WHERE emp_id = '9'
  AND DATE_PART('month', Date_posted) = 2
  AND Date_posted BETWEEN '2023-02-01' AND '2023-02-28';
  
--all posts by emp no 9 in the dataset
SELECT Date_posted
FROM posts
WHERE emp_id = '9'
ORDER BY date_posted ASC

--dates when employee # 6 and #9 have posted 
 
SELECT e1.Date_posted
FROM posts AS e1
JOIN posts AS e2 ON e1.Date_posted = e2.Date_posted
WHERE e1.emp_id = '6'
  AND e2.emp_id = '9';

--dates when employee # 6 and #9 have posted in the month of January.

SELECT e1.Date_posted
FROM posts AS e1
JOIN posts AS e2 ON e1.Date_posted = e2.Date_posted
WHERE e1.emp_id = '6'
  AND e2.emp_id = '9'
AND DATE_PART('month', e1.Date_posted) = 1
AND e1.Date_posted BETWEEN '2023-01-01' AND '2023-01-31';

--THE END--

