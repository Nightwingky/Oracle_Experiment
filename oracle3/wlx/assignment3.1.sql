------------------------
-- Numerical Function --
------------------------

-- 1.Ceil(n) 大于等于数值n的最小整数
select ceil(10.6) from dual;

-- 2.Floor(n) 小于等于数值n的最大整数
select floor(10.6) from dual;

-- 3.Mod(m,n) M除以n的余数，若n=0，则返回m
select mod(7,5) from dual;

-- 4.Power(m,n)	M的n次方
select power(3,2) from dual;

-- 5.Round(n,m)	将n四舍五入，保留小数点后m位
select round(1234.5678,2) from dual;

-- 6.Sign(n) 若n=0，返回0；否则n>0，返回1;n<0,返回-1
select sign(12) from dual;

-- 7.Sqrt(n) N的平方根
select sqrt(25) from dual;

------------------------
-- Character Function --
------------------------

-- 1.Initcap(char) 把每个字符串的第一个字符换成大写
Select initcap('mr.wanglingxiao') from dual;

-- 2.Lower(char) 整个字符串换成小写
Select lower('Mr.Lance Wang') from dual;

-- 3.Replace(char,str1,str2) 字符串中所有str1换成str2
Select replace('Hello World','Hello','Fuck') from dual;

-- 4.Soundex(char) 字符串的语音表示，常用于名字的模糊查询，可查找发音相似拼写不同的字符串
Select ename from emp where SOUNDEX(ename)=soundex('SMYTHE');

-- 5.Substr(char,m,n) 取出从m字符开始的n个字符的子串
Select substr('ABCDEF',2,1) from dual;

-- 6.Length(char) 求字符串的长度
Select length('Anderson') from dual;

-----------------------
-- grouping Function --
-----------------------

-- 1.avg(column_name) Column_name表的所有值的平均值
Select avg(sal) from emp;

-- 2.Count(*) 表中的数据行数目
Select count(*) from emp;

-- 3.Max(column_name) 存max(column放在column_name表列中的最大值
Select max(sal) from emp;

-- 4.min(column_name) 存放在column_name表中的最小值
Select min(sal) from emp;

-------------------
-- Date Function --
-------------------

-- 必须运行本行代码，否则以下的英文月份和日期拼写无法被识别。
alter session set NLS_DATE_LANGUAGE = American;

-- 1.Sysdate 当前日期和时间
Select sysdate from dual;

-- 2.Last_day 本月最后一天
Select last_day(sysdate) from dual;

-- 3.Add_months(d,n) 当前日期d后推n个月
Select add_months(sysdate,2) from dual;

-- 4.Months_between(f,s) 日期f和s间相差月数
Select months_between(sysdate,to_date('12-06-2016','dd-mm-yyyy')) from dual;

-- 5.Next_day(d,day) d后第一周指定的day日期
Select next_day(sysdate,'MONDAY') from dual;


--------------------------
-- Date Format Function --
--------------------------

-- 01.Y或YY或YYY 年的最后一位，两位或三位
Select to_char(sysdate,'YYY') from dual;

-- 02.SYEAR或YEAR 年，SYEAR使公元前的年份前加一负号
Select to_char(sysdate,'SYEAR') from dual;

-- 03.Q	季度，1到3月为第一季度
Select to_char(sysdate,'Q') from dual;

-- 04.MM 月份数
Select to_char(sysdate,'MM') from dual;

-- 05.RM 月份的罗马表示
Select to_char(sysdate,'RM') from dual;

-- 06.Month 用9个字符长度表示的月份名
Select to_char(sysdate,'Month') from dual;

-- 07.WW 当年第几周
Select to_char(sysdate,'WW') from dual;

-- 08.W 本月第几周
Select to_char(sysdate,'W') from dual;

-- 09.DDD 当年第几天，1月1日为001，2月1日为032
Select to_char(sysdate,'DDD') from dual;

-- 10.DD 当月第几天
Select to_char(sysdate,'DD') from dual;

-- 11.D 周内第几天
Select to_char(sysdate,'D') from dual;

-- 12.DY 周内第几天缩写
Select to_char(sysdate,'DY') from dual;

-- 13.HH或HH12 12进制小时数
Select to_char(sysdate,'HH') from dual;

-- 14.HH24 24小时制
Select to_char(sysdate,'HH24') from dual;

-- 15.MI 分钟数（0-59）
Select to_char(sysdate,'MI') from dual;

-- 16.SS 秒数（0-59）
Select to_char(sysdate,'SS') from dual;