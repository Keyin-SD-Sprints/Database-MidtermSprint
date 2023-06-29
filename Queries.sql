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

--9.1 Displays the members and what classes they are signed up to. Sorted by class name and class_id ascending
-- focuses on the classes.
SELECT
	public."Member".member_id
	,member_first
	,member_last
	,public."Class".class_id
	,class_name
FROM public."Member"
JOIN public."Members_xref_Classes"
	ON public."Member".member_id = public."Members_xref_Classes".member_id
JOIN public."Class"
	ON public."Members_xref_Classes".class_id = public."Class".class_id
ORDER BY
	class_name
	,class_id ASC

--9.2 Changing sort focuses on each customer. Easier to see who is signed up for multiple classes this way.
SELECT
	public."Member".member_id
	,member_first
	,member_last
	,public."Class".class_id
	,class_name
FROM public."Member"
JOIN public."Members_xref_Classes"
	ON public."Member".member_id = public."Members_xref_Classes".member_id
JOIN public."Class"
	ON public."Members_xref_Classes".class_id = public."Class".class_id
ORDER BY
	member_last ASC
	
--10. Shows attendance with class_id, class_name, and date with a count of antendees 
-- sorted ascending by class_name, class_id, and attendance_date.
SELECT
    public."Class".class_id
	,class_name
	,attendance_date
	,COUNT(public."Member".member_id) AS attendee_count
FROM
    public."Class"
JOIN
    public."Attendance" ON public."Class".class_id = public."Attendance".class_id
JOIN
    public."Member" ON public."Attendance".member_id = public."Member".member_id
GROUP BY
    public."Class".class_id,
    class_name,
    attendance_date
ORDER BY 
	class_name,
	class_id,
	attendance_date ASC