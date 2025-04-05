-- Five Queries 

	-- Query One: Show students who study more than 30 hours per week and calculate their estimated weekly study time in minutes.
	SELECT 
    Student_ID,
    Study_Hours_per_Week,
    Study_Hours_per_Week * 60 AS Study_Minutes_per_Week
	FROM 
    student_performance
	WHERE 
	Study_Hours_per_Week > 30 
    order by Study_Hours_per_Week desc;
    
    -- Query Two: Get student final scores and their attendance rate.
    SELECT 
    sp.Student_ID,
    sp.Attendance_Rate,
    g.Final_Exam_Score
	FROM 
    student_performance sp
	INNER JOIN grades g ON sp.Student_ID = g.Student_ID;

	-- Query Three: Average final exam score by parental education level.
    SELECT 
    Parental_Education_Level,
    AVG(g.Final_Exam_Score) AS Avg_Final_Score
	FROM 
    student_performance sp
	JOIN grades g ON sp.Student_ID = g.Student_ID
	GROUP BY 
    Parental_Education_Level;
    
    -- Query Four: Show average past exam score for students with internet access at home.
    SELECT 
    Internet_Access_at_Home,
    AVG(Past_Exam_Score) AS Avg_Past_Score
	FROM (
		SELECT 
			sp.Student_ID,
			sp.Internet_Access_at_Home,
			g.Past_Exam_Score
		FROM 
			student_performance sp
		JOIN grades g ON sp.Student_ID = g.Student_ID
	) AS sub
	GROUP BY 
    Internet_Access_at_Home;

	-- Query Five
    CREATE VIEW StudentExamStats AS
	SELECT 
    sp.Student_ID,
    sp.Gender,
    g.Final_Exam_Score,
    g.Past_Exam_Score,
    (g.Final_Exam_Score - g.Past_Exam_Score) AS Score_Improvement
	FROM 
    student_performance sp
	JOIN grades g ON sp.Student_ID = g.Student_ID;
	-- Run The First Select
    SELECT * FROM StudentExamStats WHERE Score_Improvement > 8;
	-- Modify An Underlying Table
    UPDATE grades
	SET Final_Exam_Score = Final_Exam_Score + 10
	WHERE Student_ID = 11;  -- example ID
    -- Rerun Select
    SELECT * FROM StudentExamStats WHERE Score_Improvement > 8;

    




