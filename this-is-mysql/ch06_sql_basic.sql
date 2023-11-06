SELECT * FROM usertbl WHERE name='김경호';

-- AND절
SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 AND height >= 182;

-- OR절
SELECT userID, Name FROM usertbl WHERE birthYear >= 1970 OR height >= 182;

-- BETWEEN
SELECT name, height FROM usertbl WHERE height >= 180 AND height <= 183; 
SELECT name, height FROm usertbl WHERE height BETWEEN 180 AND 183; -- 위와 동일한 SQL

-- IN
SELECT name, addr FROM usertbl WHERE addr='경남' OR addr='전남' OR addr='경북';
SELECT name, addr FROM usertbl WHERE addr IN ('경남', '전남', '경북'); -- 위와 동일한 SQL

-- LIKE
SELECT name, height FROM usertbl WHERE name LIKE '김%'; -- 성이 '김'이고 그 뒤는 무엇이든(%) 허용
SELECT name, height FROM usertbl WHERE name LIKE '_종신'; -- 한글자와 매치하기 위해서는 _을 사용
-- %나 _가 검색할 문자열의 제일 앞에 들어가는 것은 MySQL 성능에 나쁜 영향을 끼칠 수 있다.

-- 서브쿼리 (ANY, ALL, SOME)
SELECT name, height FROM usertbl
	WHERE height > (SELECT height FROM usertbl WHERE NAME='김경호');

SELECT name, height FROM usertbl
	WHERE height >= ANY (SELECT height FROM usertbl WHERE addr='경남');

SELECT name, height FROM usertbl
	WHERE height >= ALL (SELECT height FROM usertbl WHERE addr='경남');
    
SELECT name, height FROM usertbl
	WHERE height = ANY ( SELECT height FROM usertbl WHERE addr='경남');
SELECT name, height FROM usertbl
	WHERE height IN (SELECT height FROM usertbl WHERE addr='경남');

-- ORDER BY: 정렬
SELECT name, mDate FROM usertbl ORDER BY mDate; -- 오름차순(ascending)
SELECT name, mDate FROM usertbl ORDER BY mDate DESC; -- 내림차순(descending)
SELECT name, height FROM usertbl ORDER BY height DESC, name ASC;

-- DISTINCT: 중복 제외
SELECT addr FROM usertbl;
SELECT DISTINCT addr FROM usertbl;

-- LIMIT: 출력 개수 제한
USE employees;
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 5; -- 상위 N개만 조회
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 0, 5; -- LIMIT 5 OFFSET 0와 동일

-- CREATE TABLE ... SELECT: 테이블 복사
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);
SELECT * FROM buytbl3;

-- GROUP BY
SELECT userID, amount FROM buytbl ORDER BY userID;
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수' FROM buytbl GROUP BY userID;
SELECT userID AS '사용자 아이디', SUM(amount*price) AS '총 구매액' FROM buytbl GROUP BY userID;

-- AVG: 평균
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl;
SELECT userID, AVG(amount) AS '평균 구매 개수' FROM buytbl GROUP BY userID;

-- MIN: 최소, MAX: 최대
SELECT name, height FROM usertbl
	WHERE height = (SELECT MAX(height) FROM usertbl)
    OR height = (SELECT MIN(height) FROm usertbl);

-- COUNT: 행의 개수
SELECT COUNT(*) FROM usertbl;
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM usertbl;

-- COUNT(DISTINCT): 행의 개수(중복은 1개만 인정)
-- STDEV: 표준편차
-- VAR_SAMP: 분산

-- Having: 집계함수에 대해서 조건을 제한
SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'
	FROM buytbl
    GROUP BY userId
    HAVING SUM(price*amount) > 1000;
    
SELECT userID AS '사용자', SUM(price*amount) AS '총구매액'
	FROM buytbl
    GROUP BY userId
    HAVING SUM(price*amount) > 1000
    ORDER BY SUM(price*amount);
    
-- WITH ROLLUP: 총합 또는 중간 합계
SELECT num, groupName, SUM(price*amount) AS '비용'
	FROM buytbl
    GROUP BY groupName, num
    WITH ROLLUP; -- 분류(groupName) 별로 합계 및 그 총합을 구할 때
    
SELECT groupName, SUM(price*amount) AS '비용'
	FROM buytbl
    GROUP BY groupName
    WITH ROLLUP;

-- DML : 데이터 조작 언어 (SELECT, INSERT, UPDATE, DELETE)
-- DDL : 데이터베이스 개체 조작 언어 (CREATE, DROP, ALTER)
-- DCL : 사용자 권한 부여 (GRANT, REVOKE, DENY)

-- INSERT
CREATE TABLE testTbl1 (id INT, userName CHAR(3), age INT);
INSERT INTO testTbl1 VALUES(1, '홍길동', 25);
INSERT INTO testTbl1(id, userName) VALUES(2, '설현'); -- 생략한 age에는 NULL이 들어감
INSERT INTO testTbl1(userName, age, id) VALUES('하니', 26, 3);

-- AUTO_INCREMENT
CREATE TABLE testTbl2 (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userName CHAR(3),
    age INT);
INSERT INTO testTbl2 VALUES (NULL, '지민', 25);
INSERT INTO testTbl2 VALUES (NULL, '유나', 22);
INSERT INTO testTbl2 VALUES (NULL, '유경', 21);
SELECT * FROM testTbl2;
SELECT LAST_INSERT_ID(); -- 마지막에 입력된 ID값

ALTER TABLE testTbl2 AUTO_INCREMENT=100; -- 입력값을 100부터 시작하도록
INSERT INTO testTbl2 VALUES(NULL, '찬미', 23);
SELECT * FROM testTbl2;

CREATE TABLE testTbl3 (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userName CHAR(3),
    age INT);
ALTER TABLE testTbl3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3; -- 증가값 3으로 변경
INSERT INTO testTbl3 VALUES (NULL, '나연', 20);
INSERT INTO testTbl3 VALUES (NULL, '정연', 18);
INSERT INTO testTbl3 VALUES (NULL, '모모', 19);
SELECT * FROM testTbl3;

-- 대량의 샘플 데이터 생성 (employees에서 가져옴)
CREATE TABLE testTbl4(id INT, Fname VARCHAR(50), Lname VARCHAR(50));
INSERT INTO testTbl4
	SELECT emp_no, first_name, last_name
		FROM employees.employees;

CREATE TABLE testTbl5 (SELECT emp_no, first_name, last_name FROM employees.employees); -- 테이블 정의까지 생략

-- UPDATE
UPDATE testTbl4 SET Lname='없음' WHERE Fname = 'Kyoichi'; -- WHERE 조건문이 없으면, 전체 행에 반영됨
UPDATE buytbl SET price = price * 1.5;

-- DELETE
DELETE FROM testTbl4 WHERE Fname='Aamer';
DELETE FROM testTbl4 WHERE Fname='Aamer' LIMIT 5; -- 상위 5건만 삭제

-- CTE (Common Table Expression)
-- 비재귀적 CTE
WITH abc(userid, total)
	AS (SELECT userid, SUM(price*amount) FROM buytbl GROUP BY userid)
	SELECT * FROM abc ORDER BY total DESC;

