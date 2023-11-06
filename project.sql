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
values (1000, '010-3037-9093', 'NC', '창원');

insert into Team
values (1111, '010-2929-9093', 'LG','서울 잠실');

insert into Team
values (1222, '010-2030-1643', 'SK','경기 인천');

insert into Team
values (1333, '02-8080-0332', 'KT','경기 수원');

insert into Team
values (1444, '02-3636-8993', 'KIA','전남광주');

insert into Team
values (1555, '02-1232-2131', '두산','서울 잠실');

insert into Team
values (1666, '070-3203-3222', '키움','서울 고척');

insert into Team
values (1777, '070-9988-3222', '삼성','대구');

insert into Team
values (1888, '070-9243-3222', '한화','대전');

insert into Team
values (1999, '070-3932-3222', '롯데','부산');


insert into manager
values (3222, '010-9032-3243', '0611','서민(롯데)');

insert into manager
values (3111, '010-3232-9099', '0420','유승민(LG)');

insert into manager
values (3333, '010-3202-9093', '0901','심상정(한화)');

insert into manager
values (3444, '010-3090-1098', '0861','박재욱(두산)');

insert into manager
values (3555, '010-3569-9096', '0884','김강현(SK)');

insert into manager
values (3666, '010-2319-8132', '0794','허봉식(삼성)');

insert into manager
values (3777, '010-1025-8123', '0670','김경민(NC)');

insert into manager
values (3888, '010-4321-0053', '0151','김진숙(키움)');

insert into manager
values (3999, '010-1338-1132', '0815','김재현(KT)');

insert into manager
values (3100, '010-1412-1013', '0703','이현주(KIA)');

insert into schedule
values ( 5111,'한화', '두산','09.01','서울','18:30');

insert into schedule
values (5222, 'LG','SK','09.01','문학','18:30');

insert into schedule
values ( 5333,'롯데','KT','09.01','수원','18:30');

insert into schedule
values (5444, 'NC','키움','09.01','고척','18:30');

insert into schedule
values ( 5555,'삼성','KIA','09.01','광주','18:30');

insert into schedule
values (5666, '한화','두산','09.02','잠실','18:30');

insert into schedule
values (5777, 'LG','SK','09.02','문학','18:30');

insert into schedule
values (5888, '롯데','KT','09.02','수원','18:30');

insert into schedule
values (5999, 'NC','키움','09.02','고척','18:30');

insert into schedule
values (6000, '삼성','KIA','09.02','광주','18:30');

insert into schedule
values (6111, 'KIA','롯데','09.03','사직','18:30');

insert into schedule
values (6222, 'NC','LG','09.03','잠실','18:30');

insert into schedule
values (6333, '두산','삼성','09.03','대구','18:30');

insert into schedule
values (6444, 'SK','KT','09.03','수원','18:30');

insert into schedule
values (6555, '키움','한화','09.03','대전','18:30');

insert into schedule
values (6666, 'KIA','롯데','09.04','사직','15:00');

insert into schedule
values (6777, 'SK','KT','09.04','수원','15:00');

insert into schedule
values (6888, 'NC','LG','09.04','잠실','18:30');

insert into schedule
values (6999, '두산','삼성','09.04','대구','18:30');

insert into schedule
values (7000, 'SK','KT','09.04','수원','18:30');

insert into schedule
values (7111, '키움','한화','09.04','대전','18:30');

insert into schedule
values (7222, 'KIA','롯데','09.04','사직','18:54');

-- 코드 

select name as 이름, tel as "전화 번호", password as "비밀 번호", mnumber as "관리자 번호"
from manager
where substr(mnumber,1,2) = '36'
or mnumber  in (3333,3555,3888) 
and tel not like '_1412_' 
order by name desc ;

select name  as 이름, tel as "전화 번호", password  as "비밀 번호" 
from manager
where  password not between 0670 and 0794
and name not like '%김%'
or tel like '%32%'
order by password asc;

select date1 as "날짜", time1 as 시간,team1 as 팀 ,team2 as "상대 팀"
from schedule
where team1 = '한화'
or team2 = '롯데'
and date1 <= 09.03
order by date1 desc;


select name as "이름", max(password) as "비밀 번호", 
min(tel)as "전화 번호"
from manager
group by name,tel,password
having max(password) >= 0861
order by name desc;

select max(time1) as "시간", count(date1) as "날짜",
team1 as "팀", team2 as "상대팀",date1  as "날짜"
from schedule
group by team1, team2,date1
having team1 = '롯데'
order by date1 desc;

--join 코드

select  s.date1 as "날짜", s.team1  as "팀", s.team2  as "상대 팀" 
,s.time1  as "시간", 
t.tel  as "전화 번호",t.home as "연고지"
from team t join schedule s
on t.tname = s.team2
where s.place = '잠실'
and s.team1 <> '한화'
or s.date1 like '%02%'
order by s.date1 asc;

select  s.date1 as "날짜", s.team1 
as "팀", s.team2  as "상대 팀",s.time1 as "시간"
,t.tel, t.home, m.mnumber, m.password
from team t, schedule s, manager m
where t.tname = s.team1
and s.date1 = 09.03
and m.mnumber between 3222 and 3444
and m.password not in(0611,0420,0901)
order by time1 desc;

select  e.team1 as "팀", e.dnumber as "일정 번호",e.date1 as "상대 팀 일정",
t.team2 as "상대 팀", t.dnumber as "상대 팀 일정 번호", t.date1 as "상대 팀 일정"
from schedule e join schedule t
on e.team1 = t.team2
or t.dnumber >= 5555
and e.dnumber  like '%111%'
and e.team2 = '한화' 
order by e.dnumber desc;

select  e.team1 as "팀", e.dnumber as "일정 번호" ,e.date1 as "팀 일정",
t.team2 as "상대 팀", t.dnumber as "상대 팀 일정 번호" ,e.date1 as "상대 팀 일정"
from schedule e , schedule t
where e.team1 = t.team2
and e.dnumber  <> 5555
and t.team2 = '두산'
order by e.dnumber desc;

--Sub Query ? 기본 3개

select  team1, team2,date1, time1
from schedule
where team1 in (select team1
from schedule
where team1 = '삼성')
and team1 < some (select team1
from schedule
where date1 not like '%04%')
and team1  <> any (select team2
from schedule
where team2 = '한화')
order by team1 desc;

select tname as "이름", tel as "전화 번호", home as "연고지"
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
where home  like '%경기%')
order by tname asc;

select tel as "전화 번호", password as "비밀 번호", name as "이름"
from manager
group by tel, password, name
having  name >= all (select name
from manager
where substr(mnumber,1,1) = '3'
and password not between 0611 and  0901
and mnumber in (3111, 3444, 3999));


