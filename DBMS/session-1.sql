Create Table
CREATE TABLE tbl_happiness (
    sno INT,
    rankings INT,
    country VARCHAR(50)
);

-- Insert Data
INSERT INTO tbl_happiness (sno, rankings, country) VALUES
(1, 1, 'Finland'),
(2, 2, 'Denmark'),
(3, 3, 'Iceland'),
(4, 4, 'Israel'),
(5, 5, 'Netherlands'),
(6, 6, 'Sweden'),
(7, 7, 'Norway'),
(8, 126, 'India'),
(9, 128, 'Sri Lanka');



Approach 1

-- (i)
(
SELECT  RANKINGS,COUNTRY FROM tbl_happiness 
WHERE COUNTRY IN ('Sri Lanka','India')
)
UNION ALL
(
SELECT RANKINGS,COUNTRY FROM tbl_happiness 
WHERE COUNTRY NOT IN ('Sri Lanka','India')
ORDER BY RANKINGS ASC
)

-- (II)

(
SELECT  RANKINGS,COUNTRY FROM tbl_happiness 
WHERE COUNTRY IN ('Sri Lanka','India')
)
UNION ALL 
(
SELECT RANKINGS,COUNTRY FROM tbl_happiness 
WHERE COUNTRY NOT IN ('Sri Lanka','India')
ORDER BY RANKINGS DESC
)



-- Approach 2
-- (i
SELECT RANKINGS,COUNTRY
FROM tbl_happiness 
ORDER BY CASE WHEN COUNTRY ='India' THEN 1 
      WHEN COUNTRY ='Sri Lanka' THEN 2
	  	ELSE 3
		  END ,rankings


-- (ii)


SELECT RANKINGS,COUNTRY
FROM tbl_happiness 
ORDER BY CASE WHEN COUNTRY ='India' THEN 1 
      WHEN COUNTRY ='Sri Lanka' THEN 2
	  	ELSE 3
		  END ,rankings desc 


 Ques 2
 -- Create Table
  CREATE TABLE employee (
      eid INT,
      dept VARCHAR(10),
      scores DECIMAL(5,2)
  );

  -- Insert Data	
  INSERT INTO employee (eid, dept, scores) VALUES
  (1, 'D1', 1),
  (2, 'D1', 5.28),
  (3, 'D1', 4),
  (4, 'D2', 8),
  (5, 'D1', 2.5),
  (6, 'D2', 7),
  (7, 'D3', 9),
  (8, 'D4', 10.2);
  

qUES 3

drop table books
-- Create Table
CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    BOOK_CODE VARCHAR(50)
);

-- Insert Data
INSERT INTO Books (BOOK_ID, BOOK_CODE) VALUES
(1, 'NOVEL-HARRY'),
(2, 'STORY-MOANA'),
(3, 'POEM-RIVER');



Solution-

-- Approach 1

SELECT SPLIT_PART(BOOK_CODE,'-',2) AS BOOK_TITLE
FROM BOOKS


-- Approach 2

SELECT SUBSTRING(BOOK_CODE,POSITION('-' IN BOOK_CODE)+1)
FROM BOOKS