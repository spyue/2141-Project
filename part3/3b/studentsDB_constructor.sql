-- Create Tables 

	-- Create Table For student_performance 
	DROP TABLE IF EXISTS student_performance;
	CREATE TABLE student_performance (
		Student_ID INT PRIMARY KEY,
		Gender VARCHAR(10),
		Study_Hours_per_Week INT,
		Attendance_Rate FLOAT,
		Parental_Education_Level VARCHAR(50),
		Internet_Access_at_Home VARCHAR(3),
		City VARCHAR(50),
		Extracurricular_Activity VARCHAR(50),
        FOREIGN KEY (City) REFERENCES locations(City)
	);

	-- Create Table For locations
	DROP TABLE IF EXISTS locations;
	CREATE TABLE locations (
		City VARCHAR(50) PRIMARY KEY,
		Country VARCHAR(50),
		Continent VARCHAR(50)
	);

	-- Create Table For extracurricular_activities
	DROP TABLE IF EXISTS extracurricular_activities;
	CREATE TABLE extracurricular_activities (
		Activity VARCHAR(50) PRIMARY KEY,
		Length_Months INT,
		Days_per_Week INT
	);

	-- Create Table For grades 
    DROP TABLE IF EXISTS grades;
	CREATE TABLE grades (
		Student_ID INT PRIMARY KEY,
		Past_Exam_Score INT,
		Final_Exam_Score INT,
		Pass_Fail VARCHAR(4),
        CHECK (Pass_Fail IN ('Pass', 'Fail'))
	);
    
-- Loading Data Into Tables 

	-- Loading Data Into student_performance 
    LOAD DATA local INFILE '~/student_performance.csv'
	INTO TABLE student_performance
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
    -- Loading Data Into locations  
    LOAD DATA local INFILE '~/locations.csv'
	INTO TABLE locations
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
    -- Loading Data Into extracurricular_activities 
    LOAD DATA local INFILE '~/extracurricular_activities.csv'
	INTO TABLE extracurricular_activities
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
    -- Loading Data Into grades 
    LOAD DATA local INFILE '~/grades.csv'
	INTO TABLE grades
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
