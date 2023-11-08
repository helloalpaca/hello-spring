-- step1
USE sqldb;

SET @myVAR1 = 5;
SET @myVAR2 = 3;
SET @myVAR3 = 4.25;
SET @myVAR4 = '가수 이름==>';

SELECT @myVAR1;
SELECT @myVAR2 + @myVAR3;
SELECT @myVAR4, Name FROM usertbl WHERE height > 180;

-- step2
SET @myVAR1 = 3;
PREPARE myQuery
	FROM 'SELECT Name, height FROm usertbl ORDER BY height LIMIT ?';
EXECUTE myQUERY USING @myVAR1;
