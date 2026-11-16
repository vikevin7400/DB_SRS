  CREATE TABLE "CONTENT" 
   (	"CONTENT_ID" NUMBER(*,0), 
	"TITLE" VARCHAR2(200) NOT NULL ENABLE, 
	"DESCRIPTION" CLOB, 
	"RELEASE_YEAR" NUMBER(*,0), 
	"CONTENT_TYPE" VARCHAR2(20) NOT NULL ENABLE, 
	"AGE_RATING" VARCHAR2(10), 
	"LANGUAGE" VARCHAR2(50), 
	"DURATION_MINUTES" NUMBER(*,0), 
	"CREATED_AT" TIMESTAMP (6) DEFAULT current_timestamp, 
	"RATING" NUMBER(3,1), 
	 PRIMARY KEY ("CONTENT_ID")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "CONTENT_GENRE" 
   (	"CONTENT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"GENRE_ID" NUMBER(*,0) NOT NULL ENABLE
   ) ;

  CREATE TABLE "GENRES" 
   (	"GENRE_ID" NUMBER(*,0), 
	"GENRE_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	 PRIMARY KEY ("GENRE_ID")
  USING INDEX  ENABLE, 
	 UNIQUE ("GENRE_NAME")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PAYMENTS" 
   (	"PAYMENT_ID" NUMBER(*,0), 
	"USER_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"SUBSCRIPTION_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"AMOUNT" NUMBER(8,2) NOT NULL ENABLE, 
	"PAYMENT_METHOD" VARCHAR2(50) NOT NULL ENABLE, 
	"PAYMENT_STATUS" VARCHAR2(20) DEFAULT 'SUCCESS', 
	"PAYMENT_DATE" TIMESTAMP (6) DEFAULT current_timestamp, 
	 PRIMARY KEY ("PAYMENT_ID")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "SUBSCRIPTION_PLANS" 
   (	"PLAN_ID" NUMBER(*,0), 
	"PLAN_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	"PRICE" NUMBER(8,2) NOT NULL ENABLE, 
	"DURATION_DAYS" NUMBER(*,0) NOT NULL ENABLE, 
	"VIDEO_QUALITY" VARCHAR2(20) NOT NULL ENABLE, 
	 PRIMARY KEY ("PLAN_ID")
  USING INDEX  ENABLE, 
	 UNIQUE ("PLAN_NAME")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "USERS" 
   (	"USER_ID" NUMBER(*,0), 
	"FULL_NAME" VARCHAR2(100) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(150) NOT NULL ENABLE, 
	"PASSWORD" VARCHAR2(255) NOT NULL ENABLE, 
	"PHONE" VARCHAR2(15), 
	"CREATED_AT" TIMESTAMP (6) DEFAULT current_timestamp, 
	"STATUS" VARCHAR2(20) DEFAULT 'ACTIVE', 
	 PRIMARY KEY ("USER_ID")
  USING INDEX  ENABLE, 
	 UNIQUE ("EMAIL")
  USING INDEX  ENABLE, 
	 UNIQUE ("PHONE")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "USER_SUBSCRIPTIONS" 
   (	"SUBSCRIPTION_ID" NUMBER(*,0), 
	"USER_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"PLAN_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"START_DATE" DATE NOT NULL ENABLE, 
	"END_DATE" DATE NOT NULL ENABLE, 
	"STATUS" VARCHAR2(20) DEFAULT 'ACTIVE', 
	 PRIMARY KEY ("SUBSCRIPTION_ID")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "WATCH_HISTORY" 
   (	"HISTORY_ID" NUMBER(*,0), 
	"USER_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"CONTENT_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"WATCH_TIME" NUMBER(*,0), 
	"WATCHED_AT" TIMESTAMP (6) DEFAULT current_timestamp, 
	 PRIMARY KEY ("HISTORY_ID")
  USING INDEX  ENABLE
   ) ;

  ALTER TABLE "CONTENT_GENRE" ADD CONSTRAINT "FK_CONT_GNRE" FOREIGN KEY ("CONTENT_ID")
	  REFERENCES "CONTENT" ("CONTENT_ID") ENABLE;
  ALTER TABLE "CONTENT_GENRE" ADD CONSTRAINT "FK_GNRE_ID" FOREIGN KEY ("GENRE_ID")
	  REFERENCES "GENRES" ("GENRE_ID") ENABLE;

  ALTER TABLE "PAYMENTS" ADD CONSTRAINT "FK_PAY_SUB" FOREIGN KEY ("SUBSCRIPTION_ID")
	  REFERENCES "USER_SUBSCRIPTIONS" ("SUBSCRIPTION_ID") ENABLE;

  ALTER TABLE "USER_SUBSCRIPTIONS" ADD CONSTRAINT "FK_SUB_PLAN" FOREIGN KEY ("PLAN_ID")
	  REFERENCES "SUBSCRIPTION_PLANS" ("PLAN_ID") ENABLE;
  ALTER TABLE "USER_SUBSCRIPTIONS" ADD CONSTRAINT "FK_SUB_USER" FOREIGN KEY ("USER_ID")
	  REFERENCES "USERS" ("USER_ID") ENABLE;

  ALTER TABLE "WATCH_HISTORY" ADD CONSTRAINT "FK_WH_CONT" FOREIGN KEY ("CONTENT_ID")
	  REFERENCES "CONTENT" ("CONTENT_ID") ENABLE;
  ALTER TABLE "WATCH_HISTORY" ADD CONSTRAINT "FK_WH_USR" FOREIGN KEY ("USER_ID")
	  REFERENCES "USERS" ("USER_ID") ENABLE;

  CREATE UNIQUE INDEX "SYS_C00203404730" ON "DEPARTMENTS" ("D_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205644874" ON "GENRES" ("GENRE_NAME") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205645330" ON "WATCH_HISTORY" ("HISTORY_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00203404773" ON "EMPLOYEES" ("E_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205641645" ON "USERS" ("EMAIL") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205644542" ON "USER_SUBSCRIPTIONS" ("SUBSCRIPTION_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205643773" ON "SUBSCRIPTION_PLANS" ("PLAN_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205644873" ON "GENRES" ("GENRE_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205644860" ON "CONTENT" ("CONTENT_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205641644" ON "USERS" ("USER_ID") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205643774" ON "SUBSCRIPTION_PLANS" ("PLAN_NAME") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205641646" ON "USERS" ("PHONE") 
  ;

  CREATE UNIQUE INDEX "SYS_C00205645680" ON "PAYMENTS" ("PAYMENT_ID") 
  ;













create or replace procedure add_new_content(c_id in int,c_title in varchar,c_desc in clob,c_release_yr in int ,c_type in varchar,c_age_rate in varchar,c_lang in varchar,c_dur_min in int)
as
begin
insert into content(content_id, title, description, release_year, content_type, age_rating, language, duration_minutes)
values(c_id,c_title,c_desc,c_release_yr,c_type,c_age_rate,c_lang,c_dur_min);
dbms_output.put_line('Content added sucessfully');
end;
/


create or replace procedure add_new_user(u_id in int,u_fname in varchar,u_email in varchar,u_pass in varchar,u_phone in varchar)
as
begin
insert into users(user_id,full_name,email,password,phone) values(u_id,u_fname,u_email,u_pass,u_phone);
dbms_output.put_line('data added sucessfully');
end;
/
create or replace procedure add_subscription_plan
(p_id in int,p_name in varchar,p_price in decimal,p_dur in int,p_vid_qty in varchar)
is
begin
insert into subscription_plans values(p_id,p_name,p_price,p_dur,p_vid_qty);
dbms_output.put_line('Subscription Plans added sucessfully');
end;
/
create or replace procedure add_watch_record(w_hid in int ,w_uid in int,w_cid in int,w_time in int)
is
begin
insert into watch_history(history_id,user_id,content_id,watch_time) values(w_hid,w_uid,w_cid,w_time);
dbms_output.put_line('Watch History inserted Successfully');
end;
/
create or replace procedure cancel_subscriptions(us_sub_id in int)
 is 
 begin
 update user_subscriptions set status = 'CANCELLED' where subscription_id = us_sub_id;
 dbms_output.put_line('Subscriptions Cancelled Sucessfully');
 end;
/
create or replace procedure record_payment(pay_id in int,pay_uid in int,pay_subid in int,pay_amount in decimal,pay_method in varchar)
is 
begin
insert into payments(payment_id,user_id,subscription_id,amount,payment_method) values(pay_id,pay_uid,pay_subid,pay_amount,pay_method);
dbms_output.put_line('payments added sucessfully');
end;
/


begin
    add_new_user(
        101,
        'Vikram Singh',
        'vikram101@gmail.com',
        'hash303',
        '9876543215'
    );

end;

update users set phone = '7777766666' where user_id = 5
delete from users where user_id = 101
select count(users_id) as total_no_users from users
select count(email) from users where email = 'rahul@gmail.com'
/
begin
add_new_content(101,'Interstellar','A science fiction movie about space travel',2014,'Movie','13+','English',169);
end;
update content set release_year = 2015 where content_id = 101
delete from content where content_id = 101
select * from content order by age_rating
select * from content where release_year > (select release_year  from content where title = 'Inception')
/

begin
    add_subscription_plan(
        101,
        'Gold',
        499,
        30,
        '4K'
    );
 
end;

update subscription_plans set duration_days = 40 ,price = 299 where plan_id = 101
delete from subscription_plans where plan_id = 101
select count(plan_name) from subscription_plans 
select * from users inner join user_subscriptions on  users.user_id = user_subscriptions.user_id
select  * from users right join user_subscriptions on  users.user_id = user_subscriptions.user_id where user_subscriptions.status = 'ACTIVE'
select plan_id,count(user_id) as total_subscriptions from user_subscriptions group by plan_id
select plan_id,count(user_id) as total_subscriptions from user subscriptions group by plan_id having count(user_id)>10

/
BEGIN
    ADD_WATCH_RECORD(6, 1, 3, 120);
END;

select * from users  inner join watch_history on users.user_id = watch_history.user_id
select content_id , count(user_id) as total_content_view from watch_history group by content_id
select content_id, count(user_id) as most_watch from watch_history group by content_id order by most_watch desc 
select content_id, count(user_id) as most_watch from watch_history group by content_id order by most_watch desc 
select * from users  inner join watch_history on users.user_id = watch_history.user_id
select * from watch_history inner join content on watch_history.content_id = content.content_id
/

select * from user_subscriptions inner join payments on user_subscriptions.subscription_id = payments.subscription_id
select plan_id, sum(amount) as total_revenue from user_subscriptions inner join payments on user_subscriptions.subscription_id = payments.subscription_id group by plan_id
select user_id, amount from payments where amount > (select avg(amount) from payments)
select sum(amount) as total_revenue from payments;

begin
    cancel_subscriptions(4);
end;







