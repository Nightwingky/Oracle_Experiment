SELECT * FROM BONUS;
SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 01 列出至少有一个雇员的所有部门
SELECT UNIQUE D.DNAME FROM DEPT D, EMP E WHERE D.DEPTNO = E.DEPTNO;

-- 02 列出薪金比'SMITH'多的所有雇员
SELECT a.ENAME FROM EMP a,EMP b WHERE a.SAL > b.SAL AND b.ENAME = 'SMITH';

-- 03 列出所有雇员的姓名及其直接上级的姓名
SELECT a.ENAME, b.ENAME FROM EMP a,EMP b WHERE a.MGR = b.EMPNO;

-- 04 列出入职日期早于其直接上级的所有雇员
SELECT a.ENAME FROM EMP a,EMP b WHERE a.MGR = b.EMPNO AND a.HIREDATE < b.HIREDATE;

-- 05 列出部门名称和这些部门的雇员,同时列出那些没有雇员的部门
SELECT a.DNAME, b.ENAME FROM DEPT a LEFT OUTER JOIN EMP b ON b.DEPTNO = a.DEPTNO;

-- 06 列出所有“CLERK”（办事员）的姓名及其部门名称
SELECT a.ENAME , b.DNAME FROM EMP a ,DEPT b WHERE a.JOB = 'CLERK' AND a.DEPTNO = b.DEPTNO;

-- 07 列出各种工作类别的最低薪金，显示最低薪金大于1500的记录
SELECT a.JOB,min(a.SAL) FROM EMP a WHERE a.SAL > 1500 GROUP BY a.JOB;

-- 08 列出从事“SALES”（销售）工作的雇员的姓名，假定不知道销售部的部门编号
SELECT ENAME FROM EMP a WHERE a.DEPTNO NOT IN (1, 2, 3, 10, 20, 40);

-- 09 列出薪金高于公司平均水平的所有雇员
SELECT ENAME FROM EMP a WHERE a.SAL > (select avg(SAL) from EMP);

-- 10 列出与“SCOTT”从事相同工作的所有雇员
SELECT a.ENAME FROM EMP a,EMP b WHERE b.ENAME = 'SCOTT' AND a.JOB = b.JOB AND a.ENAME != 'SCOTT';

--11 列出某些雇员的姓名和薪金，条件是他们的薪金等于部门30中任何一个雇员的薪金
SELECT a.ENAME,a.SAL FROM EMP a WHERE a.SAL > ANY (
  SELECT b.SAL FROM EMP b WHERE b.DEPTNO = 30
);

--12 列出某些雇员的姓名和薪金，条件是他们的薪金高于部门30中所有雇员的薪金
SELECT a.ENAME,a.SAL FROM EMP a WHERE a.SAL > ALL (
  SELECT b.SAL FROM EMP b WHERE b.DEPTNO = 30
);

--13 列出每个部门的信息以及该部门中雇员的数量
--TODO:Error 表或视图不存在
SELECT b.DNAME,COUNT(a.EMPNO) FROM EMP a LEFT OUTER JOIN b ON a.DEPTNO = b.DEPTNO GROUP BY b.DNAME;

--14 列出所有雇员的雇员名称、部门名称和薪金
SELECT a.ENAME,b.DNAME,a.SAL FROM EMP a,DEPT b WHERE a.DEPTNO = b.DEPTNO;

--15 列出从事同一种工作但属于不同部门的雇员的不同组合
SELECT a.ENAME,b.ENAME FROM EMP a,EMP b WHERE a.DEPTNO != b.DEPTNO AND a.EMPNO != b.EMPNO AND a.JOB = b.JOB;

--16 列出分配有雇员数量的所有部门的详细信息，即使是分配有0个雇员
--TODO

--17 列出各种类别工作的最低工资
SELECT a.JOB,MIN(a.SAL) FROM EMP a GROUP BY a.JOB;

--18 列出各个部门的MANAGER（经理）的最低薪金
SELECT b.DNAME,MIN(a.SAL) FROM EMP a,DEPT b WHERE a.JOB = 'MANAGER' AND a.DEPTNO = b.DEPTNO GROUP BY a.DEPTNO,b.DNAME;

--19、列出按年薪排序的所有雇员的年薪
SELECT a.ENAME,a.SAL FROM EMP a ORDER BY a.SAL DESC;


