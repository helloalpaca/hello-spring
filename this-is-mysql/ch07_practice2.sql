-- step 1
CREATE DATABASE moviedb;

USE moviedb;

CREATE TABLE movietbl(
	movie_id INT,
    movie_title VARCHAR(30),
    movie_director VARCHAR(20),
    movie_star VARCHAR(20),
    movie_script LONGTEXT,
    movie_film LONGBLOB
) DEFAULT CHARSET=utf8mb4;

-- step 2
INSERT INTO movietbl VALUES (1, '쉰들러 리스트', '스필버그', '리암 니슨',
	LOAD_FILE('/movies/Schindler.txt'), LOAD_FILE('/movies/Schindler.mp4')
);

SELECT * FROM movietbl; -- 영화 대본과 영화 동영상이 NULL 값으로 표시됨

-- step 3
SHOW variables LIKE 'max_allowed_packet';
SHOW variables LIKE 'secure_file_priv';


-- step 4 재시작

-- step 5 
-- max_allowed_packet, secure_file_priv를 수정하고 아래 명령어 실행하면 LONGTEXT, BLOB 들어간다.
USE moviedb;
TRUNCATE movietbl;

INSERT INTO movietbl VALUES (1, '쉰들러 리스트', '스필버그', '리암 니슨',
	LOAD_FILE('/movies/Schindler.txt'), LOAD_FILE('/movies/Schindler.mp4')
);

INSERT INTO movietbl VALUES (2, '쇼생크 탈출', '프랭크 다라본트', '팀 로빈스',
	LOAD_FILE('/movies/Shawshank.txt'), LOAD_FILE('/movies/Shawshank.mp4')
);

INSERT INTO movietbl VALUES (3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
	LOAD_FILE('/movies/Mohican.txt'), LOAD_FILE('/movies/Mohican.mp4')
);

SELECT * FROM movietbl;

-- step 6
-- 입력된 데이터 내려받기
SELECT movie_script FROM movietbl WHERE movie_id=1
	INTO OUTFILE '/movies/Schindler_out.txt'
		LINES TERMINATED BY '\\n'; -- OUTFILE 위치는 secure_file_priv 위치여야함

SELECT movie_film FROM movietbl WHERE movie_id=3
	INTO DUMPFILE '/movies/Mohican_out.mp4';