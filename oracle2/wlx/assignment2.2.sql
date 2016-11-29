-- *******************************************
-- *********** DDL DML DCL 实验***************
-- *******************************************

-- create user
create user WLX303 IDENTIFIED by WLX303
TEMPORARY TABLESPACE TEMP
DEFAULT TABLESPACE USERS;

-- grant
grant connect, resource ,create view,create procedure to WLX303;

-- switch user and check new user
conn WLX303/WLX303;

-- alter pwd
alter USER WLX303 IDENTIFIED BY WLX303

select * from user_users;

-------------------------
-- create MEMBER table --
-------------------------
create table MEMBER (
    -- MEMBER_ID
    MEMBER_ID  NUMBER(10),
    constraint member_pk primary key (MEMBER_ID),
    -- LAST_NAME
    LAST_NAME VARCHAR2(25) not null,
    constraint last_name_unique unique (LAST_NAME),
    -- FIRST_NAME
    FIRST_NAME VARCHAR2(25) not null,
    constraint first_name_unique unique (FIRST_NAME),
    -- ADDRESS
    ADDRESS VARCHAR2(100) not null,
    -- CITY
    CITY VARCHAR2(30) not null,
    -- PHONE
    PHONE VARCHAR2(15) not null,
    -- JOIN_DATE
    JOIN_DATE DATE  default SYSDATE
);
-- check whether current table is created successfully.
describe MEMBER;
select table_name from user_tables where table_name = 'MEMBER';


------------------------
-- create TITLE table --
------------------------
create table TITLE(
    -- TITLE_ID
    TITLE_ID NUMBER(10),
    constraint title_pk primary key (TITLE_ID),
    -- TITLE
    TITLE VARCHAR2(60) not null,
    constraint title_unique unique (TITLE),
    -- DESCRIPTION
    DESCRIPTION VARCHAR2(400) not null,
    -- RATING
    RATING VARCHAR2(4),
    constraint rating_range CHECK (RATING IN ('G','PG','R','NC17','NR')),
    -- CATEGORY
    CATEGORY VARCHAR2(20),
    constraint category_range CHECK (CATEGORY IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY')),
    -- RELEASE_DATE
    RELEASE_DATE DATE not null
);
-- check whether current table is created successfully.
describe TITLE;
select table_name from user_tables where table_name = 'TITLE';



-----------------------------
-- create TITLE_COPY table --
-----------------------------
create table TITLE_COPY (
    -- COPY_ID
    COPY_ID NUMBER(10) not null,
    constraint title_copy_pk primary key (COPY_ID,TITLE_ID),
    -- TITLE_ID
    TITLE_ID NUMBER(10) constraint title_copy_fk references TITLE(TITLE_ID),
    -- STATUS
    STATUS VARCHAR2(15) not null,
    constraint status_not_null check (STATUS IN ('AVAILABLE','DESTROYED','RENTED','RESERVED'))
);
-- check whether current table is created successfully.
describe TITLE_COPY;
select table_name from user_tables where table_name = 'TITLE_COPY';



-------------------------
-- create RENTAL table --
-------------------------
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
-- check whether current table is created successfully.
DESCRIBE RENTAL;
select table_name from user_tables where table_name = 'RENTAL';



------------------------------
-- create RESERVATION table --
------------------------------
CREATE TABLE RESERVATION(
  RES_DATE DATE,
  MEMBER_ID NUMBER(10) constraint reservation_member_fk references MEMBER(MEMBER_ID),
  TITLE_ID NUMBER(10) constraint reservation_title_fk references TITLE(TITLE_ID),
  constraint reservation_pk primary key (RES_DATE,MEMBER_ID,TITLE_ID)
);
-- check whether current table is created successfully.
DESCRIBE RESERVATION;
select table_name from user_tables where table_name = 'RESERVATION';


-- drop table
DROP TABLE TABLE_NAME PURGE;

-- 检查数据字典验证表和约束已被完全创建
select * from dictionary;
select table_name from user_tables;
select object_name from user_objects;

-- 创建序列来唯一地标识在 MEMBER 表和 TITLE 表中的每一个行。

----------------------------------
-- create sequence MEMBER_ID_SEQ--
----------------------------------
create sequence MEMBER_ID_SEQ
start with 101
increment by 1
nomaxvalue
nocache;

---------------------------------
-- create sequence TITLE_ID_SEQ--
---------------------------------
create sequence TITLE_ID_SEQ
start with 92
increment by 1
nomaxvalue
nocache;

-- c. 验证在数据字典中已经存在的序列。
select OBJECT_NAME from user_objects where object_type = 'SEQUENCE';