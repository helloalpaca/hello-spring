-- step1
CREATE TABLE bigTbl1 (SELECT * FROM employees.employees);
CREATE TABLE bigTbl2 (SELECT * FROM employees.employees);
CREATE TABLE bigTbl3 (SELECT * FROM employees.employees);

-- step2
DELETE FROM bigTbl1; -- 1.281초, 행 삭제(트랜잭션 로그 남김)
DROP TABLE bigTbl2; -- 0.047초, 테이블 자체 삭제
TRUNCATE TABLE bigTbl3; -- 0.078초, 행 삭제(트랜잭션 로그 X)
-- 테이블 전체 내용을 삭제할 때, Table 자체가 필요 없다면 DROP, Table 구조는 남겨놓고 싶다면 TRUNCATE 사용 추천alter



