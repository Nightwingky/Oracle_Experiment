-- *******************************************
-- * SQL查询语句复习，用示例用户Scott/tiger登录 *
-- *******************************************

-- 01 列出至少有一个雇员的所有部门
select Unique D.DNAME
from DEPT D, EMP E
where D.DEPTNO = E.DEPTNO;


-- 02 列出薪金比'SMITH'多的所有雇员
select a.ENAME
from EMP a ,EMP b
where a.SAL > b.SAL
and b.ENAME = 'SMITH' ;


-- 03 列出所有雇员的姓名及其直接上级的姓名
select a.ENAME,b.ENAME
from EMP a , EMP b
where a.MGR = b.EMPNO ;


-- 04 列出入职日期早于其直接上级的所有雇员
select a.ENAME
from EMP a,EMP b
where a.MGR = b.EMPNO
and a.HIREDATE < b.HIREDATE;


-- 05 列出部门名称和这些部门的雇员,同时列出那些没有雇员的部门
select a.DNAME, b.ENAME
from DEPT a left outer join EMP b
on b.DEPTNO = a.DEPTNO;


-- 06 列出所有“CLERK”（办事员）的姓名及其部门名称
select a.ENAME , b.DNAME
from EMP a ,DEPT b
where a.JOB = 'CLERK'
and a.DEPTNO = b.DEPTNO;


-- 07 列出各种工作类别的最低薪金，显示最低薪金大于1500的记录
select a.JOB,min(a.SAL)
from EMP a
where a.SAL > 1500
group by a.JOB;


-- 08 列出从事“SALES”（销售）工作的雇员的姓名，假定不知道销售部的部门编号
select ENAME
from EMP a
where a.DEPTNO not in (1,2,3,10,20,40);


-- 09 列出薪金高于公司平均水平的所有雇员
select ENAME
from EMP a
where a.SAL > (select avg(SAL) from EMP);


-- 10 列出与“SCOTT”从事相同工作的所有雇员
select a.ENAME
from EMP a,EMP b
where b.ENAME = 'SCOTT'
and a.JOB = b.JOB
and a.ENAME is not 'SCOTT'


--11 列出某些雇员的姓名和薪金，条件是他们的薪金等于部门30中任何一个雇员的薪金
select a.ENAME,a.SAL
from EMP a
where a.SAL > any(select b.SAL from EMP b where b.DEPTNO = 30);


--12 列出某些雇员的姓名和薪金，条件是他们的薪金高于部门30中所有雇员的薪金
select a.ENAME,a.SAL
from EMP a
where a.SAL > all(select b.SAL from EMP b where b.DEPTNO = 30);


--13 列出每个部门的信息以及该部门中雇员的数量
select b.DNAME,count(a.EMPNO)
from EMP a left outer join DEPT b
on a.DEPTNO = b.DEPTNO
group by b.DNAME;


--14 列出所有雇员的雇员名称、部门名称和薪金
select a.ENAME,b.DNAME,a.SAL
from EMP a,DEPT b
where a.DEPTNO = b.DEPTNO;


--15 列出从事同一种工作但属于不同部门的雇员的不同组合
select a.ENAME,b.ENAME
from EMP a,EMP b
where a.DEPTNO != b.DEPTNO
and a.EMPNO != b.EMPNO
and a.JOB = b.JOB


--16 列出分配有雇员数量的所有部门的详细信息，即使是分配有0个雇员
-- select
-- from

--17 列出各种类别工作的最低工资
select a.JOB,min(a.SAL)
from EMP a
group by a.JOB;


--18 列出各个部门的MANAGER（经理）的最低薪金
select b.DNAME,min(a.SAL)
from EMP a,DEPT b
where a.JOB = 'MANAGER'
and a.DEPTNO = b.DEPTNO
group by a.DEPTNO,b.DNAME;


--19、列出按年薪排序的所有雇员的年薪
select a.ENAME,a.SAL
from EMP a
order by a.SAL desc

--20、列出薪金水平处于第四位的雇员
-- select ENAME,SAL
-- from (select a.ENAME,a.SAL
-- from EMP a
-- where ROWNUM < 5
-- order by a.SAL desc
-- )
-- where ROWNUM < 2
-- order by SAL desc ;