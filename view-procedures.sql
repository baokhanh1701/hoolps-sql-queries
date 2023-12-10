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

-- Callers
call qualified_to_open_courses(2);
call students_take_most_courses(10);
call student_list_of_course('CS101');
call student_list_of_department('IT');

