-- STUDENT SERVICES

-- Get Tickets Information
SELECT t.*,
       user_info.user_name AS admin_handler
FROM
  (SELECT tic.*,
          user_info.user_name AS author
   FROM ticket tic
   JOIN user_information user_info ON tic.user_id = user_info.user_id) t
JOIN user_information user_info ON t.admin_id = user_info.user_id

-- Get Courses
SELECT c.*,
       CASE
           WHEN EXISTS
                  (SELECT 1
                   FROM student_takes_course st) THEN TRUE
           ELSE FALSE
       END AS registered
FROM course c
    
-- Get Lectures
SELECT * FROM lecture

-- Get Questions
SELECT *
FROM
  (SELECT f.*,
          user_info.user_name AS lecturer_name
   FROM
     (SELECT forum.*,
             user_info.user_name AS student_name
      FROM
        (SELECT q.*,
                ans.answer_id,
                ans.answer_content,
                ans.answer_date
         FROM answer ans
         INNER JOIN question q ON q.question_id = ans.question_id) forum,
           user_information user_info
      WHERE forum.student_id = user_info.user_id) f,
        user_information user_info
   WHERE f.lecturer_id = user_info.user_id) q

-- Get Document List
SELECT * FROM lecture_document lec_doc

-- Get Quiz List
SELECT t.quiz_id,
       t.title,
       t.description,
       COUNT(qq.quiz_question_id) AS num_of_questions
FROM
  (SELECT q.quiz_id,
          q.title,
          q.description
   FROM quiz q
   WHERE q.lecture_id = '${lectureID}') t
LEFT JOIN quiz_question AS qq ON t.quiz_id = qq.quiz_id
GROUP BY t.quiz_id,
         t.title,
         t.description

-- Get Quiz Question List
SELECT *
FROM
  (SELECT t.*,
          mca.multiple_choice_answer,
          mca.is_correct
   FROM
     (SELECT qq.quiz_id,
             qq.quiz_question_id,
             qq.title,
             qq.description,
             qq.max_point,
             qq.quiz_question_type,
             sa.correct_answer AS short_answer
      FROM quiz_question qq
      FULL JOIN correct_answer sa ON sa.quiz_question_id = qq.quiz_question_id) t
   FULL JOIN multiple_choice_answer mca ON mca.quiz_question_id = t.quiz_question_id) t
order by quiz_id

-- Get Attempt Detail
SELECT *
FROM
  (SELECT t.*,
          user_info.user_name
   FROM
     (SELECT *
      FROM
        (SELECT t.*,
                ad.created_at
         FROM
           (SELECT a.attempt_detail_id,
                   a.student_id,
                   a.quiz_id,
                   at.attempt_answer_id,
                   at.answer_content
            FROM attempt a
            FULL JOIN attempt_answer AT ON a.attempt_detail_id = at.attempt_detail_id) t
         FULL JOIN attempt_detail ad ON ad.attempt_detail_id = t.attempt_detail_id) t
      WHERE t.quiz_id = '${quizID}') t
   JOIN user_information user_info ON t.student_id = user_info.user_id) t
WHERE t.student_id = '${studentID}'


-- LECTURER SERVICES

-- Get Department
SELECT * FROM department

-- Get ticket list
SELECT t.*,
       user_info.user_name AS admin_handler
FROM
  (SELECT tic.*,
          user_info.user_name AS author
   FROM ticket tic
   JOIN user_information user_info ON tic.user_id = user_info.user_id) t
JOIN user_information user_info ON t.admin_id = user_info.user_id
WHERE t.user_id = '${lecturerID}'

-- Get Student List
SELECT uni_student.*,
       user_info.*,
       d.department_name
FROM student uni_student,
     user_information user_info,
     department d
WHERE uni_student.user_id = user_info.user_id
  AND uni_student.department_id = d.department_id
ORDER BY uni_student.user_id asc

-- Get Course List
SELECT * FROM course c WHERE c.lecturer_id = '${lecturer_id}'

-- Get Document List
SELECT * FROM lecture_document lec_doc WHERE lec_doc.lecture_id = '${lectureID}' 

-- Get Quiz List
SELECT t.quiz_id,
       t.title,
       t.description,
       COUNT(qq.quiz_question_id) AS num_of_questions
FROM
  (SELECT q.quiz_id,
          q.title,
          q.description
   FROM quiz q
   WHERE q.lecture_id = '${lectureID}') t
LEFT JOIN quiz_question AS qq ON t.quiz_id = qq.quiz_id
GROUP BY t.quiz_id,
         t.title,
         t.description
         
-- Get Quiz Question List
SELECT *
FROM
  (SELECT t.*,
          mca.multiple_choice_answer,
          mca.is_correct
   FROM
     (SELECT qq.quiz_id,
             qq.quiz_question_id,
             qq.title,
             qq.description,
             qq.max_point,
             qq.quiz_question_type,
             sa.correct_answer AS short_answer
      FROM quiz_question qq
      FULL JOIN correct_answer sa ON sa.quiz_question_id = qq.quiz_question_id) t
   FULL JOIN multiple_choice_answer mca ON mca.quiz_question_id = t.quiz_question_id) t
WHERE t.quiz_id = '${quizID}'

-- Get Attempt Detail
SELECT t.*,
       user_info.user_name
FROM
  (SELECT *
   FROM
     (SELECT t.*,
             ad.created_at
      FROM
        (SELECT a.attempt_detail_id,
                a.student_id,
                a.quiz_id,
                at.attempt_answer_id,
                at.answer_content
         FROM attempt a
         FULL JOIN attempt_answer AT ON a.attempt_detail_id = at.attempt_detail_id) t
      FULL JOIN attempt_detail ad ON ad.attempt_detail_id = t.attempt_detail_id) t
   WHERE t.quiz_id = '${quizID}') t
JOIN user_information user_info ON t.student_id = user_info.user_id

-- AUTHENTICATION SERVICE
SELECT user_info.account_type,
       user_info.user_id,
       user_info.user_name
FROM user_information user_info
WHERE user_info.user_name = '${username}'
  AND user_info.user_password = '${password}'
  
-- ADMIN SERVICE

-- Get Admin List
SELECT uni_admin.*,
       user_info.*,
       d.department_name
FROM administrator uni_admin,
     user_information user_info,
     department d
WHERE uni_admin.user_id = user_info.user_id
  AND uni_admin.department_id=d.department_id
ORDER BY uni_admin.user_id asc

-- Get Lecturer List
SELECT uni_lecturer.*,
       user_info.*,
       d.department_name
FROM lecturer uni_lecturer,
     user_information user_info,
     department d
WHERE uni_lecturer.user_id = user_info.user_id
  AND uni_lecturer.department_id = d.department_id
ORDER BY uni_lecturer.user_id asc

-- Get Student List
SELECT uni_student.*,
       user_info.*,
       d.department_name
FROM student uni_student,
     user_information user_info,
     department d
WHERE uni_student.user_id = user_info.user_id
  AND uni_student.department_id = d.department_id
ORDER BY uni_student.user_id asc

-- Get Ticket List
SELECT t.*,
       user_info.user_name AS admin_handler
FROM
  (SELECT tic.*,
          user_info.user_name AS author
   FROM ticket tic
   JOIN user_information user_info ON tic.user_id = user_info.user_id) t
JOIN user_information user_info ON t.admin_id = user_info.user_id

SELECT * FROM course
SELECT * FROM department
SELECT * FROM lecture lec WHERE lec.course_id = '${courseID}'


-- Get Question List
SELECT *
FROM
  (SELECT f.*,
          user_info.user_name AS lecturer_name
   FROM
     (SELECT forum.*,
             user_info.user_name AS student_name
      FROM
        (SELECT q.*,
                ans.answer_id,
                ans.answer_content,
                ans.answer_date
         FROM answer ans
         INNER JOIN question q ON q.question_id = ans.question_id) forum,
           user_information user_info
      WHERE forum.student_id = user_info.user_id) f,
        user_information user_info
   WHERE f.lecturer_id = user_info.user_id) q
WHERE q.course_id = '${courseID}'

-- Get Document List
SELECT * FROM lecture_document lec_doc WHERE lec_doc.lecture_id = '${lectureID}' 

-- Get Registered Student in Course
SELECT t.*,
       stu.student_degree,
       stu.student_major,
       stu.student_program,
       stu.department_id
FROM
  (SELECT user_info.*,
          reg.date_of_enrollment
   FROM user_information user_info
   JOIN student_takes_course reg ON reg.student_id = user_info.user_id
   WHERE reg.course_id = '${courseID}') t,
     student stu
WHERE stu.user_id = t.user_id

-- Get Quiz List
SELECT t.quiz_id,
       t.title,
       t.description,
       COUNT(qq.quiz_question_id) AS num_of_questions
FROM
  (SELECT q.quiz_id,
          q.title,
          q.description
   FROM quiz q
   WHERE q.lecture_id = '${lectureID}') t
LEFT JOIN quiz_question AS qq ON t.quiz_id = qq.quiz_id
GROUP BY t.quiz_id,
         t.title,
         t.description
         
-- Get Quiz Question list
SELECT *
FROM
  (SELECT t.*,
          mca.multiple_choice_answer,
          mca.is_correct
   FROM
     (SELECT qq.quiz_id,
             qq.quiz_question_id,
             qq.title,
             qq.description,
             qq.max_point,
             qq.quiz_question_type,
             sa.correct_answer AS short_answer
      FROM quiz_question qq
      FULL JOIN correct_answer sa ON sa.quiz_question_id = qq.quiz_question_id) t
   FULL JOIN multiple_choice_answer mca ON mca.quiz_question_id = t.quiz_question_id) t
WHERE t.quiz_id = '${quizID}'

-- Get Attempt Detail
SELECT t.*,
       user_info.user_name
FROM
  (SELECT *
   FROM
     (SELECT t.*,
             ad.created_at
      FROM
        (SELECT a.attempt_detail_id,
                a.student_id,
                a.quiz_id,
                at.attempt_answer_id,
                at.answer_content
         FROM attempt a
         FULL JOIN attempt_answer AT ON a.attempt_detail_id = at.attempt_detail_id) t
      FULL JOIN attempt_detail ad ON ad.attempt_detail_id = t.attempt_detail_id) t
   WHERE t.quiz_id = '${quizID}') t
JOIN user_information user_info ON t.student_id = user_info.user_id
