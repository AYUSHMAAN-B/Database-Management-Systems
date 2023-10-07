--11111111111111111111111

SELECT act_fname as first_name, act_lname as last_name
FROM actor
UNION 
SELECT dir_fname as first_name, dir_lname as last_name
FROM director
ORDER BY first_name;

--222222222222222222222222

SELECT rev_name, mov_title, rev_stars
FROM reviewer, rating, movie
WHERE reviewer.rev_id=rating.rev_id AND movie.mov_id=rating.mov_id AND rev_stars >= 7;

--3333333333333333333333333

SELECT mov_title
FROM movie
WHERE mov_id NOT IN ( SELECT mov_id
		      FROM rating );

--4444444444444444444444

SELECT mov_title, mov_year, mov_duration, mov_rel_date, mov_rel_country
FROM movie
WHERE mov_rel_country <>'USA';

--55555555555555555555555

SELECT rev_name, rev_stars
FROM reviewer NATURAL JOIN rating
WHERE rev_stars IS NULL;

--6666666666666666666666

SELECT rev_name, mov_title, rev_stars
FROM reviewer NATURAL JOIN rating NATURAL JOIN movie
WHERE rev_stars IS NOT NULL AND rev_name IS NOT NULL;

--7777777777777777777777

SELECT rev_name, movie.mov_title
FROM reviewer , movie, rating AS r1, rating AS r2
WHERE movie.mov_id = r1.mov_id AND reviewer.rev_id = r1.rev_id AND r1.rev_id = r2.rev_id
GROUP BY rev_name, movie.mov_title
HAVING COUNT(*)>1;

--88888888888888888888888

SELECT mov_title
FROM movie NATURAL JOIN rating NATURAL JOIN reviewer
EXCEPT
SELECT mov_title
FROM movie NATURAL JOIN rating NATURAL JOIN reviewer
WHERE rev_name = 'Paul Monks';

--9999999999999999999999

SELECT rev_name, mov_title, rev_stars
FROM reviewer, movie, rating
WHERE reviewer.rev_id = rating.rev_id and movie.mov_id = rating.mov_id AND rating.rev_stars = ( SELECT min(rev_stars) FROM rating );

--10 10 10 10 10 10 10 10

SELECT mov_title
FROM movie NATURAL JOIN movie_direction NATURAL JOIN director
WHERE (director.dir_fname, director.dir_lname) = ( 'James', 'Cameron' );

--11 11 11 11 11 11 11 11

SELECT rev_name
FROM reviewer, rating
WHERE rev_stars IS NULL AND reviewer.rev_id = rating.rev_id;

--12 12 12 12 12 12 12 12

SELECT act_fname, act_lname
FROM actor, movie, movie_cast
WHERE actor.act_id = movie_cast.act_id AND movie.mov_id = movie_cast.mov_id AND mov_year NOT BETWEEN 1990 AND 2000;

--13 13 13 13 13 13 13 13

SELECT dir_fname, dir_lname, gen_title, count( movie.mov_id )
FROM director, movie, movie_direction, genres, movie_genres
WHERE director.dir_id = movie_direction.dir_id AND movie_direction.mov_id = movie.mov_id AND movie.mov_id = movie_genres.mov_id AND movie_genres.gen_id = genres.gen_id
GROUP BY dir_fname, dir_lname, gen_title
ORDER BY dir_fname, dir_lname;

--14 14 14 14 14 14 14 14

SELECT mov_title, mov_year, gen_title, dir_fname
FROM movie, director, movie_direction, genres, movie_genres
WHERE director.dir_id = movie_direction.dir_id AND movie_direction.mov_id = movie.mov_id AND movie.mov_id = movie_genres.mov_id AND movie_genres.gen_id = genres.gen_id;

--15 15 15 15 15 15 15 15

SELECT gen_title, avg(mov_duration) AS avg_time, COUNT(gen_title)
FROM movie NATURAL JOIN movie_genres NATURAL JOIN genres
GROUP BY gen_title;

--16 16 16 16 16 16 16 16

SELECT mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
FROM actor NATURAL JOIN movie NATURAL JOIN movie_cast NATURAL JOIN movie_direction NATURAL JOIN director
WHERE mov_duration = ( SELECT min(mov_duration) FROM movie );

--17 17 17 17 17 17 17 17

SELECT rev_name, mov_title, rev_stars
FROM reviewer NATURAL JOIN rating NATURAL JOIN movie
WHERE rev_name IS NOT NULL;

--18 18 18 18 18 18 18 18

SELECT mov_title, dir_fname, dir_lname, rev_stars
FROM movie NATURAL JOIN movie_direction NATURAL JOIN director NATURAL JOIN rating
WHERE rev_stars IS NOT NULL;

--19 19 19 19 19 19 19 19

SELECT act_fname, act_lname, mov_title, role
FROM actor NATURAL JOIN director NATURAL JOIN movie_cast NATURAL JOIN movie_direction NATURAL JOIN movie
WHERE act_fname = dir_fname AND act_lname = dir_lname;

--20 20 20 20 20 20 20 20

SELECT act_fname, act_lname
FROM actor NATURAL JOIN movie_cast NATURAL JOIN movie
WHERE mov_title = 'Chinatown';

--21 21 21 21 21 21 21 21

SELECT mov_title
FROM actor NATURAL JOIN movie_cast NATURAL JOIN movie
WHERE act_fname = 'Harrison' AND act_lname = 'Ford';

--22 22 22 22 22 22 22 22

SELECT mov_title, mov_year, rev_stars
FROM movie NATURAL JOIN movie_genres NATURAL JOIN genres NATURAL JOIN rating
WHERE gen_title = 'Mystery'
ORDER BY rev_stars DESC;

--23 23 23 23 23 23 23 23

SELECT ALL mov_title, act_fname || ' ' || act_lname AS act_name, mov_year, role, gen_title, dir_fname ||  ' ' || dir_lname AS dir_name, mov_rel_date, rev_stars
FROM actor NATURAL JOIN movie_cast NATURAL JOIN movie NATURAL JOIN movie_direction NATURAL JOIN director NATURAL JOIN rating NATURAL JOIN movie_genres NATURAL JOIN genres
WHERE act_gender = 'F';

--24 24 24 24 24 24 24 24

SELECT act_fname, act_lname, mov_year
FROM actor NATURAL JOIN movie_cast NATURAL JOIN movie
where mov_year IN ( SELECT mov_year
	FROM director NATURAL JOIN movie_direction NATURAL JOIN movie
	WHERE dir_fname = 'Stanley' AND dir_lname = 'Kubrick' );