--QUERY STATEMENTS

--SELECT ALL DATA FROM ATTENDANCE TABLE
select * from public."Attendance"
order by attendance_id asc

--UPDATE THE ATTENDANCE TABLE, CLASS_ID ATTRIBUTE WITH VALUE 65 WHERE ATTENDANCE ID EQUALS 1
UPDATE public."Attendance" SET class_id = 65 WHERE attendance_id = 1

--INSERT NEW ROW OF DATA INTO THE ATTENDANCE TABLE
INSERT into public."Attendance" (attendance_id, member_id, class_id, attendance_date)
VALUES('1001', '800', '96', '2023-06-02')

--JOIN THE START DATE AND PAYMENT_STATUS FROM THE MEMBERSHIP TABLE WITH THE PAYMENT DATE AND 
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


