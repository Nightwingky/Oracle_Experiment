--创建表

create table MEMBER (
    MEMBER_ID  NUMBER(10),
    constraint member_pk primary key (MEMBER_ID),
    LAST_NAME VARCHAR2(25) not null,
    constraint last_name_unique unique (LAST_NAME),
    FIRST_NAME VARCHAR2(25) not null,
    constraint first_name_unique unique (FIRST_NAME),
    ADDRESS VARCHAR2(100) not null,
    CITY VARCHAR2(30) not null,
    PHONE VARCHAR2(15) not null,
    JOIN_DATE DATE  default SYSDATE
);
select table_name from user_tables where table_name = 'MEMBER';

create table TITLE(
    TITLE_ID NUMBER(10),
    constraint title_pk primary key (TITLE_ID),
    TITLE VARCHAR2(60) not null,
    constraint title_unique unique (TITLE),
    DESCRIPTION VARCHAR2(400) not null,
    RATING VARCHAR2(4),
    constraint rating_range CHECK (RATING IN ('G','PG','R','NC17','NR')),
    CATEGORY VARCHAR2(20),
    constraint category_range CHECK (CATEGORY IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY')),
    RELEASE_DATE DATE not null
);
select table_name from user_tables where table_name = 'TITLE';

create table TITLE_COPY (
    COPY_ID NUMBER(10) not null,
    constraint title_copy_pk primary key (COPY_ID,TITLE_ID),
    TITLE_ID NUMBER(10) constraint title_copy_fk references TITLE(TITLE_ID),
    STATUS VARCHAR2(15) not null,
    constraint status_not_null check (STATUS IN ('AVAILABLE','DESTROYED','RENTED','RESERVED'))
);
select table_name from user_tables where table_name = 'TITLE_COPY';

CREATE TABLE RENTAL (
    BOOK_DATE DATE,
    MEMBER_ID NUMBER(10) constraint rental_member_fk references MEMBER(MEMBER_ID),
    COPY_ID NUMBER(10),
    ACT_RET_DATE DATE DEFAULT (SYSDATE),
    EXP_RET_DATE DATE DEFAULT (SYSDATE)+2,
    TITLE_ID NUMBER(10),
    constraint rental_pk primary key (BOOK_DATE,MEMBER_ID,COPY_ID,TITLE_ID),
    constraint rental_copy_fk foreign key (COPY_ID,TITLE_ID) references TITLE_COPY(COPY_ID,TITLE_ID)
);
select table_name from user_tables where table_name = 'RENTAL';

CREATE TABLE RESERVATION(
  RES_DATE DATE,
  MEMBER_ID NUMBER(10) constraint reservation_member_fk references MEMBER(MEMBER_ID),
  TITLE_ID NUMBER(10) constraint reservation_title_fk references TITLE(TITLE_ID),
  constraint reservation_pk primary key (RES_DATE,MEMBER_ID,TITLE_ID)
);
select table_name from user_tables where table_name = 'RESERVATION';

-- 检查数据字典验证表和约束已被完全创建
select * from dictionary;
select table_name from user_tables;
select object_name from user_objects;

-- 创建序列来唯一地标识在 MEMBER 表和 TITLE 表中的每一个行。
create sequence MEMBER_ID_SEQ
start with 101
increment by 1
nomaxvalue
nocache;

create sequence TITLE_ID_SEQ
start with 92
increment by 1
nomaxvalue
nocache;

select OBJECT_NAME from user_objects where object_type = 'SEQUENCE';

--TITLE表
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

select * from TITLE;

--MEMBER表
insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Carmen','Velasquez','283 King Street','Seattle','206-899-6666',TO_DATE('1990-03-08','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'LaDoris','Ngao','5 Modrany','Bratislava','586-355-8882',TO_DATE('1991-03-08','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Midori','Nagayama','68 Via Centrale','Sao Paolo','254-852-5764',TO_DATE('1991-06-17','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Mark','Quick-to-See','6921 King Way','Lagos','63-559-7777',TO_DATE('1990-04-07','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Audry','Ropeburn','86 Chu Street','Hong Kong','41-559-87',TO_DATE('1991-01-18','yyyy-mm-dd'));

insert into MEMBER(MEMBER_ID,FIRST_NAME,LAST_NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
values(MEMBER_ID_SEQ.Nextval,'Molly','Urguhart','3035 Laurier','Quebec','418-542-9988',TO_DATE('1991-01-18','yyyy-mm-dd'));

select * from MEMBER;

--TITLE_COPY表
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

--RENTAL表

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(93,1,102,SYSDATE-3,SYSDATE-1,SYSDATE-2);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(94,2,102,SYSDATE-1,SYSDATE+1,NULL);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(96,3,103,SYSDATE-2,SYSDATE,NULL);

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(98,1,105,SYSDATE-4,SYSDATE-2,SYSDATE-2);

select * from RENTAL;

--TITLE_AVAIL视图。
CREATE VIEW TITLE_AVAIL AS
SELECT T.TITLE,C.COPY_ID,C.STATUS,R.EXP_RET_DATE
FROM TITLE T,TITLE_COPY C,RENTAL R
WHERE T.TITLE_ID = C.TITLE_ID
AND C.COPY_ID = R.COPY_ID(+)
AND C.TITLE_ID = R.TITLE_ID(+);

-- 改变表中的数据。
-- a.
insert into TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
values(TITLE_ID_SEQ.Nextval,'Interstellar Wars','Futuristic interstellar action movie. Can the rebels save the humans from the evil empire?','PG','SCIFI',TO_DATE('1977-07-07','yyyy-mm-dd'));
SELECT * FROM TITLE;

INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS)VALUES(1,99,'AVAILABLE');
INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS)VALUES(2,99,'AVAILABLE');
SELECT * FROM TITLE_COPY;

-- b.
INSERT INTO RESERVATION(RES_DATE,MEMBER_ID,TITLE_ID)
VALUES(SYSDATE,102,99);

delete from RESERVATION where MEMBER_ID = 102 and TITLE_ID = 99;
insert into RENTAL(BOOK_DATE,MEMBER_ID,COPY_ID,ACT_RET_DATE,TITLE_ID)
values(SYSDATE,102,1,SYSDATE+2,99);

SELECT TITLE ,COPY_ID ,STATUS FROM TITLE_AVAIL where TITLE = 'Interstellar Wars' ORDER BY TITLE,COPY_ID;

-- 修改表结构。
-- a.
alter table TITLE add PRICE NUMBER(8,2);

-- b.
select * from title;

update TITLE set PRICE = 25 where TITLE_ID = 93;
update TITLE set PRICE = 35 where TITLE_ID = 94;
update TITLE set PRICE = 35 where TITLE_ID = 95;
update TITLE set PRICE = 35 where TITLE_ID = 96;
update TITLE set PRICE = 30 where TITLE_ID = 97;
update TITLE set PRICE = 35 where TITLE_ID = 98;
update TITLE set PRICE = 29 where TITLE_ID = 99;

-- c.
alter table TITLE modify PRICE constraint price_not_null not null;
select object_name from user_objects where object_name = 'PRICE_NOT_NULL';

--
CREATE VIEW RENTAL_RECORD AS
SELECT M.FIRST_NAME ,M.LAST_NAME,T.TITLE,R.BOOK_DATE
FROM TITLE T,RENTAL R,MEMBER M
WHERE T.TITLE_ID = R.TITLE_ID
AND M.MEMBER_ID = R.MEMBER_ID;

select * from RENTAL_RECORD;