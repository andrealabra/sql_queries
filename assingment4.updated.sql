#Andrea Labra Orozco CS431 Assingment 2 


-- 1 
CREATE VIEW movie_legendary_technisians AS
SELECT 
CONCAT(title) AS Movie, 
CONCAT(first_name,' ',last_name)  as 'Movie Technicians',
(DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),birth_date)), '%Y')+0) AS Age 
FROM movies, artists, movie_cast
WHERE movies.movie_id = movie_cast.movie_id
	  AND movie_cast.person_id = artists.artist_id
      AND (DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),birth_date)), '%Y')+0) > 40;
      
-- 2 
DELIMITER $$
CREATE PROCEDURE must_watch_movies__()
BEGIN
DECLARE d INT DEFAULT 0;
declare movie_name varchar(100);
declare Distributor_name varchar(20);
declare r_date date;
declare result varchar(500) DEFAULT '';
declare Get_cur cursor FOR
    SELECT title, Distributor, release_date 
    FROM movies
    WHERE gross > 2; 
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'  
SET d = 1;
OPEN Get_cur;  
lbl: LOOP  
IF d = 1 THEN  LEAVE lbl;  
END IF;  
IF NOT d = 1 THEN  
	FETCH Get_cur INTO movie_name, Distributor_name, r_date;  
 	SET result = CONCAT(result, '\'',  movie_name, '\'', ',' , '\'' ,Distributor_name, '\'' ', ', '\'',YEAR(r_date),'\'', ' | ');
END IF;  
END LOOP;
SELECT result AS 'Must Watch Movies';
CLOSE Get_cur; 
END$$
DELIMITER ;


      

