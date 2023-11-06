/* schema(database) 생성 명령어 */
CREATE SCHEMA `shopdb`;

/* table 생성 명령어 */
CREATE TABLE `shopdb`.`memberTBL` (
	`memberId` CHAR(8) NOT NULL,
    `memberName` CHAR(5) NOT NULL,
    `memberAddress` CHAR(20) NULL,
    PRIMARY KEY (`memberId`));

/* 조회 명령어 */
SELECT * FROM productTBL;
SELECT memberName, memberAddress FROM memberTBL;
SELECT * FROM memberTBL WHERE memberName='지운이';

/* table 삭제 명령어 */
DROP TABLE `테이블명`;

/* Index */
/* 이름만으로 어느 테이블의 어느 열에 설정된 인덱스인지를 알 수 있도록 지정하는게 좋다. */
CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name); 

/* View */
CREATE VIEW uv_memberTBL
	AS SELECT memberName, memberAddress FROM memberTBL;    
SELECT * FROM uv_memberTBL;

/* Stored Procedure */
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM memberTBL WHERE memberName='당탕이';
    SELECT * FROM productTBL WHERE productName='냉장고';
END //
DELIMITER ;

CALL myProc();

/* TRIGGER */
CREATE TABLE deletedMemberTBL(
	`memberId` CHAR(8),
    `memberName` CHAR(5),
    `memberAddress` CHAR(20),
    `deletedDate` DATE
);

DELIMITER //
CREATE TRIGGER trg_deletedMemberTBL
	AFTER DELETE
	ON memberTBL
    FOR EACH ROW
BEGIN
	-- OLD 테이블의 내용을 백업 테이블에 삽입
	INSERT INTO deletedMemberTBL VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE());
END //
DELIMITER ;

SELECT * FROM memberTBL;
DELETE FROM memberTBL WHERE memberName='당탕이'