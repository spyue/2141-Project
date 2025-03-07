use studentsdb;

-- creating tables student_performance, locations, and extracurricular_activities
CREATE TABLE student_performance (
    Student_ID INT PRIMARY KEY,
    Gender VARCHAR(10),
    Study_Hours_per_Week INT,
    Attendance_Rate FLOAT,
    Past_Exam_Scores INT,
    Parental_Education_Level VARCHAR(50),
    Internet_Access_at_Home VARCHAR(3),
    Final_Exam_Score INT,
    Pass_Fail VARCHAR(10),
    City VARCHAR(50),
    Extracurricular_Activity VARCHAR(50)
);

CREATE TABLE locations (
    City VARCHAR(50) PRIMARY KEY,
    Country VARCHAR(50),
    Continent VARCHAR(50)
);

CREATE TABLE extracurricular_activities (
    Activity VARCHAR(50) PRIMARY KEY,
    Length_Months INT,
    Days_per_Week INT
);

-- loading data from csv files into the pre-created tables
LOAD DATA local INFILE 'C:/Users/jacks/Downloads/project-tables/Student_Performance_Dataset.csv' -- choose file
INTO TABLE student_performance -- select table to place the data
FIELDS TERMINATED BY ',' -- state each value is serperated by ',' hence csv 
ENCLOSED BY '"' -- makes strings become strings in the table 
LINES TERMINATED BY '\n' -- indicates the value that signifies a new line
IGNORE 1 ROWS; -- ignore the row of column names
-- the procedure is the same for all csv -> table operations so I will leave out comments for clarity

LOAD DATA local INFILE 'C:/Users/jacks/Downloads/project-tables/Expanded_locations_Table.csv'
INTO TABLE locations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA local INFILE 'C:/Users/jacks/Downloads/project-tables/Extracurricular_Activities_Table.csv'
INTO TABLE extracurricular_activities
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- check to ensure all tables were imported properly
select * from locations;
select * from extracurricular_activities;
select * from student_performance;

-- add foreign keys to student_performance 
alter table student_performance 
add foreign key (city) references locations(city);

alter table student_performance
add foreign key (Extracurricular_Activity) references extracurricular_activities(Activity);

-- simple queries 
SELECT 
    Student_ID,
    Gender,
    Study_Hours_per_Week,
    Attendance_Rate,
    Final_Exam_Score,
    (Final_Exam_Score / Study_Hours_per_Week) AS Performance_Ratio
FROM student_performance
WHERE Study_Hours_per_Week > 20
ORDER BY Performance_Ratio DESC;

SELECT 
    sp.Student_ID,
    sp.Gender,
    sp.City,
    l.Country,
    l.Continent,
    sp.Final_Exam_Score
FROM student_performance sp
INNER JOIN locations l ON sp.City = l.City
ORDER BY sp.Final_Exam_Score DESC;

SELECT 
    sp.City,
    COUNT(sp.Student_ID) AS Total_Students,
    AVG(sp.Final_Exam_Score) AS Avg_Final_Score
FROM student_performance sp
GROUP BY sp.City
ORDER BY Avg_Final_Score DESC;





