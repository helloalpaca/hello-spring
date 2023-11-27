-- 변수
SET @myvar = 12;
SELECT @myvar;

-- CAST, CONVERT: 데이터 형식 변환 함수 
Use sqldb;
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl;
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;

SELECT CAST('2020$12$12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=') AS '단가X수량', 
	price*amount AS '구매액' FROm buytbl;

-- 암시적 형 변환    
SELECT '100' + '200'; -- 문자와 문자를 더함(정수로 변환되서 연산됨)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수가 문자로 변환되서 처리)
SELECT 1 > '2mega'; -- 정수인 2로 변환되어서 비교
SELECT 3 > '2MEGA'; -- 정수인 2로 변환되어서 비교
SELECT 0 = 'mega2'; -- 문자는 0으로 변환됨

-- 제어 흐름 함수
SELECT IF(100>200, '참이다', '거짓이다');
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요'); -- NULL이 아니면 수식1, NULL이면 수식2 반환
SELECT NULLIF(100, 100), NULLIF(200, 100); -- 수식1==수식2면 NULL, 다르면 수식1 반환

SELECT CASE 10
	WHEN 1 THEN '일'
    WHEN 5 THEN '오'
    WHEN 10 THEN '십'
	ELSE '모름'
END AS 'CASE연습';

-- 문자열 함수
SELECT ASCII('A'), CHAR(65);

SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc');
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');

SELECT CONCAT_WS('/', '2025', '01', '01');

SELECT ELT(2, '하나', '둘', '셋'); -- 위치 번째에 해당하는 문자열 반환
SELECT FIELD('둘', '하나', '둘', '셋'); -- 찾을 문자열의 위치를 찾아서 반환, 없으면 0 반환
SELECT FIND_IN_SET('둘', '하나,둘,셋'); -- 찾을 문자열을 문자열 리스트에서 찾아서 위치 반환
SELECT INSTR('하나둘셋', '둘'); -- 기준 문자열에서 부분 문자열 찾아서 그 시작 위치를 반환
SELECT LOCATE('둘', '하나둘셋'); -- INSTR과 파라미터의 순서가 반대alter

SELECT FORMAT(123456.123456, 4); -- 소수점 아래 자리수

SELECT BIN(31); -- 2진수
SELECT HEX(31); -- 16진수
SELECT OCT(31); -- 8진수

SELECT INSERT('abcdefghi', 3, 4, '@@@@'), INSERT('abcdefghi', 3, 2, '@@@@'); -- (기준 문자열)의 (위치)부터 (길이)만큼 지우고 (삽입할 문자열)을 끼워넣는다.

SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3); -- 왼쪽 또는 오른쪽에서 문자열의 길이만큼 반환

SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH'); -- 소문자를 대문자로, 대문자를 소문자로 반환

SELECT LPAD('이것이', 5, '##'), RPAD('이것이', 5, '##'); -- (문자열)을 (길이)만큼 늘린 후에, 빈 곳을 채울 문자열로 채운다.

SELECT LTRIM('    이것이'), RTRIM('이것이     '); -- 왼쪽/오른쪽 공백 제거, 중간의 공백은 제거되지 않는다.
SELECT TRIM('   이것이   '); -- 앞뒤 공백 제거
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋㅋ'); -- (방향)으로 (자를 문자열)을 자른다. 방향에는 LEADING(앞), BOTH(양쪽), TRAILING(뒤)가 나올 수 있다.

SELECT REPEAT('이것이', 3); -- 문자열을 횟수만큼 반복

SELECT REPLACE('이것이 MySQL이다', '이것이', 'This is');

SELECT REVERSE('MySQL'); -- 거꾸로

SELECT CONCAT('이것이', SPACE(10), 'MySQL이다'); -- SPACE(길이): 길이만큼 공백을 반환

SELECT SUBSTRING('대한민국만세', 3, 2); -- 시작 위치부터 길이만큼 문자를 반환, 길이가 생략되면 문자열의 끝까지 반환

SELECT SUBSTRING_INDEX('cafe.naver.com', '.', 2); -- 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다.
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', -2); -- 횟수가 음수이면 오른쪽부터 세고 왼쪽을 버린다.

-- 수학 함수
SELECT ABS(-100); -- 절대값
-- ACOS, ASIN, ATAN, ATAN2, SIN, COS, TAN: 삼각함수와 관련된 함수

SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7); -- 올림, 내림, 반올림

SELECT CONV('AA', 16, 2), CONV(100, 10, 8); -- 숫자를 원래 진수에서 변환할 진수로 계산한다.
SELECT DEGREES(PI()), RADIANS(180);-- 라디안을 각도값으로, 각도값을 라디안값으로, 파이값 출력
-- EXP, LN, LOG, LOG2, LOG10: 지수, 로그와 관련된 함수
SELECT MOD(157,10), 157%10, 157 MOD 10; -- 나눈값
SELECT POW(2, 3), SQRT(9); -- 거듭제곱값, 제곱근
SELECT RAND(); -- 0이상 1 미만의 실수
SELECT FLOOR(1+(RAND() * (7-1))); -- m이상 n미만의 정수를 구하고 싶다면 FLOOR(m+ (RAND() * (n-m))) 사용

SELECT SIGN(100), SIGN(0), SIGN(-100.123); -- 양수, 0, 음수인지를 구한다

SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2); -- 소수점을 기준으로 정수 위치까지 구하고 나머지는 버림

-- 날짜 및 시간 함수
SELECT ADDTIME('2025-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10');
SELECT SUBTIME('2025-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');

SELECT CURDATE(); -- 현재 연월일
SELECT CURTIME(); -- 현재 시분초
SELECT NOW(), SYSDATE(); -- 연월일 시분초

SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURRENT_TIME()), SECOND(CURRENT_TIME), MICROSECOND(CURRENT_TIME);

SELECT DATE(NOW()), TIME(NOW());

SELECT DATEDIFF('2025-01-01', NOW()), TIMEDIFF('23:23:59', '12:11:10');

SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE()); -- 요일, 월 이름, 일년 중 몇일이 지났는지

SELECT LAST_DAY('2025-02-01'); -- 그 달이 몇일까지 있는지 확인

SELECT MAKEDATE(2025, 32); -- 2025년의 32일 지난 날짜인 2월 1일을 반환

SELECT MAKETIME(12, 11, 10);

SELECT PERIOD_ADD(202501, 11); -- 열월에서 개월만큼의 개월이 지난 연월을 구한다.
SELECT PERIOD_DIFF(202501, 202312); -- 연월1 - 연월2의 개월수

SELECT QUARTER('2025-07-07'); -- 주어진 날짜가 4분기 중에서 몇분기인지를 구한다.

SELECT TIME_TO_SEC('12:11:10'); -- 시간을 초단위로 구한다.

-- 시스템 정보 함수
SELECT CURRENT_USER(), DATABASE(); -- 현재 사용자, 현재 선택된 데이터베이스

USE sqldb;
SELECT * FROM usertbl;
SELECT FOUND_ROWS(); -- 바로 앞의 SELECT문에서 조회된 행의 개수를 반환

UPDATE buytbl SET price=price*2;
SELECT ROW_COUNT(); -- INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 개수를 구한다.

SELECT VERSION(); -- 현재 MySQL 버전
SELECT SLEEP(10); -- 해당 초 만큼 쿼리의 실행을 잠깐 멈춘다. 
SELECT '10초 후에 이게 보여요';

