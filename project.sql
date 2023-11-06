create table Team(
tnumber number(5),
tel varchar2(20),
tname varchar2(20) constraint Team_tname_pk primary key,
Home varchar2(20));

create table schedule(
dnumber varchar2(20) constraint schedule_dnumber_pk primary key,
team2 varchar2(20),
team1 varchar2(20),
date1 varchar2(20),
place varchar2(20),
time1 varchar2(20),
constraint schedule_team_FK1 foreign key (team1) references Team(tname), 
constraint schedule_team_FK2 foreign key (team2) references Team(tname));

create table manager(
mnumber varchar2(4) constraint manager_mnumber_pk primary key,
tel varchar2(20),
password varchar2(8),
name varchar2(20));



insert into Team
values (1000, '010-3037-9093', 'NC', 'â��');

insert into Team
values (1111, '010-2929-9093', 'LG','���� ���');

insert into Team
values (1222, '010-2030-1643', 'SK','��� ��õ');

insert into Team
values (1333, '02-8080-0332', 'KT','��� ����');

insert into Team
values (1444, '02-3636-8993', 'KIA','��������');

insert into Team
values (1555, '02-1232-2131', '�λ�','���� ���');

insert into Team
values (1666, '070-3203-3222', 'Ű��','���� ��ô');

insert into Team
values (1777, '070-9988-3222', '�Ｚ','�뱸');

insert into Team
values (1888, '070-9243-3222', '��ȭ','����');

insert into Team
values (1999, '070-3932-3222', '�Ե�','�λ�');


insert into manager
values (3222, '010-9032-3243', '0611','����(�Ե�)');

insert into manager
values (3111, '010-3232-9099', '0420','���¹�(LG)');

insert into manager
values (3333, '010-3202-9093', '0901','�ɻ���(��ȭ)');

insert into manager
values (3444, '010-3090-1098', '0861','�����(�λ�)');

insert into manager
values (3555, '010-3569-9096', '0884','�谭��(SK)');

insert into manager
values (3666, '010-2319-8132', '0794','�����(�Ｚ)');

insert into manager
values (3777, '010-1025-8123', '0670','����(NC)');

insert into manager
values (3888, '010-4321-0053', '0151','������(Ű��)');

insert into manager
values (3999, '010-1338-1132', '0815','������(KT)');

insert into manager
values (3100, '010-1412-1013', '0703','������(KIA)');

insert into schedule
values ( 5111,'��ȭ', '�λ�','09.01','����','18:30');

insert into schedule
values (5222, 'LG','SK','09.01','����','18:30');

insert into schedule
values ( 5333,'�Ե�','KT','09.01','����','18:30');

insert into schedule
values (5444, 'NC','Ű��','09.01','��ô','18:30');

insert into schedule
values ( 5555,'�Ｚ','KIA','09.01','����','18:30');

insert into schedule
values (5666, '��ȭ','�λ�','09.02','���','18:30');

insert into schedule
values (5777, 'LG','SK','09.02','����','18:30');

insert into schedule
values (5888, '�Ե�','KT','09.02','����','18:30');

insert into schedule
values (5999, 'NC','Ű��','09.02','��ô','18:30');

insert into schedule
values (6000, '�Ｚ','KIA','09.02','����','18:30');

insert into schedule
values (6111, 'KIA','�Ե�','09.03','����','18:30');

insert into schedule
values (6222, 'NC','LG','09.03','���','18:30');

insert into schedule
values (6333, '�λ�','�Ｚ','09.03','�뱸','18:30');

insert into schedule
values (6444, 'SK','KT','09.03','����','18:30');

insert into schedule
values (6555, 'Ű��','��ȭ','09.03','����','18:30');

insert into schedule
values (6666, 'KIA','�Ե�','09.04','����','15:00');

insert into schedule
values (6777, 'SK','KT','09.04','����','15:00');

insert into schedule
values (6888, 'NC','LG','09.04','���','18:30');

insert into schedule
values (6999, '�λ�','�Ｚ','09.04','�뱸','18:30');

insert into schedule
values (7000, 'SK','KT','09.04','����','18:30');

insert into schedule
values (7111, 'Ű��','��ȭ','09.04','����','18:30');

insert into schedule
values (7222, 'KIA','�Ե�','09.04','����','18:54');

-- �ڵ� 

select name as �̸�, tel as "��ȭ ��ȣ", password as "��� ��ȣ", mnumber as "������ ��ȣ"
from manager
where substr(mnumber,1,2) = '36'
or mnumber  in (3333,3555,3888) 
and tel not like '_1412_' 
order by name desc ;

select name  as �̸�, tel as "��ȭ ��ȣ", password  as "��� ��ȣ" 
from manager
where  password not between 0670 and 0794
and name not like '%��%'
or tel like '%32%'
order by password asc;

select date1 as "��¥", time1 as �ð�,team1 as �� ,team2 as "��� ��"
from schedule
where team1 = '��ȭ'
or team2 = '�Ե�'
and date1 <= 09.03
order by date1 desc;


select name as "�̸�", max(password) as "��� ��ȣ", 
min(tel)as "��ȭ ��ȣ"
from manager
group by name,tel,password
having max(password) >= 0861
order by name desc;

select max(time1) as "�ð�", count(date1) as "��¥",
team1 as "��", team2 as "�����",date1  as "��¥"
from schedule
group by team1, team2,date1
having team1 = '�Ե�'
order by date1 desc;

--join �ڵ�

select  s.date1 as "��¥", s.team1  as "��", s.team2  as "��� ��" 
,s.time1  as "�ð�", 
t.tel  as "��ȭ ��ȣ",t.home as "������"
from team t join schedule s
on t.tname = s.team2
where s.place = '���'
and s.team1 <> '��ȭ'
or s.date1 like '%02%'
order by s.date1 asc;

select  s.date1 as "��¥", s.team1 
as "��", s.team2  as "��� ��",s.time1 as "�ð�"
,t.tel, t.home, m.mnumber, m.password
from team t, schedule s, manager m
where t.tname = s.team1
and s.date1 = 09.03
and m.mnumber between 3222 and 3444
and m.password not in(0611,0420,0901)
order by time1 desc;

select  e.team1 as "��", e.dnumber as "���� ��ȣ",e.date1 as "��� �� ����",
t.team2 as "��� ��", t.dnumber as "��� �� ���� ��ȣ", t.date1 as "��� �� ����"
from schedule e join schedule t
on e.team1 = t.team2
or t.dnumber >= 5555
and e.dnumber  like '%111%'
and e.team2 = '��ȭ' 
order by e.dnumber desc;

select  e.team1 as "��", e.dnumber as "���� ��ȣ" ,e.date1 as "�� ����",
t.team2 as "��� ��", t.dnumber as "��� �� ���� ��ȣ" ,e.date1 as "��� �� ����"
from schedule e , schedule t
where e.team1 = t.team2
and e.dnumber  <> 5555
and t.team2 = '�λ�'
order by e.dnumber desc;

--Sub Query ? �⺻ 3��

select  team1, team2,date1, time1
from schedule
where team1 in (select team1
from schedule
where team1 = '�Ｚ')
and team1 < some (select team1
from schedule
where date1 not like '%04%')
and team1  <> any (select team2
from schedule
where team2 = '��ȭ')
order by team1 desc;

select tname as "�̸�", tel as "��ȭ ��ȣ", home as "������"
from team 
group by tname, tel, home
having tname  < all (select tname
from team
where tnumber >= 1777)
and tname >= some( select tname
from team
where tname <> 'NC')
and tname in (select tname
from team
where home  like '%���%')
order by tname asc;

select tel as "��ȭ ��ȣ", password as "��� ��ȣ", name as "�̸�"
from manager
group by tel, password, name
having  name >= all (select name
from manager
where substr(mnumber,1,1) = '3'
and password not between 0611 and  0901
and mnumber in (3111, 3444, 3999));


