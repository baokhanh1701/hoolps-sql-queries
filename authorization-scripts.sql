--Table permissions:

SELECT *
  FROM information_schema.role_table_grants 
 WHERE grantee = 'guest';

--Ownership:

SELECT *
  FROM pg_tables 
 WHERE tableowner = 'knguyenkieubao';

--Schema permissions:

      SELECT r.usename AS grantor,
             e.usename AS grantee,
             nspname,
             privilege_type,
             is_grantable
        FROM pg_namespace
JOIN LATERAL (SELECT *
                FROM aclexplode(nspacl) AS x) a
          ON true
        JOIN pg_user e
          ON a.grantee = e.usesysid
        JOIN pg_user r
          ON a.grantor = r.usesysid 
--       WHERE e.usename = 'admin';

-- readonly role
CREATE ROLE guest PASSWORD 'N1NcIDgj7FGuc40';
GRANT CONNECT ON DATABASE staging_env_db TO guest;
GRANT USAGE ON SCHEMA public TO guest;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO guest;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO guest;

-- User creation
CREATE USER test_user WITH PASSWORD 'user_for_testing';
--
-- Grant privileges to user
--GRANT readonly TO readonly_user1;

create role student password 'N1NcIDgj7FGuc40';


CREATE ROLE administrator WITH 
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	LOGIN
	REPLICATION
	BYPASSRLS
	CONNECTION LIMIT -1
	password 'N1NcIDgj7FGuc40';
grant connect on database staging_env_db to administrator;
grant usage on schema public to administrator;
grant select, insert, update, delete on all tables in schema public to administrator;


create role lecturer with
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	LOGIN
	REPLICATION
	BYPASSRLS
	CONNECTION LIMIT -1
	password 'N1NcIDgj7FGuc40';
grant connect on database staging_env_db to lecturer;
grant usage on schema public to lecturer;
grant select on all tables in schema public to lecturer;
grant insert, update, delete on table course, lecture, lecture_document, lecturer, lecturer_manages_course, multiple_choice, question, quiz, quiz_question, short_answer, student_takes_course, user_information to lecturer;


create role student with
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	LOGIN
	REPLICATION
	BYPASSRLS
	CONNECTION LIMIT -1
	password 'N1NcIDgj7FGuc40';
grant connect on database staging_env_db to student;
grant usage on schema public to student;
grant select on all tables in schema public to student;
grant insert, update, delete on table student, student_takes_course, answer, attempt, attempt_answer, attempt_detail, ticket, user_information to student;
