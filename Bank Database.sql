show databases;
use shubhankar;

create table Branch(bid integer primary key, brname varchar(30), brcity varchar(30));
create table Customer(cno integer primary key, cname varchar(30), caddr varchar(35), city varchar(20));
create table Loan_Application(lno integer primary key, lamt_required integer, lamt_approved integer, l_date date);
create table Ternary(bid integer references Branch(bid) on delete cascade on update cascade, cno integer references Customer(cno) on delete cascade on update cascade, 
					lno integer references Loan_Application(lno) on delete cascade on update cascade);

show tables;

insert into Branch values(1,'MG Road','Pune');
insert into Branch values(2,'Paud Road','Pune');
insert into Branch values(3,'Camp','Pune');
insert into Branch values(4,'Karve Road','Pune');
insert into Branch values(5,'DP Road','Pune');

insert into Customer values(11,'Shubham','Mayur Colony','Pune');
insert into Customer values(12,'Rohan','Mahatma','Pune');
insert into Customer values(13,'Charuta','Warje','Pune');
insert into Customer values(14,'Rucha','Warje','Pune');
insert into Customer values(15,'Aditya','Warje','Pune');

insert into Loan_Application values(111, 10000000, 8000000, '2000-05-16');
insert into Loan_Application values(112, 70000000, 20000000, '2000-10-28');
insert into Loan_Application values(113, 95000000, 9000000, '2000-02-10');
insert into Loan_Application values(114, 95000000, 4000000, '2000-05-17');
insert into Loan_Application values(115, 70000000, 7000000, '2000-09-15');

insert into Ternary values(1,11,111);
insert into Ternary values(2,12,112);
insert into Ternary values(3,13,113);
insert into Ternary values(4,14,114);
insert into Ternary values(5,15,115);


select cname from Customer where cno in (select cno from Ternary where bid in (select bid from Branch where brname = "MG Road" ) );

select cname from Customer where cno in (select cno from Ternary where lno in (select lno from Loan_Application where lamt_approved < lamt_required));

select max(lamt_approved) from Loan_Application;

select sum(lamt_approved) from Loan_Application where lno in(select lno from Ternary where bid in (select bid from Branch where brname = "Camp"));

select count(lno) from Loan_Application where lno in(select lno from Ternary where bid in(select bid from Branch where brname = "MG Road"));

select cname,brname from Customer, Branch, Loan_Application, Ternary where Customer.cno = Ternary.cno AND Branch.bid = Ternary.bid AND Loan_Application.lno = Ternary.lno
AND extract(month from l_date) = 9;