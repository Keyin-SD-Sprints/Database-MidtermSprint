BEGIN;


CREATE TABLE IF NOT EXISTS public."Attendance"
(
    attendance_id serial NOT NULL,
    member_id integer NOT NULL,
    class_id integer NOT NULL,
    attendance_date date NOT NULL,
    CONSTRAINT "Attendance_pkey" PRIMARY KEY (attendance_id)
);

CREATE TABLE IF NOT EXISTS public."Class"
(
    class_id serial NOT NULL,
    timeslot_id integer NOT NULL,
    class_name character varying(255) NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT "Class_pkey" PRIMARY KEY (class_id)
);

CREATE TABLE IF NOT EXISTS public."Schedule"
(
    schedule_id serial NOT NULL,
    class_id integer NOT NULL,
    instructor_id integer NOT NULL,
    timeslot_id integer NOT NULL,
    CONSTRAINT "Schedule_pkey" PRIMARY KEY (schedule_id)
);

CREATE TABLE IF NOT EXISTS public."Instructor"
(
    instructor_id serial NOT NULL,
    instructor_first character varying(255) NOT NULL,
    instructor_last character varying(255) NOT NULL,
    instructor_street character varying(255),
    instructor_city character varying(255),
    instructor_province character varying(255),
    instructor_postalcode character varying(10),
    instructor_phone numeric(10, 0),
    instructor_email character varying(100) NOT NULL,
    availability time without time zone NOT NULL,
    CONSTRAINT "Instructor_pkey" PRIMARY KEY (instructor_id)
);

CREATE TABLE IF NOT EXISTS public."Maintenance"
(
    maintenance_id serial NOT NULL,
    equipment_id integer NOT NULL,
    instructor_id integer NOT NULL,
    maintenance_date date NOT NULL,
    CONSTRAINT "Maintenance_pkey" PRIMARY KEY (maintenance_id)
);

CREATE TABLE IF NOT EXISTS public."Equipment"
(
    equipment_id serial NOT NULL,
    facility_id integer NOT NULL,
    equipment_type character varying(255) NOT NULL,
    date_purchased date NOT NULL,
    maintenance_cost money,
    date_sold date,
    CONSTRAINT "Equipment_pkey" PRIMARY KEY (equipment_id)
);

CREATE TABLE IF NOT EXISTS public."Timeslot"
(
    timeslot_id serial NOT NULL,
    date date NOT NULL,
    "time" time(6) without time zone NOT NULL,
    duration character varying(24) NOT NULL,
    CONSTRAINT "TimeSlot_pkey" PRIMARY KEY (timeslot_id)
);

CREATE TABLE IF NOT EXISTS public."Member"
(
    member_id serial NOT NULL,
    member_first character varying(255) NOT NULL,
    member_last character varying(255) NOT NULL,
    member_street character varying(255),
    member_addressline2 character varying,
    member_city character varying(255),
    member_province character varying(255),
    member_postalcode character varying(10),
    member_phone numeric(10),
    member_email character varying(255) NOT NULL,
    member_status boolean NOT NULL,
    CONSTRAINT "Member_pkey" PRIMARY KEY (member_id)
);

CREATE TABLE IF NOT EXISTS public."Membership"
(
    membership_id serial NOT NULL,
    member_id integer NOT NULL,
    facility_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    payment_status boolean NOT NULL,
    CONSTRAINT "Membership_pkey" PRIMARY KEY (membership_id)
);

CREATE TABLE IF NOT EXISTS public."Location"
(
    facility_id serial NOT NULL,
    facility_name character varying(255) NOT NULL,
    facility_street character varying(255) NOT NULL,
    facility_city character varying(255) NOT NULL,
    facility_province character varying(255) NOT NULL,
    facility_postal character varying(10) NOT NULL,
    fitnessroom_type character varying(255),
    CONSTRAINT "Location_pkey" PRIMARY KEY (facility_id)
);

CREATE TABLE IF NOT EXISTS public."Billing"
(
    billing_id serial NOT NULL,
    member_id integer NOT NULL,
    membership_id integer NOT NULL,
    invoice_id integer NOT NULL,
    payment_id integer NOT NULL,
    payment_history text,
    payment_method text NOT NULL,
    CONSTRAINT "Billing_pkey" PRIMARY KEY (billing_id)
);

CREATE TABLE IF NOT EXISTS public."Invoice"
(
    invoice_id serial NOT NULL,
    member_id integer NOT NULL,
    membership_id integer NOT NULL,
    invoice_date date NOT NULL,
    hst money NOT NULL,
    taxes money NOT NULL,
    CONSTRAINT "Invoice_pkey" PRIMARY KEY (invoice_id)
);

CREATE TABLE IF NOT EXISTS public."Payments"
(
    payment_id serial NOT NULL,
    membership_id integer NOT NULL,
    payment_amount money NOT NULL,
    payment_date date NOT NULL,
    last_payment date,
    next_payment date,
    CONSTRAINT "Payments_pkey" PRIMARY KEY (payment_id)
);

CREATE TABLE IF NOT EXISTS public."Members_xref_Classes"
(
    member_id integer NOT NULL,
    class_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Members_xref_Schedule"
(
    member_id integer NOT NULL,
    schedule_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Instructor_xref_Classes"
(
    instructor_id integer NOT NULL,
    class_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Instructor_xref_Schedule"
(
    instructor_id integer NOT NULL,
    schedule_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Equipment_xref_Maintenance"
(
    equipment_id integer NOT NULL,
    maintenance_id integer NOT NULL
);

ALTER TABLE IF EXISTS public."Attendance"
    ADD CONSTRAINT "Attendance_class_id_fkey" FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Attendance"
    ADD CONSTRAINT "Attendance_class_id_fkey1" FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Attendance"
    ADD CONSTRAINT "Attendance_member_id_fkey" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Attendance"
    ADD CONSTRAINT "Attendance_member_id_fkey1" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Class"
    ADD FOREIGN KEY (timeslot_id)
    REFERENCES public."Timeslot" (timeslot_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_class_id_fkey" FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_class_id_fkey1" FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_instructor_id_fkey" FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_instructor_id_fkey1" FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_timeslot_id_fkey" FOREIGN KEY (timeslot_id)
    REFERENCES public."Timeslot" (timeslot_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Schedule"
    ADD CONSTRAINT "Schedule_timeslot_id_fkey1" FOREIGN KEY (timeslot_id)
    REFERENCES public."Timeslot" (timeslot_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Maintenance"
    ADD CONSTRAINT "Maintenance_equipment_id_fkey" FOREIGN KEY (equipment_id)
    REFERENCES public."Equipment" (equipment_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Maintenance"
    ADD CONSTRAINT "Maintenance_equipment_id_fkey1" FOREIGN KEY (equipment_id)
    REFERENCES public."Equipment" (equipment_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Maintenance"
    ADD CONSTRAINT "Maintenance_instructor_id_fkey" FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Maintenance"
    ADD CONSTRAINT "Maintenance_instructor_id_fkey1" FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Equipment"
    ADD FOREIGN KEY (facility_id)
    REFERENCES public."Location" (facility_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Membership"
    ADD CONSTRAINT "Membership_facility_id_fkey" FOREIGN KEY (facility_id)
    REFERENCES public."Location" (facility_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Membership"
    ADD CONSTRAINT "Membership_facility_id_fkey1" FOREIGN KEY (facility_id)
    REFERENCES public."Location" (facility_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Membership"
    ADD CONSTRAINT "Membership_member_id_fkey" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Membership"
    ADD CONSTRAINT "Membership_member_id_fkey1" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_invoice_id_fkey" FOREIGN KEY (invoice_id)
    REFERENCES public."Invoice" (invoice_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_invoice_id_fkey1" FOREIGN KEY (invoice_id)
    REFERENCES public."Invoice" (invoice_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_member_id_fkey" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_member_id_fkey1" FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_membership_id_fkey" FOREIGN KEY (membership_id)
    REFERENCES public."Membership" (membership_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_membership_id_fkey1" FOREIGN KEY (membership_id)
    REFERENCES public."Membership" (membership_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_payment_id_fkey" FOREIGN KEY (payment_id)
    REFERENCES public."Payments" (payment_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Billing"
    ADD CONSTRAINT "Billing_payment_id_fkey1" FOREIGN KEY (payment_id)
    REFERENCES public."Payments" (payment_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Members_xref_Classes"
    ADD FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Members_xref_Classes"
    ADD FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Members_xref_Schedule"
    ADD FOREIGN KEY (member_id)
    REFERENCES public."Member" (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Members_xref_Schedule"
    ADD FOREIGN KEY (schedule_id)
    REFERENCES public."Schedule" (schedule_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Instructor_xref_Classes"
    ADD FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Instructor_xref_Classes"
    ADD FOREIGN KEY (class_id)
    REFERENCES public."Class" (class_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Instructor_xref_Schedule"
    ADD FOREIGN KEY (instructor_id)
    REFERENCES public."Instructor" (instructor_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Instructor_xref_Schedule"
    ADD FOREIGN KEY (schedule_id)
    REFERENCES public."Schedule" (schedule_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Equipment_xref_Maintenance"
    ADD FOREIGN KEY (equipment_id)
    REFERENCES public."Equipment" (equipment_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Equipment_xref_Maintenance"
    ADD FOREIGN KEY (maintenance_id)
    REFERENCES public."Maintenance" (maintenance_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;