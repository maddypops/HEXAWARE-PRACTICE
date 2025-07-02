/*....ALTER....*/

alter table users
alter column phone BIGINT;


alter table screen
add location varchar(100);


alter table movie
add language varchar(50);


/*....SELECT...*/

select *from screen;
select *from seat;
select *from movie;
select *from moviecast;
select *from review;
select *from show;
select *from show_seat;
select *from users;
select *from membership;
select *from booking;
select *from ticket;
select *from paymentgateway;
select *from payment;
select *from booking;


/*.....SELECT-WHERE.....*/
select *from movie
where rating > 8;



/*.......UPDATE........*/


use hexa;
update users
set email = 'mail@gmail.com'
where user_id = 1;

update show
set show_datetime = '2025-07-01 18:00'
where show_id = 1;

update show_seat
set is_available = 1
where seat_id = 2 and show_id = 1;


update screen
set location = 'first floor'
where screen_id = 1;

update screen
set location = 'first floor'
where screen_id = 2;

update screen
set location = 'second floor'
where screen_id = 3;





/*..........DELETE..........*/

delete from review
where reviewer_name = 'bob';


delete from booking
where show_id = 5;


delete from membership 
where current_points<100;




/*.........OFFSET-FETCH..........*/

select *from users
order by user_id
offset 2 rows
fetch next 2 rows only;


select *from movie
order by rating desc
offset 3 rows
fetch next 5 rows only;



select *from ticket
order by scanned_at desc
offset 0 rows
fetch next 5 rows only;
























exec sp_help 'screen';