select e.ename, d.dno, d.dname
from employee e ,department d
where e.dno = d.dno
and e.ename = 'SCOTT';

select e.ename, d.dname, d.loc
from employee e join department d
on e.dno = d.dno; 

select d.dno, e.job, d.loc
from employee e inner join department d
using(dno)
where d.dno = 10;

select e.ename, d.dname, d.loc
from employee e natural join department d
where e.commission > 0;

select e.ename, d.dname
from employee e, department d
where e.dno = d.dno
and e.ename like '%A%';

select ename, job, dno, dname
from employee  natural join department 
where dno = dno
and LOC = 'NEW YORK';

select e.ename as "Employee",
e.eno as "Emp#",d.eno as "Manager",
d.ename as "Mgr#"
from employee e , employee d
where e.manager = d.eno;

select e.ename as "Employee", e.eno as "Emp#",
d.eno as "Manager", d.ename as "Mgr#"
from employee e, employee d
where e.manager = d.eno
order by e.eno desc;

select e.ename as 이름, e.dno as 부서번호, d.Manager as 동료
from employee e, employee d
where e.dno = d.dno
and e.ename = 'SCOTT'
and d.ename != 'SCOTT';

select e.ename, d.hiredate 
from employee e , employee d
where d.hiredate >e.hiredate 
and e.ename = 'WARD'
order by hiredate;

select e.ename, e.hiredate, d.ename, d. hiredate
from employee e, employee d
where e.manager = d.eno
and e.hiredate <= d.hiredate;