select * FROM dictionary;

SELECT ceil(10.6) from dual;

SELECT floor(10.6) from dual;

SELECT mod(7,5) from dual;

SELECT power(3,2) from dual;

SELECT round(1234.5678,2) from dual;

SELECT sign(12) from dual;

SELECT sqrt(25) from dual;

SELECT initcap('nightwingky drake') from dual;

SELECT lower('Mr.NightwingKY') from dual;

SELECT replace('Hello World','Hello','qky140614406') from dual;

SELECT substr('ABCDEF',2,1) from dual;

SELECT length('Anderson') from dual;

SELECT avg(sal) from emp;

SELECT count(*) from emp;

SELECT max(sal) from emp;

SELECT min(sal) from emp;

alter session set NLS_DATE_LANGUAGE = American;

SELECT sysdate from dual;

SELECT last_day(sysdate) from dual;

SELECT add_months(sysdate,2) from dual;

SELECT months_between(sysdate,to_date('12-12-2016','dd-mm-yyyy')) from dual;

SELECT next_day(sysdate,'MONDAY') from dual;

SELECT to_char(sysdate,'YYY') from dual;

SELECT to_char(sysdate,'SYEAR') from dual;

SELECT to_char(sysdate,'Q') from dual;

SELECT to_char(sysdate,'MM') from dual;

SELECT to_char(sysdate,'RM') from dual;

SELECT to_char(sysdate,'Month') from dual;

SELECT to_char(sysdate,'WW') from dual;

SELECT to_char(sysdate,'W') from dual;

SELECT to_char(sysdate,'DDD') from dual;

SELECT to_char(sysdate,'DD') from dual;

SELECT to_char(sysdate,'D') from dual;

SELECT to_char(sysdate,'DY') from dual;

SELECT to_char(sysdate,'HH') from dual;

SELECT to_char(sysdate,'HH24') from dual;

SELECT to_char(sysdate,'MI') from dual;

SELECT to_char(sysdate,'SS') from dual;