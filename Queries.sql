--QUERY STATEMENTS

--1.UPDATE THE ATTENDANCE TABLE, CLASS_ID ATTRIBUTE WITH VALUE 65 WHERE ATTENDANCE ID EQUALS 1
UPDATE public."Attendance" SET class_id = 65 WHERE attendance_id = 1

--2.INSERT NEW ROW OF DATA INTO THE ATTENDANCE TABLE
INSERT into public."Attendance" (attendance_id, member_id, class_id, attendance_date)
VALUES('1003', '800', '96', '2023-06-02')

--3.JOIN THE START DATE AND PAYMENT_STATUS FROM THE MEMBERSHIP TABLE WITH THE PAYMENT DATE AND 
--NEXT_PAYMENT FROM THE THE PAYMENTS TABLE, ON THE MEMBERSHIP_ID OF EACH TABLE, ORDERED BY THE
--PAYMENT DATE
SELECT
	public."Membership".membership_id,
	start_date,
	payment_status,
	payment_date,
	next_payment
FROM
	public."Membership"
INNER JOIN public."Payments" 
    ON public."Membership".membership_id = public."Payments".membership_id
ORDER BY payment_date;

--4.Displays the total maintenance cost for each equipment type.
SELECT
	equipment_type,
	SUM(maintenance_cost)
FROM
	public."Equipment"
GROUP BY
	equipment_type;
	
--5.Displays the total maintenance cost for each equipment type in ascending order.
SELECT
	equipment_type,
	SUM(maintenance_cost)
FROM
	public."Equipment"
GROUP BY
	equipment_type
ORDER BY
	SUM(maintenance_cost) ASC;
	
--6.Displays the instructors who have the same first name.
SELECT 
	instructor_first
FROM 
	public."Instructor"
GROUP BY
	instructor_first
HAVING
	count (instructor_first) > 1;

--7.Displays the members first and last name if their member status is set to true.
SELECT
	member_id,
	member_first,
	member_last,
	member_status
FROM
	public."Member"
WHERE
	member_status=true
GROUP BY
	member_id;
	
--8. Displays the members first and last name if their member status is set to true and orders it by member id.
SELECT
	member_id,
	member_first,
	member_last,
	member_status
FROM
	public."Member"
WHERE
	member_status=true
GROUP BY
	member_id
ORDER BY
	member_id;


