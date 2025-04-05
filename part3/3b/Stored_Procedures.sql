-- Making The Procedures
	-- Procedure 1: InsertGradeAndEvaluate
	-- Inserts a new grade row and updates Pass_Fail
		DELIMITER //

		CREATE PROCEDURE InsertGradeAndEvaluate(
			IN p_Student_ID INT,
			IN p_Past_Score INT,
			IN p_Final_Score INT,
			OUT p_Status VARCHAR(10)
		)
		BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION 
			BEGIN
				ROLLBACK;
				SET p_Status = 'FAILED';
			END;

			START TRANSACTION;

			-- Insert new grade row
			INSERT INTO grades(Student_ID, Past_Exam_Score, Final_Exam_Score, Pass_Fail)
			VALUES(p_Student_ID, p_Past_Score, p_Final_Score, NULL);

			-- Update Pass_Fail based on final score
			UPDATE grades
			SET Pass_Fail = CASE 
							  WHEN Final_Exam_Score >= 50 THEN 'Pass'
							  ELSE 'Fail'
							END
			WHERE Student_ID = p_Student_ID;

			COMMIT;
			SET p_Status = 'SUCCESS';
		END;
		//

	-- Procedure 2: DeleteStudentRecords
	-- Deletes student record and linked grade entry
		CREATE PROCEDURE DeleteStudentRecords(
			IN p_Student_ID INT,
			OUT p_Result VARCHAR(20)
		)
		BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION 
			BEGIN
				ROLLBACK;
				SET p_Result = 'ROLLBACK';
			END;

			START TRANSACTION;

			-- Delete grade row
			DELETE FROM grades
			WHERE Student_ID = p_Student_ID;

			-- Delete student performance row
			DELETE FROM student_performance
			WHERE Student_ID = p_Student_ID;

			COMMIT;
			SET p_Result = 'DELETED';
		END;
		//

		DELIMITER ;


-- Call Statements

	-- Declare variables for use with OUT parameters
	SET @status_out = '';
	SET @delete_result = '';

	-- Call InsertGradeAndEvaluate
	CALL InsertGradeAndEvaluate(201, 55, 73, @status_out);
	SELECT @status_out AS Insert_Status;

	-- Call DeleteStudentRecords
	CALL DeleteStudentRecords(201, @delete_result);
	SELECT @delete_result AS Deletion_Status;
