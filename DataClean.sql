USE `hr_data_cleaning`;
SELECT * FROM hr_dirty;

DROP TABLE data_cleaning;
CREATE TABLE data_cleaning AS
SELECT * FROM hr_dirty;
SELECT *
FROM data_cleaning;

-- check row count
SELECT COUNT(*)
FROM data_cleaning;

-- Check duplicated base on specific columns
SELECT Employee_Name, Department, Position, COUNT(*) AS Duplicates
FROM data_cleaning
GROUP BY Employee_Name, Department, Position
HAVING COUNT(*) > 1;

-- Check duplicates through the entire row
SELECT *, COUNT(*) AS duplicates
FROM data_cleaning
GROUP BY Employee_ID, Employee_Name, Department, Position, Hire_Date, Salary, Employment_Status, Manager_Name, City, Performance_Rating
HAVING COUNT(*) > 1;

-- See full row data for duplicates
WITH duplicate_checker AS (
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY Employee_Name, Department, Position, Hire_Date
            ORDER BY Employee_Name
        ) AS row_num
        FROM data_cleaning
)
SELECT *
FROM duplicate_checker
WHERE row_num > 1;

UPDATE data_cleaning
SET Employee_ID = UPPER(Employee_ID)
WHERE Employee_ID LIKE 'emp-%';

SELECT *
FROM data_cleaning;

-- check distinct values
SELECT DISTINCT Employee_ID
FROM data_cleaning
ORDER BY 1;

-- check missing values
SELECT *
FROM data_cleaning
WHERE Employee_Name IS NULL
	OR Employee_Name = ''
ORDER BY 1;

-- Remove leading and trailing spaces
SELECT *
FROM data_cleaning
ORDER BY 1;

UPDATE data_cleaning 
SET 
    Employee_ID = TRIM(Employee_ID),
    Employee_Name = TRIM(Employee_Name),
    Department = TRIM(Department),
    Position = TRIM(Position),
    Hire_Date = TRIM(Hire_Date),
    Salary = TRIM(Salary),
    Employment_Status = TRIM(Employment_Status),
    Manager_Name = TRIM(Manager_Name),
    City = TRIM(City),
    Performance_Rating = TRIM(Performance_Rating)
WHERE 
    Employee_ID LIKE ' %' OR Employee_ID LIKE '% ' OR
    Employee_Name LIKE ' %' OR Employee_Name LIKE '% ' OR
    Department LIKE ' %' OR Department LIKE '% ' OR
    Position LIKE ' %' OR Position LIKE '% ' OR
    Hire_Date LIKE ' %' OR Hire_Date LIKE '% ' OR
    Salary LIKE ' %' OR Salary LIKE '% ' OR
    Employment_Status LIKE ' %' OR Employment_Status LIKE '% ' OR
    Manager_Name LIKE ' %' OR Manager_Name LIKE '% ' OR
    City LIKE ' %' OR City LIKE '% ' OR
    Performance_Rating LIKE ' %' OR Performance_Rating LIKE '% ';
    
-- count how many rows still have spaces
SELECT *
FROM data_cleaning
WHERE Employee_Name != TRIM(Employee_Name)
	OR Department != TRIM(Department)
    OR Position != TRIM(Position);
    


SELECT *
FROM data_cleaning
WHERE Department != TRIM(Department);

UPDATE data_cleaning
SET Employee_Name = CASE
	WHEN LOWER(TRIM(Employee_Name)) = 'ALICE REYES' THEN 'Alice Reyes'
    ELSE Employee_Name
END
WHERE LOWER(TRIM(Employee_Name)) IN ('ALICE REYES');

SELECT Department
FROM data_cleaning
WHERE Department = 'HR'
ORDER BY 1;

UPDATE data_cleaning
SET Department = CASE
	WHEN UPPER(TRIM(Department)) = 'it' THEN 'IT'
    ELSE Department
END
WHERE UPPER(TRIM(Department)) = ('it');

-- SELECT Employee_Name, COUNT(*) 
-- FROM data_cleaning
-- WHERE Employee_Name IS NULL 
--    OR LOWER(TRIM(Employee_Name)) IN ('n/a', 'null', 'na', '')
-- GROUP BY Employee_Name;

SELECT *
FROM data_cleaning;

UPDATE data_cleaning
SET Employee_Name = NULL
WHERE LOWER(TRIM(Employee_Name)) IN ('Null', '');

-- In User Reports
SELECT 
    Employee_ID,
    COALESCE(Employee_Name, 'Unknown') AS Employee_Name
FROM data_cleaning;


UPDATE data_cleaning
SET 
	Department = NULL,
    Position = NULL,
    Hire_Date = NULL,
    Salary = NULL,
    Employment_Status = NULL,
    Manager_Name = NULL,
    City = NULL,
    Performance_Rating = NULL
WHERE 
	LOWER(TRIM(Department)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Position)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Hire_Date)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Salary)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Employment_Status)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Manager_Name)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(City)) IN ('Null', 'N/A', '')
    AND LOWER(TRIM(Performance_Rating)) IN ('Null', 'N/A', '');
    
UPDATE data_cleaning
SET 
    Department = CASE
		WHEN LOWER(TRIM(Department)) IN ('null', 'n/a', '') THEN NULL 
        ELSE Department 
END,
    Position = CASE 
		WHEN LOWER(TRIM(Position)) IN ('null', 'n/a', '') THEN NULL 
        ELSE Position 
	END,
    Hire_Date = CASE 
		WHEN LOWER(TRIM(Hire_Date)) IN ('null', 'n/a', '') THEN NULL 
        ELSE Hire_Date 
END,
    Salary = CASE
		WHEN LOWER(TRIM(Salary)) IN ('null', 'n/a', '') THEN NULL 
		ELSE Salary 
END,
    Employment_Status = CASE
		WHEN LOWER(TRIM(Employment_Status)) IN ('null', 'n/a', '') THEN NULL 
        ELSE Employment_Status 
END,
    Manager_Name = CASE WHEN LOWER(TRIM(Manager_Name)) IN ('null', 'n/a', '') THEN NULL 
    ELSE Manager_Name 
END,
    City = CASE WHEN LOWER(TRIM(City)) IN ('null', 'n/a', '') THEN NULL 
    ELSE City 
END,
    Performance_Rating = CASE WHEN LOWER(TRIM(Performance_Rating)) IN ('null', 'n/a', '') THEN NULL 
    ELSE Performance_Rating 
END;

SELECT Position 
FROM data_cleaning
GROUP BY Position
ORDER BY 1;

UPDATE data_cleaning
SET Position = CASE
	WHEN UPPER(TRIM(Position)) = 'analyst' THEN 'Analyst'
    ELSE Position
END
WHERE UPPER(TRIM(Position)) = ('analyst');

SELECT *
FROM data_cleaning;


-- Fix the 'DD-MM-YYYY' format (e.g., 24-02-2025)
UPDATE data_cleaning
SET Hire_Date = DATE_FORMAT(STR_TO_DATE(Hire_Date, '%d-%m-%Y'), '%Y-%m-%d')
WHERE Hire_Date LIKE '__-__-____';

UPDATE data_cleaning
SET Hire_Date = DATE_FORMAT(STR_TO_DATE(Hire_Date, '%d/%m/%Y'), '%Y/%m/%d')
WHERE Hire_Date LIKE '__-__-____';

UPDATE data_cleaning
SET Hire_Date = DATE_FORMAT(STR_TO_DATE(Hire_Date, '%m-%d-%Y'), '%Y-%m-%d')
WHERE Hire_Date LIKE '__-__-____';
    
-- Fix the 'YYYY-MM-DD' format 
UPDATE data_cleaning
SET Hire_Date = DATE_FORMAT(STR_TO_DATE(Hire_Date, '%Y-%m-%d'), '%Y-%m-%d')
WHERE Hire_Date LIKE '____-__-__';

SELECT Employment_Status
FROM data_cleaning
ORDER BY 1;

UPDATE data_cleaning
SET Salary =
	REPLACE(REPLACE(Salary, '$', ''), ',', '')
WHERE Salary LIKE '%$%';

ALTER TABLE data_cleaning
MODIFY COLUMN Hire_Date Date;

ALTER TABLE data_cleaning
MODIFY COLUMN Salary Decimal(10, 2);


UPDATE data_cleaning
SET Hire_Date = CASE 
    -- 1. Matches YYYY-MM-DD (Already correct format, keep it)
    WHEN Hire_Date LIKE '____-__-__' THEN Hire_Date
    
    -- 2. Matches MM/DD/YYYY (e.g., '06/08/2021')
    WHEN Hire_Date LIKE '__/__/____' THEN DATE_FORMAT(STR_TO_DATE(Hire_Date, '%m/%d/%Y'), '%Y-%m-%d')
    
    -- 3. Matches DD-MM-YYYY (e.g., '25-12-2021')
    WHEN Hire_Date LIKE '__-__-____' THEN DATE_FORMAT(STR_TO_DATE(Hire_Date, '%d-%m-%Y'), '%Y-%m-%d')
    
    -- 4. Handles anything you already cleaned out to 'Null', 'N/A' or blank
    WHEN LOWER(TRIM(Hire_Date)) IN ('null', 'n/a', '') THEN NULL
    
    ELSE NULL -- Safely sets unrecognized corrupt layouts to NULL instead of breaking
END;

ALTER TABLE data_cleaning
MODIFY COLUMN Hire_Date Date;

SELECT *
FROM data_cleaning;

UPDATE data_cleaning
SET Employment_Status = CASE
	WHEN UPPER(TRIM(Employment_Status)) = 'active' THEN 'Active'
    ELSE Employment_Status
END
WHERE UPPER(TRIM(Employment_Status)) = ('active');

UPDATE data_cleaning
SET City = CASE
	WHEN UPPER(TRIM(City)) = 'manila' THEN 'Manila'
    ELSE City
END
WHERE UPPER(TRIM(City)) = ('manila');

SELECT 
    Employee_Name, 
    COUNT(*) as duplicate_count
FROM data_cleaning
GROUP BY Employee_Name
HAVING COUNT(*) > 1;

SELECT 
    Employee_Name, 
    Department, 
    Hire_Date, 
    COUNT(*) as duplicate_count
FROM data_cleaning
GROUP BY Employee_Name, Department, Hire_Date
HAVING COUNT(*) > 1;

SELECT 
    Employee_Name, 
    Department, 
    COUNT(*) as duplicate_count
FROM data_cleaning
GROUP BY Employee_Name, Department
HAVING COUNT(*) > 1;


WITH CTE_Duplicates AS (
    SELECT 
        Employee_ID,
        ROW_NUMBER() OVER (
            PARTITION BY Employee_Name, Department 
            ORDER BY Employee_ID
        ) AS row_num
    FROM data_cleaning
)
DELETE d FROM data_cleaning d
INNER JOIN CTE_Duplicates c 
    ON d.Employee_ID = c.Employee_ID
WHERE c.row_num > 1;


WITH CTE_Check AS (
    SELECT 
        Employee_ID,
        Employee_Name,
        Department,
        Position,
        Salary,
        ROW_NUMBER() OVER (
            PARTITION BY Employee_Name, Department 
            ORDER BY Employee_ID
        ) AS row_num
    FROM data_cleaning
)
SELECT * 
FROM CTE_Check 
WHERE row_num > 1
ORDER BY Employee_Name, Department;

SELECT 
    Employee_Name, 
    Department, 
    Hire_Date, 
    COUNT(*) as duplicate_count
FROM data_cleaning
GROUP BY Employee_Name, Department, Hire_Date
HAVING COUNT(*) > 1;

SELECT *
FROM data_cleaning;








