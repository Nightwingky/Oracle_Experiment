-----------------
-- 添加/修改数据--
-----------------

--a. 添加电影的标题到 TITLE 表中。写一个脚本输入电影信息。
--用序列来唯一地标识每一个标题。以 yyyy-mm-dd 格式输入发行日期

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Willie and Christmas Too','All of Willies friends make a Christmas list for Santa, but Willie has yet to add his own wish list.','G','CHILD',TO_DATE('1995-10-05','yyyy-mm-dd'));

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Alien Again','Yet another installation of science fiction history. Can the heroine save the planet from the alien life form?','G','CHILD',TO_DATE('1995-10-05','yyyy-mm-dd'));

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'The Glob','A meteor crashes near a small American town and unleashes carnivorous goo in this classic.','NR','SCIFI',TO_DATE('1995-08-12','yyyy-mm-dd'));

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'My Day Off ','With a little luck and a lot of ingenuity, a teenager skips school for a day in New York','PG','COMEDY',TO_DATE('1995-07-12','yyyy-mm-dd'));

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Miracles on Ice','A six-year-old has doubts about Santa Claus, but she discovers that miracles really do exist.','PG','DRAMA',TO_DATE('1995-09-15','yyyy-mm-dd'));

insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Soda Gang','After discovering a cache of drugs, a young couple find themselves pitted against a vicious gang.','NR','ACTION',TO_DATE('1995-06-01','yyyy-mm-dd'));

--验证你的添加。
select * from TITLE;

-- b. 添加数据到 MEMBER 表中。确保使用序列添加成员号。

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Carmen','Velasquez','283 King Street','Seattle','206-899-6666',TO_DATE('1990-03-08','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'LaDoris','Ngao','5 Modrany','Bratislava','586-355-8882',TO_DATE('1991-03-08','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Midori','Nagayama','68 Via Centrale','Sao Paolo','254-852-5764',TO_DATE('1991-07-17','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Mark','Quick-to-See','6921 King Way','Lagos','63-559-7777',TO_DATE('1990-04-07','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Audry','Ropeburn','86 Chu Street','Hong Kong','41-559-87',TO_DATE('1991-01-18','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Molly','Urguhart','3035 Laurier','Quebec','418-542-9988',TO_DATE('1991-01-18','yyyy-mm-dd'));

--验证你的添加。
select * from MEMBER;

-- c. 添加下面的电影拷贝到 TITLE_COPY 表中： 注：对于该练习有可用的 TITLE_ID 号。

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','93','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','94','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('2','94','RENTED');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','95','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','96','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('2','96','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('3','96','RENTED');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','97','AVAILABLE');

insert into  TITLE_COPY(COPY_ID,TITLE_ID,STATUS)
values('1','98','AVAILABLE');

select * from TITLE_COPY;

-- d. 添加下面的租用到 RENTAL 表中： 注：标题号依赖于序列号，它们可能是不同的。

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(93,1,102,SYSDATE-3,SYSDATE-1,SYSDATE-2);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(94,2,102,SYSDATE-1,SYSDATE+1,NULL);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(96,3,103,SYSDATE-2,SYSDATE,NULL);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(98,1,105,SYSDATE-4,SYSDATE-2,SYSDATE-2);

select * from RENTAL;

-- 5. 创建一个名为 TITLE_AVAIL 的视图，显示电影标题和每个拷贝的可用性，以及，如果已租出它的预期归还日期。从视图中查询所有行，用标题排序。注：结果可能不同。

CREATE VIEW TITLE_AVAIL AS
SELECT T.TITLE,C.COPY_ID,C.STATUS,R.EXP_RET_DATE
FROM TITLE T,TITLE_COPY C,RENTAL R
WHERE T.TITLE_ID = C.TITLE_ID
AND C.COPY_ID = R.COPY_ID(+)
AND C.TITLE_ID = R.TITLE_ID(+);
-- (+)表示外连接，并且总是放在非主表的一方。

-- 验证view可用性
SELECT * FROM TITLE_AVAIL ORDER BY TITLE,COPY_ID;

-- 6. 改变表中的数据。
-- a. 添加一个新title，电影是 “Interstellar Wars” ,等级为 PG，分类为科幻，发行日期07-JUL-77。简介为 “Futuristic interstellar action movie. Can the rebels save the humans from the evil empire?”，为两个拷贝分别添加一个标题拷贝表 (title_copy) 记录。

-- add new movie
insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Interstellar Wars','Futuristic interstellar action movie. Can the rebels save the humans from the evil empire?','PG','SCIFI',TO_DATE('1977-07-07','yyyy-mm-dd'));

SELECT * FROM TITLE;


-- add new movie copy
INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS)VALUES(
1,99,'AVAILABLE');
INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS)VALUES(
2,99,'AVAILABLE');
SELECT * FROM TITLE_COPY;

-- b. 客户 Carmen Velasquez 102 租了电影 “Interstellar Wars” 拷贝 1，从该电影的预定中删除她，在出租表中记录有关信息，允许使用预计归还日期的默认值，用你创建的视图验证出租一被记录在表中。

-- reservate video
INSERT INTO RESERVATION(RES_DATE,MEMBER_ID,TITLE_ID)
VALUES(SYSDATE,102,99);

-- Delete booking record and rental it.
delete from RESERVATION where MEMBER_ID = 102 and TITLE_ID = 99;
insert into RENTAL(BOOK_DATE,MEMBER_ID,COPY_ID,ACT_RET_DATE,TITLE_ID)
values(SYSDATE,102,1,SYSDATE+2,99);

-- verify my newly inserted record
SELECT TITLE ,COPY_ID ,STATUS FROM TITLE_AVAIL where TITLE = 'Interstellar Wars' ORDER BY TITLE,COPY_ID;

-- 7. 修改表结构。
-- a. 添加一个 PRICE 列到 TITLE 表中，记录视频的购买价格。该列应该有8位数字长度和两位小数。验证你的修改。

alter table TITLE add PRICE NUMBER(8,2);

-- b. 创建一个名为 Title_姓名首字母_学号后三位_1.sql 的脚本，按照下面的列表，写更新语句，更新包含价格的每个视频的记录。运行脚本中的命令。注：对于本练习有可用的 TITLE_ID 号。

select * from title;

update TITLE set PRICE = 25 where TITLE_ID = 93;
update TITLE set PRICE = 35 where TITLE_ID = 94;
update TITLE set PRICE = 35 where TITLE_ID = 95;
update TITLE set PRICE = 35 where TITLE_ID = 96;
update TITLE set PRICE = 30 where TITLE_ID = 97;
update TITLE set PRICE = 35 where TITLE_ID = 98;
update TITLE set PRICE = 29 where TITLE_ID = 99;

-- c. 确认在以后所有 titles 表中的记录都包含价格值，验证该约束。

alter table TITLE modify PRICE constraint price_not_null not null;

select object_name from user_objects where object_name = 'PRICE_NOT_NULL';


-- 8. 创建一个sql，生产如下数据的列表：包含每一个客户租视频的历史。报表包括名字、租用的视频、租用的日期，在一个报告期中所有客户租用的总数。

-- create a new view called RENTAL_RECORD
CREATE VIEW RENTAL_RECORD AS
SELECT M.FIRST_NAME ,M.LAST_NAME,T.TITLE,R.BOOK_DATE
FROM TITLE T,RENTAL R,MEMBER M
WHERE T.TITLE_ID = R.TITLE_ID
AND M.MEMBER_ID = R.MEMBER_ID;

select * from RENTAL_RECORD;