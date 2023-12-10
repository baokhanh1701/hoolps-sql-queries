CREATE TABLE user_information
(
  user_id VARCHAR(255) primary key,
  user_name VARCHAR(255) not null unique,
  user_password VARCHAR(255) not null,
  email VARCHAR(255) not null,
  address VARCHAR(255) not null,
  first_name VARCHAR(255) not null,
  last_name VARCHAR(255) not null,
  birthday VARCHAR(255),
  sex VARCHAR(255) not null check(sex in ('M', 'F', 'Other')),
  description varchar(512),
  country varchar(255),
  account_type varchar(255) not null check(account_type in ('Administrator', 'Student', 'Lecturer'))
);

CREATE TABLE ticket
(
  ticket_id varchar(255) primary key,
  ticket_type varchar(255) not null check(ticket_type in ('Issue', 'Policy', 'Report', 'Other')),
  created_at date,
  process_at date,
  description varchar(512) not null,
  status varchar(255) not null check(status in ('Requesting', 'Resolving', 'Resolved')),
  user_id varchar(255) not null,
  admin_id varchar(255) not null,
  constraint support_user_foreign_key foreign key (user_id) references user_information(user_id),
  constraint support_admin_foreign_key foreign key (admin_id) references administrator(user_id)
);

CREATE TABLE department
(
	department_id varchar(255) primary key,
	email VARCHAR(255) not null,
	address VARCHAR(255) not null,
	description varchar(512) not null,
	department_name VARCHAR(255) not null
);

CREATE TABLE administrator
(
  	user_id varchar(255) primary key,
  	constraint admin_user_foreign_key foreign key (user_id) references user_information(user_id) on delete cascade on update cascade
);

alter table administrator 
	Add department_id varchar(255)
	
alter table administrator 
	add constraint administrator_department_foreign_key foreign key (department_id) references department(department_id) on delete cascade on update cascade
	
CREATE TABLE lecturer
(
  user_id varchar(255) primary key,
  department_id varchar(255),
  lecturer_degree varchar(255) not null check(lecturer_degree in ('Bachelor', 'Master', 'Doctoral', 'Postdoctoral Fellowship', 'Professional Doctorate', 'Specialist', 'Professior', 'Associate Professor')),
  lecturer_specialty varchar(255) not null,
  constraint lecturer_university_foreign_key foreign key (department_id) references department(department_id) on delete cascade on update cascade,
  constraint lecturer_user_foreign_key foreign key (user_id) references user_information(user_id) on delete cascade on update cascade
);


CREATE TABLE student
(
  user_id varchar(255) primary key,
  department_id varchar(255),
  student_status varchar(255) not null check(student_status in ('Active', 'Inactive', 'Banned')),
  student_class varchar(255) not null,
  student_degree varchar(255) not null check(student_degree in ('Associate','Bachelor', 'Master', 'Doctoral')),
  student_program varchar(255) not null,
  student_major varchar(255) not null,
  constraint student_university_foreign_key foreign key (department_id) references department(department_id) on delete set null on update cascade,
  constraint student_user_foreign_key foreign key (user_id) references user_information(user_id) on delete cascade on update cascade
);

create table question
(
	question_id varchar(255) primary key,
	question_content varchar(512),
	created_at date,
	answer_date date,
	course_id varchar(255) not null,
	student_id varchar(255) not null,
	lecturer_id varchar(255) not null,
	constraint student_ask_question foreign key (student_id) references student(user_id) on delete cascade on update cascade,
	constraint lecturer_answer_question foreign key (lecturer_id) references lecturer(user_id) on delete cascade on update cascade,
	constraint question_belongs_to_course foreign key (course_id) references course(course_id) on delete set null on update cascade
);

create table answer
(
	answer_id varchar(255) primary key,
	answer_date date,
	answer_content varchar(512),
	question_id varchar(255) not null,
	constraint question_id foreign key (question_id) references question(question_id) on delete set null on update cascade
)

drop table lecturer_manages_department

create table admin_manages_department
(
	admin_id varchar(255) not null,
	department_id varchar(255) not null,
	primary key (admin_id, department_id),
	constraint admin_foreign_key foreign key (admin_id) references administrator(user_id) on delete cascade,
	constraint department_manage_foreign_key foreign key (department_id) references department(department_id) on delete cascade
)

create table admin_manages_course
(
	admin_id varchar(255) not null,
	course_id varchar(255) not null,
	primary key (admin_id, course_id),
	constraint admin_manage_foreign_key foreign key (admin_id) references administrator(user_id) on delete cascade,
	constraint course_manage_foreign_key foreign key (course_id) references course(course_id) on delete cascade
)

create table student_takes_course
(
	student_id varchar(255) not null,
	course_id varchar(255) not null,
	date_of_enrollment date,
	primary key (student_id, course_id),
	constraint student_take_foreign_key foreign key (student_id) references student(user_id) on delete cascade,
	constraint course_take_foreign_key foreign key (course_id) references course(course_id) on delete cascade
)

drop table lecture

create table lecture
(
	lecture_id varchar(255) not null,
	course_id varchar(255) not null,
	lecture_name varchar(255) not null,
	lecture_content varchar(255) not null,
	primary_key(lecture_id, course_id),
	constraint course_contains_lecture foreign key (course_id) references course(course_id) on delete cascade
);


create table quiz
(
	quiz_id varchar(255) not null,
	lecture_id varchar(255) not null,
	course_id varchar(255) not null,
	description varchar(255) not null,
	title varchar(255) not null,
	primary_key(quiz_id, lecture_id, course_id),
	constraint lecture_includes_quiz foreign key (lecture_id, course_id) references lecture(lecture_id, course_id) on delete cascade
);


create table lecture_document
(
	document_id varchar(255) not null,
	lecture_id varchar(255) not null,
	course_id varchar(255) not null,
	author varchar(512),
	title varchar(255),
	subject varchar(255) not null,
	primary_key (document_id, lecture_id, course_id)
	constraint lecture_includes_lecture_document foreign key (lecture_id, course_id) references lecture(lecture_id, course_id) on delete cascade
)


create table course
(
	course_id varchar(255) primary key,
	course_name varchar(255) not null,
	course_description varchar(255) not null,
	lecturer_id varchar(255),
	modified_at date,
	constraint course_lecturer_foreign_key foreign key (lecturer_id) references lecturer (user_id) on delete set null on update cascade
);

drop table attempt

create table attempt
(
	quiz_id varchar(255) not null,
	lecture_id varchar(255) not null,
	course_id varchar(255) not null,
	student_id varchar(255) not null,
	attempt_detail_id varchar(255) not null,
	primary key(quiz_id, student_id, attempt_detail_id, lecture_id, course_id),
	constraint student_attempt_foreign_key foreign key (student_id) references student(user_id) on delete cascade on update cascade,
	constraint attempt_detail_foreign_key foreign key (attempt_detail_id) references attempt_detail(attempt_detail_id) on delete cascade on update cascade,
	constraint quiz_foreign_key foreign key (quiz_id, lecture_id, course_id) references quiz(quiz_id, lecture_id, course_id) on delete cascade on update cascade
)

drop table attempt_detail

create table attempt_detail
(
	attempt_detail_id varchar(255) primary key,
	created_at date not null,
)

drop table attempt_answer

create table attempt_answer
(
	attempt_answer_id varchar(255) primary key,
	answer_content varchar(512),
	attempt_detail_id varchar(255),
	constraint answer_attempt_detail foreign key (attempt_detail_id) references attempt_detail(attempt_detail_id) on delete cascade on update cascade
)

drop table quiz_question

create table quiz_question
(
	quiz_question_id varchar(255) primary key,
	title varchar(255) not null,
	description varchar(255) not null,
	max_point varchar(255),
  quiz_question_type varchar(255) not null check(quiz_question_type in ('Short Answer', 'Multiple choice')),
	attempt_detail_id varchar(255) not null,
	quiz_id varchar(255) not null,
	lecture_id varchar(255) not null,
	course_id varchar(255) not null,
	constraint attempt_detail_includes_foreign_key foreign key (attempt_detail_id) references attempt_detail(attempt_detail_id) on delete cascade on update cascade,
	constraint quiz_includes_foreign_key foreign key (quiz_id, lecture_id, course_id) references quiz(quiz_id, lecture_id, course_id) on delete cascade on update cascade
)

CREATE TABLE short_answer
(
  	quiz_question_id varchar(255) primary key,
  	constraint short_answer_foreign_key foreign key (quiz_question_id) references quiz_question(quiz_question_id) on delete cascade on update cascade
);

CREATE TABLE corect_answer
(
  	corect_answer varchar(512) not null,
  	quiz_question_id varchar(255) not null,
  	primary_key(corect_answer, quiz_question_id),
  	constraint correct_answer_foreign_key foreign key (quiz_question_id) references short_answer(quiz_question_id) on delete cascade on update cascade
);

CREATE TABLE multiple_choice
(
  	quiz_question_id varchar(255) primary key,
  	constraint short_answer_foreign_key foreign key (quiz_question_id) references quiz_question(quiz_question_id) on delete cascade on update cascade
);

CREATE TABLE multiple_choice_answer
(
  	multiple_choice_answer varchar(512) not null,
  	quiz_question_id varchar(255) not null,
  	is_correct boolean not null,
  	primary_key(multiple_choice_answerr, quiz_question_id),
  	constraint correct_answer_foreign_key foreign key (quiz_question_id) references multiple_choice(quiz_question_id) on delete cascade on update cascade
);

