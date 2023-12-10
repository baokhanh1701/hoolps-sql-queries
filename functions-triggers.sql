-- Update student enrollment counter
CREATE OR REPLACE FUNCTION update_student_enrollment_counter()
RETURNS TRIGGER AS $$
BEGIN
  -- Update the enrollment counter whenever a student enrolls in a course
  IF TG_OP = 'INSERT' THEN
    UPDATE course
    SET enrollment_count = enrollment_count + 1
    WHERE course_id = NEW.course_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_student_enrollment_counter_trigger
AFTER INSERT ON student_takes_course
FOR EACH ROW
EXECUTE FUNCTION update_student_enrollment_counter();

-- Prevent department deletion
CREATE OR REPLACE FUNCTION prevent_department_deletion()
RETURNS TRIGGER AS $$
BEGIN
  -- Prevent deletion of a department if it has associated students
  IF TG_OP = 'DELETE' THEN
    IF EXISTS (SELECT 1 FROM student WHERE department_id = OLD.department_id) THEN
      RAISE EXCEPTION 'Cannot delete a department with associated students.';
    END IF;
  END IF;

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_department_deletion_trigger
BEFORE DELETE ON department
FOR EACH ROW
EXECUTE FUNCTION prevent_department_deletion();

-- Update course modification timestamp
CREATE OR REPLACE FUNCTION update_course_modification_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  -- Update the modification timestamp whenever a course is modified
  IF TG_OP = 'UPDATE' THEN
    NEW.modified_at = NOW();
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_course_modification_timestamp_trigger
BEFORE UPDATE ON course
FOR EACH ROW
EXECUTE FUNCTION update_course_modification_timestamp();

update course
	set course_description = 'In-depth study of advanced programming concepts and techniques. As well as other computer stuffs.'
	where course_id = 'S004'
	
CREATE OR REPLACE FUNCTION enforce_ticket_status_change()
RETURNS TRIGGER AS $$
BEGIN
  -- Ensure that certain conditions are met when changing the status of a ticket
  IF NEW.status = 'Resolved' AND OLD.status != 'Resolved' AND NEW.admin_id IS NULL THEN
    RAISE EXCEPTION 'Resolved tickets must have a resolved user.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_ticket_status_change_trigger
BEFORE UPDATE ON ticket
FOR EACH ROW
EXECUTE FUNCTION enforce_ticket_status_change();

UPDATE ticket SET status = 'Resolved' WHERE ticket_id = 'T001';

