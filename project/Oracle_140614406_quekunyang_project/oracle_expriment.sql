--表title_qky_406
create table title_qky_406(
  title_id number(10) primary key,
  title varchar2(60) not null,
  description varchar2(400) not null unique,
  rating varchar2(4) check(rating in('A','B','C','D','E')),
  category varchar(20) check(category in('DRAMA','COMEDY','ACTION','CHILD','ROMANTIC')),
  release_date date
);

--表title_copy_qky_406
create table title_copy_qky_406(
  copy_id number(10),
  title_id number(10) references title_qky_406(title_id),
  status varchar2(15) not null check(
    status in('AVAILABLE', 'DESTROY', 'RENTED', 'RESERVED')
  ),
  primary key (copy_id,title_id)
);

--表member_qky_406
create table member_qky_406(
  member_id number(10) primary key,
  last_name varchar(25) not null,
  first_name varchar2(25),
  address varchar2(100),
  city varchar2(30),
  phone varchar2(15),
  join_date date default sysdate not null
);

--表rental_qky_406
create table rental_qky_406(
  book_date date default sysdate,
  member_id number(10) references member_qky_406(member_id),
  copy_id number(10),
  act_ret_date date,
  exp_ret_date date default sysdate+2,
  title_id number(10),
  primary key(book_date,member_id,copy_id,title_id),
  foreign key(copy_id,title_id) references title_copy_qky_406(copy_id,title_id)
);

--表reservation_qky_406
create table reservation_qky_406(
  res_date date,
  member_id number(10) references member_qky_406(member_id),
  title_id number(10) references title_qky_406(title_id),
  primary key (res_date, member_id, title_id)
);

--trigger
create or replace trigger insert_trigger_qky_406_member
before insert on member_qky_406
  for each row
	when(new.member_id is null)
  begin
    select member_qky_406_sequence.nextval into :new.member_id from dual;
  end;

ALTER TRIGGER insert_trigger_qky_406_member COMPILE;
COMMIT ;

--创建序列
create sequence member_qky_406_sequence
  increment by 1
  start with 1
  minvalue 1
  nomaxvalue
  cache 10;

--执行
alter trigger insert_trigger_qky_406_member enable;
insert into member_qky_406(LAST_NAME,FIRST_NAME,JOIN_DATE) values('que','kunyang',sysdate);
insert into member_qky_406(LAST_NAME,FIRST_NAME,JOIN_DATE) values('nightwing','ky',sysdate);
insert into member_qky_406(LAST_NAME,FIRST_NAME,JOIN_DATE) values('zhou','wunan',sysdate);
select * from member_qky_406;

--触发器
CREATE OR REPLACE TRIGGER insert_trigger_qky_406_title
BEFORE INSERT ON title_qky_406
  for each row
  when(new.title_id is null)
BEGIN
  select title_qky_406_seq.nextval into:new.title_id from dual;
  dbms_output.put_line('title_qky_406 have been updated');
END;
--创建序列
create sequence title_qky_406_seq
  increment by 1
  start with 1
  minvalue 1
  nomaxvalue
  cache 10;

--编写存储过程
CREATE OR REPLACE PROCEDURE procedure_insert_all_qky_406 (
  plast_name in varchar,
  pjoin_date in date,
  ptitle in varchar,
  pdescription in varchar,
  pcopy_id in number,
  pstatus in varchar,
  pbook_date in date
)
AS
v_count number;
v_title_id number;
v_member_id number;
v_copy_id number;

BEGIN
  select count(*) into v_count from member_qky_406 where last_name=plast_name;

  if v_count > 0 then
    dbms_output.put_line('This member has already been saved, please change one.');
  else
    insert into member_qky_406(last_name, join_date) values(plast_name, pjoin_date);
  end if;

  select member_id into v_member_id from member_qky_406 where last_name=plast_name;

  select count(*) into v_count from title_qky_406 where title=ptitle;

  if v_count > 0 then
    dbms_output.put_line('This title has been saved, please change one.');
  else
    insert into title_qky_406(title, description) values(ptitle, pdescription);
  end if;

  select title_id into v_title_id from title_qky_406 where title=ptitle;

  select count(*) into v_count from title_copy_qky_406
  where title_id=v_title_id and copy_id=pcopy_id;

  if v_count > 0 then
    dbms_output.put_line('This title has been copied');
  else
    insert into title_copy_qky_406(copy_id, title_id, status) values(pcopy_id, v_title_id, pstatus);
  end if;

  select copy_id into v_copy_id from title_copy_qky_406 where title_id=v_title_id;

  select count(*) into v_count from rental_qky_406 where title_id=v_title_id and copy_id=v_copy_id and member_id=v_member_id;

  if v_count > 0 then
    dbms_output.put_line('This rental has been saved');
  else
    insert into rental_qky_406(title_id, copy_id, member_id, book_date) values(v_title_id, v_copy_id, v_member_id, pbook_date);
  end if;

  commit;

END procedure_insert_all_qky_406;

BEGIN
  procedure_insert_all_qky_406('KunyangQue1', sysdate-1, 'MyFilm1', 'This is film of qky1', 1, 'AVAILABLE', sysdate+1);
  procedure_insert_all_qky_406('KunyangQue2', sysdate-2, 'MyFilm2', 'This is film of qky2', 2, 'AVAILABLE', sysdate+2);
  procedure_insert_all_qky_406('KunyangQue3', sysdate-3, 'MyFilm3', 'This is film of qky3', 3, 'AVAILABLE', sysdate+3);
  procedure_insert_all_qky_406('KunyangQue4', sysdate-4, 'MyFilm4', 'This is film of qky4', 4, 'AVAILABLE', sysdate+4);
  procedure_insert_all_qky_406('KunyangQue5', sysdate-5, 'MyFilm5', 'This is film of qky5', 5, 'AVAILABLE', sysdate+5);
  procedure_insert_all_qky_406('KunyangQue6', sysdate-6, 'MyFilm6', 'This is film of qky6', 6, 'AVAILABLE', sysdate+6);
  procedure_insert_all_qky_406('KunyangQue7', sysdate-7, 'MyFilm7', 'This is film of qky7', 7, 'AVAILABLE', sysdate+7);
  procedure_insert_all_qky_406('KunyangQue8', sysdate-8, 'MyFilm8', 'This is film of qky8', 8, 'AVAILABLE', sysdate+8);
  procedure_insert_all_qky_406('KunyangQue9', sysdate-9, 'MyFilm9', 'This is film of qky9', 9, 'AVAILABLE', sysdate+9);
  procedure_insert_all_qky_406('KunyangQue10', sysdate-10, 'MyFilm10', 'This is film of qky10', 10, 'AVAILABLE', sysdate+10);
  procedure_insert_all_qky_406('KunyangQue10', sysdate-10, 'qky', 'This is film of qky10', 10, 'AVAILABLE', sysdate+10);
END;

BEGIN
  procedure_insert_all_qky_406('KunyangQue11', sysdate-10, 'qky', 'This is film of qky11', 10, 'AVAILABLE', sysdate+10);
END;

SELECT * FROM title_qky_406;
select * from member_qky_406;
select * from rental_qky_406;

CREATE OR REPLACE FUNCTION rental_sum_qky_406 RETURN NUMBER AS
resultNum number :=0;
rentalFree number :=0;
rental_ten number :=10;
rental_five number :=5;
v_count1 number;
v_count2 number;
v_count3 number;

BEGIN
  --普通会员收5元
  select count(*) into v_count3 from rental_qky_406 where TITLE_ID!=(
    select title_id from title_qky_406 where title like 'qky%'
  );
  resultNum :=v_count3*rental_five + resultNum;
  --包含姓名收10元
  select count(*) into v_count1 from RENTAL_QKY_406 where TITLE_ID=(
    select title_id from TITLE_QKY_406 where title like 'qky%'
  )
  and member_id !=(
    select member_id from member_qky_406 where last_name='KunyangQue'
  );
  resultNum := v_count1 * rental_ten + resultNum;
  --姓名相同免费
  select count(*) into v_count2 from RENTAL_QKY_406 where TITLE_ID=(
    select title_id from TITLE_QKY_406 where title like 'qky%'
  )
  and member_id=(
    select member_id from member_qky_406 where last_name='KunyangQue'
  );
  resultNum := v_count2 * rentalFree + resultNum;

  RETURN resultNum;
END rental_sum_qky_406;
--调用函数
select rental_sum_qky_406 from dual;