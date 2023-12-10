-- User

CREATE UNIQUE INDEX Index_user ON user_information(user_id);

-- Student

CREATE UNIQUE INDEX Index_student ON student(user_id);

-- Ticket

CREATE UNIQUE INDEX Index_ticket ON ticket(ticket_id);

-- Lecturer

CREATE UNIQUE INDEX Index_lecturer ON lecturer(user_id);

-- Question

CREATE UNIQUE INDEX Index_question ON question(question_id);

-- Course 

CREATE UNIQUE INDEX Index_course ON course(course_id);

-- Quiz question

CREATE UNIQUE INDEX Index_quiz_question ON quiz_question(quiz_question_id);

-- Short answer

CREATE UNIQUE INDEX Index_short_answer ON short_answer(quiz_question_id);

-- Multiple choice

CREATE UNIQUE INDEX Index_multiple_choice ON multiple_choice(quiz_question_id);