-- 한줄 주석
/*
여러줄 주석
*/

-- step1
SHOW DATABASES;

-- step2
USE employees;

-- step3
SHOW TABLE STATUS;

-- step4
DESC employees;

-- step5
SELECT first_name, gender FROM employees;

-- 추가) 별칭
SELECT first_name AS 이름, gender AS 성별, hire_date AS '회사 입사일' FROM employees; -- 별칭
