-- Student take most courses
		
CREATE OR REPLACE PROCEDURE students_take_most_courses(top_number int) AS $$
declare
	ret record;
begin
		select user_information.user_id,
				user_information.first_name,
				user_information.user_name,
		count(*) as taken_course from user_information, student_takes_course where user_information.user_id = student_takes_course.student_id
		group by user_information.user_id, user_information.first_name order by count(*)
		desc
		limit top_number
		into ret;
	return;
end;$$ LANGUAGE PLPGSQL;

-- Courses that are qualified to open
CREATE OR REPLACE PROCEDURE qualified_to_open_courses (registered_students int) AS $$
declare
	ret record;
begin
	select c.course_id, c.course_name, c.course_description from course c, student_takes_course stc
	where c.course_id = stc.course_id
	group by stc.course_id, c.course_id
	having count(*) >= registered_students
	into ret;
return;
end;$$ LANGUAGE PLPGSQL;

-- Student lists of a course
CREATE OR REPLACE PROCEDURE student_list_of_course (course_id_input varchar(255)) AS $$
declare
	ret record;
begin
	select res.* from (SELECT
	       user_info.*,
	       d.department_name
	FROM student uni_student,
	     user_information user_info,
	     department d
	WHERE uni_student.user_id = user_info.user_id
	  AND uni_student.department_id = d.department_id
	ORDER BY uni_student.user_id asc) res
	join student_takes_course stc on stc.student_id = res.user_id join course c on stc.course_id = c.course_id
	where c.course_id = course_id_input
	into ret;
return;
end;$$ LANGUAGE PLPGSQL;

-- Student list of a department
CREATE OR REPLACE PROCEDURE student_list_of_department (department_id_input varchar(255)) AS $$
declare
	ret record;
begin
	select res.* from (SELECT
	       user_info.*,
	       d.department_name,
	       d.department_id
	FROM student uni_student,
	     user_information user_info,
	     department d
	WHERE uni_student.user_id = user_info.user_id
	  AND uni_student.department_id = d.department_id
	ORDER BY uni_student.user_id asc) res where res.department_id = department_id_input
	into ret;
return;
end;$$ LANGUAGE PLPGSQL;

-- INSERTION  PROCEDURES
-- Add department
CREATE OR REPLACE PROCEDURE add_department (
	department_id_ varchar(255),
	email_ varchar(255),
	address_ varchar(255),
	description_ varchar(255),
	department_name_ varchar(255)
) as $$
declare 
	ret record;
begin 
	if exists (SELECT * FROM department WHERE department.department_id = department_id_)
		then RAISE EXCEPTION 'duplicated ID --> %', department_id_;
		return;
	end if;
	if (department_id_ is null or department_id_ = '' or department_name_ is null or department_name_ = '')
		then raise exception 'Invalid parameters: %, %', department_id_, department_name_;
		return;
	end if;
	INSERT INTO department VALUES (department_id_, email_, address_, description_, department_name_);
	return;
end;$$ LANGUAGE PLPGSQL;

-- Add tickets
CREATE OR REPLACE PROCEDURE add_ticket (
	ticket_id_ varchar(255),
	ticket_type_ varchar(255),
	created_at_ varchar(255),
	process_at_ varchar(255),
	description_ varchar(255),
	status_ varchar(255),
	user_id_ varchar(255),
	admin_id_ varchar(255)
) as $$
declare 
	ret record;
begin 
	if exists (SELECT * FROM ticket WHERE ticket.ticket_id = ticket_id_)
		then RAISE EXCEPTION 'duplicated ID --> %', ticket_id_;
		return;
	end if;
	if (ticket_id_ is null or ticket_id_ = '' or ticket_type_ is null or ticket_type_ = '')
		then raise exception 'Invalid parameters';
		return;
	end if;
	INSERT INTO department VALUES (ticket_id_, ticket_type_, created_at_, process_at_, description_, status_, user_id_, admin_id_);
	return;
end;$$ LANGUAGE PLPGSQL;

-- Add users
CREATE OR REPLACE PROCEDURE add_user_information (
    user_id_ varchar(255),
    user_name_ varchar(255),
    user_password_ varchar(255),
    email_ varchar(255),
    address_ varchar(255),
    first_name_ varchar(255),
    last_name_ varchar(255),
    birthday_ varchar(255),
    sex_ varchar(255),
    description_ varchar(255),
    country_ varchar(255),
    account_type_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM user_information WHERE user_information.user_id = user_id_)
        then RAISE EXCEPTION 'Duplicate user ID --> %', user_id_;
        return;
    end if;
    if (user_id_ is null or user_id_ = '' or user_name_ is null or user_name_ = '' or user_password_ is null or user_password_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO user_information VALUES (user_id_, user_name_, user_password_, email_, address_, first_name_, last_name_, birthday_, sex_, description_, country_, account_type_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add students
CREATE OR REPLACE PROCEDURE add_student (
    user_id_ varchar(255),
    department_id_ varchar(255),
    student_status_ varchar(255),
    student_class_ varchar(255),
    student_degree_ varchar(255),
    student_program_ varchar(255),
    student_major_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM student WHERE student.user_id = user_id_)
        then RAISE EXCEPTION 'Duplicate user ID for student --> %', user_id_;
        return;
    end if;
    if (user_id_ is null or user_id_ = '' or department_id_ is null or department_id_ = '' or student_status_ is null or student_status_ = '' or student_program_ is null or student_program_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO student VALUES (user_id_, department_id_, student_status_, student_class_, student_degree_, student_program_, student_major_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add administrators
CREATE OR REPLACE PROCEDURE add_administrator (
    user_id_ varchar(255),
    department_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM administrator WHERE administrator.user_id = user_id_)
        then RAISE EXCEPTION 'Duplicate user ID for administrator --> %', user_id_;
        return;
    end if;
    if (user_id_ is null or user_id_ = '' or department_id_ is null or department_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO administrator VALUES (user_id_, department_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add lecturer
CREATE OR REPLACE PROCEDURE add_lecturer (
    user_id_ varchar(255),
    department_id_ varchar(255),
    lecturer_degree_ varchar(255),
    lecturer_specialty_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM lecturer WHERE lecturer.user_id = user_id_)
        then RAISE EXCEPTION 'Duplicate user ID for lecturer --> %', user_id_;
        return;
    end if;
    if (user_id_ is null or user_id_ = '' or department_id_ is null or department_id_ = '' or lecturer_degree_ is null or lecturer_degree_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO lecturer VALUES (user_id_, department_id_, lecturer_degree_, lecturer_specialty_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add questions
CREATE OR REPLACE PROCEDURE add_question (
    question_id_ varchar(255),
    question_content_ varchar(255),
    created_at_ varchar(255),
    answer_date_ varchar(255),
    course_id_ varchar(255),
    student_id_ varchar(255),
    lecturer_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM question WHERE question.question_id = question_id_)
        then RAISE EXCEPTION 'Duplicate question ID --> %', question_id_;
        return;
    end if;
    if (question_id_ is null or question_id_ = '' or question_content_ is null or question_content_ = '' or course_id_ is null or course_id_ = '' or student_id_ is null or student_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO question VALUES (question_id_, question_content_, created_at_, answer_date_, course_id_, student_id_, lecturer_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add answer
CREATE OR REPLACE PROCEDURE add_answer (
    answer_id_ varchar(255),
    answer_date_ varchar(255),
    answer_content_ varchar(255),
    question_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM answer WHERE answer.answer_id = answer_id_)
        then RAISE EXCEPTION 'Duplicate answer ID --> %', answer_id_;
        return;
    end if;
    if (answer_id_ is null or answer_id_ = '' or answer_date_ is null or answer_date_ = '' or question_id_ is null or question_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO answer VALUES (answer_id_, answer_date_, answer_content_, question_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add add_admin_manages_department 
CREATE OR REPLACE PROCEDURE add_admin_manages_department (
    admin_id_ varchar(255),
    department_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM admin_manages_department WHERE admin_manages_department.admin_id = admin_id_ AND admin_manages_department.department_id = department_id_)
        then RAISE EXCEPTION 'Admin % already manages department %', admin_id_, department_id_;
        return;
    end if;
    if (admin_id_ is null or admin_id_ = '' or department_id_ is null or department_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO admin_manages_department VALUES (admin_id_, department_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add courses
CREATE OR REPLACE PROCEDURE add_course (
    course_id_ varchar(255),
    course_name_ varchar(255),
    course_description_ varchar(255),
    lecturer_id_ varchar(255),
    modified_at_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM course WHERE course.course_id = course_id_)
        then RAISE EXCEPTION 'Duplicate course ID --> %', course_id_;
        return;
    end if;
    if (course_id_ is null or course_id_ = '' or course_name_ is null or course_name_ = '' or lecturer_id_ is null or lecturer_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO course VALUES (course_id_, course_name_, course_description_, lecturer_id_, modified_at_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add admin_manages_course 
CREATE OR REPLACE PROCEDURE add_admin_manages_course (
    admin_id_ varchar(255),
    course_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM admin_manages_course WHERE admin_manages_course.admin_id = admin_id_ AND admin_manages_course.course_id = course_id_)
        then RAISE EXCEPTION 'Admin % already manages course %', admin_id_, course_id_;
        return;
    end if;
    if (admin_id_ is null or admin_id_ = '' or course_id_ is null or course_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO admin_manages_course VALUES (admin_id_, course_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add student takes course
CREATE OR REPLACE PROCEDURE add_student_takes_course (
    student_id_ varchar(255),
    course_id_ varchar(255),
    date_of_enrollment_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM student_takes_course WHERE student_takes_course.student_id = student_id_ AND student_takes_course.course_id = course_id_)
        then RAISE EXCEPTION 'Student % already takes course %', student_id_, course_id_;
        return;
    end if;
    if (student_id_ is null or student_id_ = '' or course_id_ is null or course_id_ = '' or date_of_enrollment_ is null or date_of_enrollment_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO student_takes_course VALUES (student_id_, course_id_, date_of_enrollment_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add lecture
CREATE OR REPLACE PROCEDURE add_lecture (
    lecture_id_ varchar(255),
    course_id_ varchar(255),
    lecture_name_ varchar(255),
    lecture_content_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM lecture WHERE lecture.lecture_id = lecture_id_)
        then RAISE EXCEPTION 'Duplicate lecture ID --> %', lecture_id_;
        return;
    end if;
    if (lecture_id_ is null or lecture_id_ = '' or course_id_ is null or course_id_ = '' or lecture_name_ is null or lecture_name_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO lecture VALUES (lecture_id_, course_id_, lecture_name_, lecture_content_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add lecture document
CREATE OR REPLACE PROCEDURE add_lecture_document (
    document_id_ varchar(255),
    lecture_id_ varchar(255),
    course_id_ varchar(255),
    author_ varchar(255),
    title_ varchar(255),
    subject_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM lecture_document WHERE lecture_document.document_id = document_id_)
        then RAISE EXCEPTION 'Duplicate document ID --> %', document_id_;
        return;
    end if;
    if (document_id_ is null or document_id_ = '' or lecture_id_ is null or lecture_id_ = '' or course_id_ is null or course_id_ = '' or author_ is null or author_ = '' or title_ is null or title_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO lecture_document VALUES (document_id_, lecture_id_, course_id_, author_, title_, subject_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add attempt
CREATE OR REPLACE PROCEDURE add_attempt (
    quiz_id_ varchar(255),
    lecture_id_ varchar(255),
    course_id_ varchar(255),
    student_id_ varchar(255),
    attempt_detail_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM attempt WHERE attempt.attempt_detail_id = attempt_detail_id_)
        then RAISE EXCEPTION 'Duplicate attempt detail ID --> %', attempt_detail_id_;
        return;
    end if;
    if (quiz_id_ is null or quiz_id_ = '' or lecture_id_ is null or lecture_id_ = '' or course_id_ is null or course_id_ = '' or student_id_ is null or student_id_ = '' or attempt_detail_id_ is null or attempt_detail_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO attempt VALUES (quiz_id_, lecture_id_, course_id_, student_id_, attempt_detail_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add attempt detail
CREATE OR REPLACE PROCEDURE add_attempt_detail (
    attempt_detail_id_ varchar(255),
    created_at_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM attempt_detail WHERE attempt_detail.attempt_detail_id = attempt_detail_id_)
        then RAISE EXCEPTION 'Duplicate attempt detail ID --> %', attempt_detail_id_;
        return;
    end if;
    if (attempt_detail_id_ is null or attempt_detail_id_ = '' or created_at_ is null or created_at_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO attempt_detail VALUES (attempt_detail_id_, created_at_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add attempt answer
CREATE OR REPLACE PROCEDURE add_attempt_answer (
    attempt_answer_id_ varchar(255),
    answer_content_ varchar(255),
    attempt_detail_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM attempt_answer WHERE attempt_answer.attempt_answer_id = attempt_answer_id_)
        then RAISE EXCEPTION 'Duplicate attempt answer ID --> %', attempt_answer_id_;
        return;
    end if;
    if (attempt_answer_id_ is null or attempt_answer_id_ = '' or answer_content_ is null or answer_content_ = '' or attempt_detail_id_ is null or attempt_detail_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO attempt_answer VALUES (attempt_answer_id_, answer_content_, attempt_detail_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add quiz
CREATE OR REPLACE PROCEDURE add_quiz (
    quiz_id_ varchar(255),
    lecture_id_ varchar(255),
    course_id_ varchar(255),
    description_ varchar(255),
    title_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM quiz WHERE quiz.quiz_id = quiz_id_)
        then RAISE EXCEPTION 'Duplicate quiz ID --> %', quiz_id_;
        return;
    end if;
    if (quiz_id_ is null or quiz_id_ = '' or lecture_id_ is null or lecture_id_ = '' or course_id_ is null or course_id_ = '' or description_ is null or description_ = '' or title_ is null or title_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO quiz VALUES (quiz_id_, lecture_id_, course_id_, description_, title_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add quiz question
CREATE OR REPLACE PROCEDURE add_quiz_question (
    quiz_question_id_ varchar(255),
    title_ varchar(255),
    description_ varchar(255),
    max_point_ varchar(255),
    quiz_question_type_ varchar(255),
    attempt_detail_id_ varchar(255),
    quiz_id_ varchar(255),
    lecture_id_ varchar(255),
    course_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM quiz_question WHERE quiz_question.quiz_question_id = quiz_question_id_)
        then RAISE EXCEPTION 'Duplicate quiz question ID --> %', quiz_question_id_;
        return;
    end if;
    if (quiz_question_id_ is null or quiz_question_id_ = '' or title_ is null or title_ = '' or max_point_ is null or max_point_ = '' or quiz_question_type_ is null or quiz_question_type_ = '' or attempt_detail_id_ is null or attempt_detail_id_ = '' or quiz_id_ is null or quiz_id_ = '' or lecture_id_ is null or lecture_id_ = '' or course_id_ is null or course_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO quiz_question VALUES (quiz_question_id_, title_, description_, max_point_, quiz_question_type_, attempt_detail_id_, quiz_id_, lecture_id_, course_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- add short answer
CREATE OR REPLACE PROCEDURE add_short_answer (
    quiz_question_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM short_answer WHERE short_answer.quiz_question_id = quiz_question_id_)
        then RAISE EXCEPTION 'Duplicate short answer ID --> %', quiz_question_id_;
        return;
    end if;
    if (quiz_question_id_ is null or quiz_question_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO short_answer VALUES (quiz_question_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- Table: correct_answer
CREATE OR REPLACE PROCEDURE add_correct_answer (
    correct_answer_ varchar(255),
    quiz_question_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM correct_answer WHERE correct_answer.correct_answer = correct_answer_ AND correct_answer.quiz_question_id = quiz_question_id_)
        then RAISE EXCEPTION 'Duplicate correct answer for quiz question %', quiz_question_id_;
        return;
    end if;
    if (correct_answer_ is null or correct_answer_ = '' or quiz_question_id_ is null or quiz_question_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO correct_answer VALUES (correct_answer_, quiz_question_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- Table: multiple_choice
CREATE OR REPLACE PROCEDURE add_multiple_choice (
    quiz_question_id_ varchar(255)
) as $$
begin
    if exists (SELECT * FROM multiple_choice WHERE multiple_choice.quiz_question_id = quiz_question_id_)
        then RAISE EXCEPTION 'Duplicate entry for multiple choice quiz question %', quiz_question_id_;
        return;
    end if;
    if (quiz_question_id_ is null or quiz_question_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO multiple_choice VALUES (quiz_question_id_);
    return;
end;$$ LANGUAGE PLPGSQL;

-- Table: multiple_choice_answer
CREATE OR REPLACE PROCEDURE add_multiple_choice_answer (
    multiple_choice_answer_ varchar(255),
    quiz_question_id_ varchar(255),
    is_correct_ boolean
) as $$
begin
    if exists (SELECT * FROM multiple_choice_answer WHERE multiple_choice_answer.multiple_choice_answer = multiple_choice_answer_ AND multiple_choice_answer.quiz_question_id = quiz_question_id_)
        then RAISE EXCEPTION 'Duplicate multiple choice answer for quiz question %', quiz_question_id_;
        return;
    end if;
    if (multiple_choice_answer_ is null or multiple_choice_answer_ = '' or quiz_question_id_ is null or quiz_question_id_ = '')
        then raise exception 'Invalid parameters';
        return;
    end if;
    INSERT INTO multiple_choice_answer VALUES (multiple_choice_answer_, quiz_question_id_, is_correct_);
    return;
end;$$ LANGUAGE PLPGSQL;



-- Callers
call qualified_to_open_courses(2);
call students_take_most_courses(10);
call student_list_of_course('CS101');
call student_list_of_department('IT');
call add_department('CompEngineering', 'comp_engineering@gmail.com', '80 To Hien Thanh', 'Computer Engineering Department of HCMUT', 'Computer Engineering')


