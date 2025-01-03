#create the database Hospital management

create database hospital;
use   hospital;

-- create the table patients

create table patients(
patient_id int primary key auto_increment,
first_name varchar(30) not null,
last_name varchar(30) not null,
age varchar(30),
email varchar(40),
mobile_no varchar(60) unique 
);
 
insert into patients(patient_id,first_name,last_name,age,email,mobile_no)
values (1,"nobita","niyan",18,"nobinobita@gmail.com",9025186962),
(2,"dora","doramon",20,"dorayaki@gmail.com",9754877856),
(3,"dorami","kawaki",19,"dorami@gmail.com",9045892799),
(4,"suzi","suzuka",18,"suzukaa@gmail.com",8308489889),
(5,"takishi","giyan",21,"giyangiyan@gmail.com",8786876767),
(6,"suniyo","sunaimaro",22,"suniyosuniyo@gmail.com",6380853737);

-- create the table doctors

create table doctors(
doctor_id int primary key auto_increment,
doctor_name varchar(40) not null,
speciality varchar (40),
email varchar(50),
mobile_no varchar(40)
);

insert into doctors(doctor_id,doctor_name,speciality,email,mobile_no)values
(1,"Dr.gopaul","cardiologist","gopaul123@gmail.com",8976897654),
(2,"Dr.babu","dermatologists","babuu3@gmail.com",7879654754),
(3,"Dr.premji","gastroenterologists","premji@gmail.com",9054636687),
(4,"Dr.daniel","hematologists","daniel67@gmail.com",6387657987),
(5,"Dr.jamespond","neurologists","jamespond@gmail.com",9076432789),
(6,"Dr.john","oncologists","john@gmail.com",7867568987);

-- create the table appointments

create table appointments(
appointment_id int primary key auto_increment,
patient_id int,
doctor_id int,
appointment_date date not null,
foreign key (patient_id) references patients (patient_id),
foreign key (doctor_id) references doctors(doctor_id)
);
-- alter the table appointments 

alter table appointments add status  varchar(100);

insert into appointments(appointment_id,patient_id,doctor_id,appointment_date,status) values
(1,1,1,"2024-12-25","completed"),
(2,2,2,"2024-12-26","completed"),
(3,3,3,"2024-12-30","scheduled"),
(4,4,4,"2025-01-01","scheduled"),
(5,5,5,"2025-01-03","cancelled"),
(6,6,6,"2025-01-05","scheduled");

-- create the table medicalrecords

create table medicalrecords(
medicalrecord_id int primary key,
patient_id int not null,
doctor_id int not null,
visit_date date,
diagnosis varchar(80),
foreign key (patient_id) references patients (patient_id),
foreign key (doctor_id) references doctors (doctor_id)
);

insert into medicalrecords(medicalrecord_id,patient_id,doctor_id,visit_date,diagnosis)
values(1,1,1,"2024-12-01","heart diseas"),
(2,2,2,"2024-12-03","skin problem"),
(3,3,3,"2024-12-05","liver failure"),
(4,4,4,"2024-12-14","back pain");



select * from patients;
select * from doctors;
select * from appointments;
select * from medicalrecords;

/*Queirs*/

select * from patients where age>=20;

select first_name,last_name,age,patient_id,email,mobile_no 
from patients where patient_id=1;

update patients set last_name="nobisuke" where patient_id=1; 

select * from patients order by age asc;
select * from doctors order by doctor_id desc;
select count(*)from doctors;

 select p.first_name,a.appointment_date
 from patients p inner join appointments a on p.patient_id=a.patient_id;
select p.patient_id,p.first_name,a.status
from patients p inner join appointments a on p.patient_id=a.patient_id;
 
select d.doctor_id,d.doctor_name,m.diagnosis 
from doctors d right join medicalrecords m on d.doctor_id=m.doctor_id;

select medicalrecord_id,visit_date from medicalrecords
where medicalrecord_id in(select medicalrecord_id from medicalrecords where visit_date="2024-12-08");

delete from patients where patient_id=4;

select first_name 
from patients 
group by first_name
having count(5) order by first_name asc;
-- store procedure
delimiter   $$

create procedure get_doctors(in input_doctor_id int)
begin 
    select count(doctor_id) as totaldoctors from doctors 
    where doctor_id=input_doctor_id;
end    $$
delimiter ;
 
 
 
 drop database hospital;
 
 #END