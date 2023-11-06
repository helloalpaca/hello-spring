-- step1
CREATE TABLE memberTBL (SELECT userID, name, addr FROm usertbl LIMIT 3);
ALTER TABLE memberTBL
	ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID);
SELECT * FROM memberTBL;

-- step2
INSERT IGNORE INTO memberTBL VALUES('BBK', '비비코', '미국'); -- INSERT IGNORE은 PK 중복이더라도 오류를 발생시키지 않고 넘어간다.
INSERT IGNORE INTO memberTBL VALUES('SJH', '서장훈', '서울');
INSERT IGNORE INTO memberTBL VALUES('HJY', '현주엽', '경기');
SELECT * FROM memberTBL;

-- step3
INSERT INTO memberTBL VALUES('BBK', '비비코', '미국') ON DUPLICATE KEY UPDATE name='비비코', addr='미국'; -- BBK가 중복으로 있어서, UPDATE문 수행됨
INSERT INTO memberTBL VALUES('DJM', '동짜몽', '일본') ON DUPLICATE KEY UPDATE name='동짜몽', addr='일본'; -- DJM이 없으므로 일반 INSERT 수행
SELECT * FROM memberTBL;