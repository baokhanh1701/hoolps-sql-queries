-- User
-- Inserting data for Administrators
INSERT INTO user_information (user_id, user_name, user_password, email, address, first_name, last_name, birthday, sex, description, country, account_type)
VALUES 
  ('0', 'admin_johnson', 'admin000', 'johnson@gmail.com', '123 Oak St', 'Jaden', 'Johnson', '1978-05-20', 'M', 'Experienced administrator overseeing IT operations.', 'USA', 'Administrator'),
  ('1', 'admin_smith', 'admin001', 'smith@gmail.com', '456 Maple Ave', 'Park', 'Smith', '1985-09-15', 'F', 'Administrator with a background in project management.', 'Canada', 'Administrator'),
  ('2', 'admin_davis', 'admin002', 'davis@gmail.com', '789 Pine Rd', 'Micheal', 'Davis', '1982-03-10', 'M', 'Administrator specializing in financial planning and analysis.', 'UK', 'Administrator'),
  ('3', 'admin_miller', 'admin003', 'miller@gmail.com', '101 Elm St', 'Miles', 'Miller', '1970-12-05', 'F', 'Administrator with a focus on organizational development.', 'Australia', 'Administrator'),
  ('4', 'admin_clark', 'admin004', 'clark@gmail.com', '202 Cedar Ave', 'Kent', 'Clark', '1988-07-28', 'M', 'Administrator experienced in human resources management.', 'USA', 'Administrator');

-- Inserting data for Students
INSERT INTO user_information (user_id, user_name, user_password, email, address, first_name, last_name, birthday, sex, description, country, account_type)
VALUES 
  ('5', 'student_minh', 'student001', 'minh@gmail.com', '303 Spruce Blvd', 'Tran', 'Minh', '1998-02-15', 'F', 'Computer science major with a passion for coding.', 'USA', 'Student'),
  ('6', 'student_tan', 'student002', 'tan@gmail.com', '404 Birch St', 'Nguyen', 'Tan', '1997-11-25', 'M', 'Engineering student interested in robotics and automation.', 'Canada', 'Student'),
  ('7', 'student_ngoc', 'student003', 'ngoc@gmail.com', '505 Pine Ave', 'Ly', 'Ngoc', '1996-07-30', 'F', 'Biology major aspiring to work in genetic research.', 'UK', 'Student'),
  ('8', 'student_kim', 'student004', 'kim@gmail.com', '606 Cedar Rd', 'Jan', 'Kim', '1999-04-18', 'M', 'Economics major with a keen interest in global financial markets.', 'Australia', 'Student'),
  ('9', 'student_wang', 'student005', 'wang@gmail.com', '707 Elm Blvd', 'Shu', 'Wang', '1994-08-10', 'F', 'Psychology major passionate about understanding human behavior.', 'USA', 'Student');

-- Inserting data for Lecturers
INSERT INTO user_information (user_id, user_name, user_password, email, address, first_name, last_name, birthday, sex, description, country, account_type)
VALUES 
  ('10', 'lecturer_daniel', 'lecturer001', 'daniel@gmail.com', '808 Oak Ave', 'Marcus', 'Daniel', '1975-03-15', 'M', 'Experienced lecturer in Computer Science with expertise in algorithms.', 'Canada', 'Lecturer'),
  ('11', 'lecturer_nguyen', 'lecturer002', 'nguyen@gmail.com', '909 Birch St', 'Tran', 'Nguyen', '1980-11-22', 'F', 'Physics lecturer conducting research in quantum mechanics.', 'UK', 'Lecturer'),
  ('12', 'lecturer_jones', 'lecturer003', 'jones@gmail.com', '1010 Pine Rd', 'Indiana', 'Jones', '1978-06-30', 'M', 'Biology lecturer specializing in molecular biology and genetics.', 'Australia', 'Lecturer'),
  ('13', 'lecturer_lee', 'lecturer004', 'lee@gmail.com', '1111 Elm Ave', 'Ming', 'Lee', '1985-09-12', 'F', 'Chemistry lecturer with a focus on organic chemistry.', 'USA', 'Lecturer'),
  ('14', 'lecturer_gomez', 'lecturer005', 'gomez@gmail.com', '1212 Cedar Blvd', 'Selena', 'Gomez', '1972-04-05', 'M', 'Mathematics lecturer specializing in calculus and linear algebra.', 'Canada', 'Lecturer');

-- Department
INSERT INTO department (department_id, email, address, description, department_name)
VALUES
    ('IT', 'it_department@example.com', '123 Tech Street', 'Information Technology Department', 'IT Department'),
    ('HR', 'hr_department@example.com', '456 HR Avenue', 'Human Resources Department', 'HR Department'),
    ('Finance', 'finance_department@example.com', '789 Finance Lane', 'Finance Department', 'Finance Department'),
    ('Marketing', 'marketing_department@example.com', '101 Marketing Blvd', 'Marketing Department', 'Marketing Department'),
    ('Engineering', 'engineering_department@example.com', '202 Engineering Road', 'Engineering Department', 'Engineering Department');

-- Student
INSERT INTO student (user_id, department_id, student_status, student_class, student_degree, student_program, student_major)
VALUES
    ('5', 'IT', 'Active', 'A101', 'Bachelor', 'Computer Science', 'Software Engineering'),
    ('6', 'HR', 'Inactive', 'B203', 'Master', 'Business Administration', 'Human Resources Management'),
    ('7', 'Finance', 'Active', 'F305', 'Bachelor', 'Finance', 'Financial Analysis'),
    ('8', 'IT', 'Banned', 'A101', 'Associate', 'Computer Science', 'Programming Fundamentals'),
    ('9', 'Marketing', 'Active', 'B203', 'Doctoral', 'Business Administration', 'Organizational Behavior');

-- Administrator
INSERT INTO administrator (user_id, department_id)
VALUES
    ('0', 'IT'),
    ('1', 'HR'),
    ('2', 'Finance'),
    ('3', 'Marketing'),
    ('4', 'Engineering');

-- Lecturer
INSERT INTO lecturer (user_id, department_id, lecturer_degree, lecturer_specialty)
VALUES
    ('10', 'IT', 'Master', 'Computer Networks'),
    ('11', 'HR', 'Doctoral', 'Organizational Psychology'),
    ('12', 'Finance', 'Professor', 'Financial Management'),
    ('13', 'Marketing', 'Doctoral', 'Digital Marketing'),
    ('14', 'Engineering', 'Associate Professor', 'Civil Engineering');

-- Ticket
INSERT INTO ticket (ticket_id, ticket_type, created_at, process_at, description, status, user_id, admin_id)
VALUES
    ('T001', 'Issue', '2023-01-10', null, 'Connection problem with the software.', 'Requesting', '9', '1'),
    ('T002', 'Policy', '2023-02-15', '2023-02-20', 'Enquiry about company policies.', 'Resolving', '12', '2'),
    ('T003', 'Report', '2023-03-20', '2023-03-25', 'Reporting a bug in the application.', 'Resolving', '6', '3'),
    ('T004', 'Other', '2023-04-05', null, 'General inquiry about services.', 'Requesting', '14', '4'),
    ('T005', 'Issue', '2023-05-12', null, 'Technical issue with account access.', 'Requesting', '5', '0');

-- Question
INSERT INTO question (question_id, question_content, created_at, answer_date, course_id, student_id, lecturer_id)
VALUES
    ('Q001', 'How does artificial intelligence impact society?', '2023-01-15', '2023-01-20', 'CS101', '5', '11'),
    ('Q002', 'What are the key principles of marketing?', '2023-02-20', '2023-02-25', 'MKT202', '8', '12'),
    ('Q003', 'Explain the concept of supply and demand.', '2023-03-10', '2023-03-15', 'ECON101', '9', '14'),
    ('Q004', 'Can you provide an example of a programming challenge?', '2023-04-05', '2023-04-10', '7', 'S004', '10'),
    ('Q005', 'How does climate change affect ecosystems?', '2023-05-12', '2023-05-18', 'ENVS101', '6', '13');

-- Answer
INSERT INTO answer (answer_id, answer_date, answer_content, question_id)
VALUES
    ('A001', '2023-01-20', 'Artificial intelligence has significant impacts on society, influencing various sectors such as healthcare, finance, and education.', 'Q001'),
    ('A002', '2023-02-25', 'Key principles of marketing include product, price, place, and promotion, collectively known as the 4Ps.', 'Q002'),
    ('A003', '2023-03-15', 'Supply and demand are fundamental economic concepts. Supply represents the quantity of a good that producers are willing to offer, while demand represents the quantity consumers are willing to buy.', 'Q003'),
    ('A004', '2023-04-10', 'Sure! Here is a programming challenge: Write a function to calculate the factorial of a given number.', 'Q004'),
    ('A005', '2023-05-18', 'Climate change affects ecosystems through temperature changes, sea-level rise, and altered precipitation patterns, leading to biodiversity loss and habitat disruption.', 'Q005');

-- Admin manage department
INSERT INTO admin_manages_department (admin_id, department_id)
VALUES
    ('0', 'IT'),
    ('1', 'HR'),
    ('2', 'Finance'),
    ('3', 'Marketing'),
    ('4', 'Engineering');

-- Course
INSERT INTO course (course_id, course_name, course_description, lecturer_id, modified_at)
VALUES
    ('CS101', 'Introduction to Computer Science', 'Fundamental concepts of computer science and programming.', '10', '2023-01-15'),
    ('MKT202', 'Marketing Strategies', 'Strategic approaches to marketing and brand management.', '12', '2023-02-20'),
    ('ECON101', 'Principles of Economics', 'Introduction to basic economic principles and theories.', '13', '2023-03-10'),
    ('S004', 'Advanced Programming', 'In-depth study of advanced programming concepts and techniques.', '14', '2023-04-05'),
    ('ENVS101', 'Environmental Science', 'Study of environmental issues and sustainable practices.', '11', '2023-05-12');

-- Admin manage course
INSERT INTO admin_manages_course (admin_id, course_id)
VALUES
    ('0', 'CS101'),
    ('1', 'MKT202'),
    ('2', 'ECON101'),
    ('3', 'S004'),
    ('4', 'ENVS101');

-- Student take course
INSERT INTO student_takes_course (student_id, course_id, date_of_enrollment)
VALUES
    ('5', 'CS101', '2023-01-15'),
    ('6', 'MKT202', '2023-02-20'),
    ('7', 'ECON101', '2023-03-10'),
    ('8', 'CS101', '2023-04-05'),
    ('9', 'ENVS101', '2023-05-12');

-- lecture
INSERT INTO lecture (lecture_id, course_id, lecture_name, lecture_content)
VALUES
    ('L001', 'CS101', 'Introduction to Programming', 'Basic concepts of programming and problem-solving.'),
    ('L002', 'MKT202', 'Marketing Fundamentals', 'Understanding the foundational principles of marketing.'),
    ('L003', 'ECON101', 'Microeconomics', 'Study of individual economic units and market behavior.'),
    ('L004', 'CS101', 'Data Structures and Algorithms', 'In-depth exploration of data structures and algorithms.'),
    ('L005', 'ENVS101', 'Environmental Challenges', 'Examining global environmental challenges and sustainable solutions.');

-- Lecture's document
INSERT INTO lecture_document (document_id, lecture_id, course_id, author, title, subject)
VALUES
    ('D001', 'L001', 'CS101', 'John Doe', 'Programming Basics', 'Programming'),
    ('D002', 'L002', 'MKT202', 'Jane Smith', 'Marketing Strategies', 'Marketing'),
    ('D003', 'L003', 'ECON101', 'Bob Johnson', 'Microeconomics Principles', 'Economics'),
    ('D004', 'L004', 'CS101', 'Alice Brown', 'Data Structures Overview', 'Computer Science'),
    ('D005', 'L005', 'ENVS101', 'Charlie Green', 'Environmental Challenges Report', 'Environmental Science');

-- Attempt
INSERT INTO attempt (quiz_id, lecture_id, course_id, student_id, attempt_detail_id)
VALUES
    ('QZ001', 'L001', 'CS101', '5', 'AD001'),
    ('QZ001', 'L001', 'CS101', '5', 'AD002'),
    ('QZ002', 'L002', 'MKT202', '6', 'AD003'),
    ('QZ003', 'L003', 'ECON101', '7', 'AD004'),
    ('QZ003', 'L003', 'ECON101', '7', 'AD005'),
    ('QZ004', 'L004', 'CS101', '8', 'AD006'),
    ('QZ004', 'L004', 'CS101', '8', 'AD007'),
    ('QZ001', 'L001', 'CS101', '5', 'AD008'),
    ('QZ005', 'L005', 'ENVS101', '9', 'AD009'),
    ('QZ005', 'L005', 'ENVS101', '9', 'AD010');

-- Attempt detail
INSERT INTO attempt_detail (attempt_detail_id, created_at)
VALUES
    ('AD001', '2023-11-20'),
    ('AD002', '2023-11-20'),
    ('AD003', '2023-11-19'),
    ('AD004', '2023-11-21'),
    ('AD005', '2023-11-21'),
    ('AD006', '2023-11-20'),
    ('AD007', '2023-11-20'),
    ('AD008', '2023-11-20'),
    ('AD009', '2023-11-24'),
    ('AD010', '2023-11-24');

-- Attempt answer
INSERT INTO attempt_answer (attempt_answer_id, answer_content, attempt_detail_id)
VALUES
    ('AA001', 'int', 'AD001'),
    ('AA002', 'Display output to the screen', 'AD002'),
    ('AA003', 'Connectivity', 'AD003'),
    ('AA004', 'Salary and Wage', 'AD004'),
    ('AA005', 'I do not know', 'AD005'),
    ('AA006', 'An array or list structure of function calls and parameters', 'AD006'),
    ('AA007', 'add()', 'AD007'),
    ('AA008', '8 bits', 'AD008'),
    ('AA009', 'Cooler climate', 'AD009'),
    ('AA010', 'A molecule or an atom loses an electron', 'AD010');

-- Quiz
INSERT INTO quiz (quiz_id, lecture_id, course_id, description, title)
VALUES
    ('QZ001', 'L001', 'CS101', 'Fundamental programming concepts quiz.', 'Programming Basics Quiz'),
    ('QZ002', 'L002', 'MKT202', 'Test your knowledge of marketing strategies.', 'Marketing Strategies Quiz'),
    ('QZ003', 'L003', 'ECON101', 'Microeconomics principles quiz.', 'Microeconomics Quiz'),
    ('QZ004', 'L004', 'CS101', 'Quiz on data structures and algorithms.', 'Data Structures Quiz'),
    ('QZ005', 'L005', 'ENVS101', 'Environmental challenges quiz.', 'Environmental Challenges Quiz');

-- Quiz's question
INSERT INTO quiz_question (quiz_question_id, title, description, max_point, quiz_question_type, attempt_detail_id, quiz_id, lecture_id, course_id)
VALUES
    ('QQ001', 'Programming Basics', 'Keyword used for integer datatypes is', '10', 'Multiple choice', 'AD001', 'QZ001', 'L001', 'CS101'),
    ('QQ002', 'Programming Basics', 'Cout is used for', '8', 'Short answer', 'AD002', 'QZ001', 'L001', 'CS101'),
    ('QQ003', 'Marketing Strategies', 'The ability to provide individually differentiated product', '5', 'Multiple choice', 'AD003', 'QZ002', 'L002', 'MKT202'),
    ('QQ004', 'Economics Concepts', 'The largest portion of income comes from', '12', 'Multiple choice', 'AD004', 'QZ003', 'L003', 'ECON101'),
    ('QQ005', 'Economics Concepts', 'State the definition of economy', '15', 'Short answer', 'AD005', 'QZ003', 'L003', 'ECON101'),
    ('QQ006', 'Programming Logic', 'What is a stack?', '8', 'Short answer', 'AD006', 'QZ004', 'L004', 'CS101'),
    ('QQ007', 'Programming Logic', 'Function to insert items to a vector', '6', 'Multiple choice', 'AD007', 'QZ004', 'L004', 'CS101'),
    ('QQ008', 'Programming Basics', 'One byte equals how many bits?', '7', 'Short answer', 'AD008', 'QZ001', 'L001', 'CS101'),
    ('QQ009', 'Environmental Challenges', 'Which is the effect of global warming?', '10', 'Multiple choice', 'AD009', 'QZ005', 'L005', 'ENVS101'),
    ('QQ010', 'Environmental Challenges', 'Explain the concept of Oxidation', '9', 'Short Answer', 'AD010', 'QZ005', 'L005', 'ENVS101');

-- Short answer
INSERT INTO short_answer (quiz_question_id)
VALUES
    ('QQ002'),
    ('QQ005'),
    ('QQ006'),
    ('QQ008'),
    ('QQ0010');

-- Correct answer
INSERT INTO correct_answer (correct_answer, quiz_question_id)
VALUES
    ('Display output to the screen', 'QQ002'),
    ('The way people spend money and the way people make money', 'QQ005'),
    ('An array or list structure of function calls and parameters', 'QQ006'),
    ('8 bits', 'QQ008'),
    ('A molecule or an atom loses an electron', 'QQ0010');

-- Multiple choice
INSERT INTO multiple_choice (quiz_question_id)
VALUES
    ('QQ001'),
    ('QQ003'),
    ('QQ004'),
    ('QQ007'),
    ('QQ009');

-- Multiple choice answer
INSERT INTO multiple_choice_answer (multiple_choice_answer, quiz_question_id, is_correct)
VALUES
    ('number', 'QQ001', false),
    ('float', 'QQ001', false),
    ('int', 'QQ001', true),
    ('Connectivity', 'QQ003', false),
    ('Digitalization', 'QQ003', false),
    ('Customerisation', 'QQ003', true)
    ('Stock interest', 'QQ004', false),
    ('Salary and Wage', 'QQ004', true),
    ('push_back()', 'QQ007', true),
    ('insert()', 'QQ007', false),
    ('push()', 'QQ007', false),
    ('add()', 'QQ007', false),
    ('Cooler climate', 'QQ009', false),
    ('Cleaner air', 'QQ009', false),
    ('Extreme weather', 'QQ009', true);