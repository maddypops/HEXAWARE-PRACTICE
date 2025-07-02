/*..................STRINGFUNCTIONS........................*/

select name,upper(name) as uppercase_name,lower(name) as lowercase_name 
from users;

select name,len(name) as name_length,ltrim(name) as ltrimmed,rtrim(name) as rtrimmed 
from users;


select email,charindex('@',email) as at_position 
from users;


select name,
left(name,5) as first_5,
right(name,3) as last_3,
substring(name,2,3) as mid_3
from users;


select email,replace(email,'.com','.org') as updated_email 
from users;



select concat(name,' <',email,'>') as full_contact 
from users;


select review_id,isnull(reviewer_name,'Anonymous') as reviewer 
from review;

select title,reverse(title) as reversed_title 
from movie;


select email,patindex('%@gmail%',email) as gmail_position 
from users;


select review_id,format(review_date,'yyyy-MM-dd') as formatted_date 
from review;




/*....................................MATHEMATICAL-FUNCTION....................................*/

select transaction_id,amount,abs(amount) as absolute_amount
from pointstransaction;


select booking_id,total_cost,
ceiling(total_cost) as round_up,
floor(total_cost) as round_down
from booking;


select payment_id,transaction_amount,
round(transaction_amount,1) as rounded_1dp,
round(transaction_amount,0) as rounded_int
from payment;


select transaction_id,amount,
power(amount,2) as squared_amount,
sqrt(amount) as square_root
from pointstransaction;


select transaction_id,amount,sign(amount) as sign_value
from pointstransaction;


select booking_id,total_cost,rand(checksum(newid())) as random_value
from booking;



select transaction_id,amount,
log(amount) as ln_value,
log10(amount) as log10_value
from pointstransaction
where amount > 0;


select transaction_id,amount,
exp(amount) as exp_value
from pointstransaction
where amount > 100;




/*..............DATE-FUNCTION..................*/

select getdate() as current_datetime;


select booking_id,booking_datetime,
year(booking_datetime) as year,
month(booking_datetime) as month,
day(booking_datetime) as day
from booking;


select payment_id,transaction_datetime,
datepart(hour,transaction_datetime) as txn_hour,
datepart(minute,transaction_datetime) as txn_minute
from payment;



select payment_id,transaction_datetime,
datediff(day,transaction_datetime,getdate()) as days_since_payment
from payment;


select review_id,review_date,
eomonth(review_date) as end_of_month
from review;


select booking_id,booking_datetime,
dateadd(day,7,booking_datetime) as plus_7_days
from booking;

select booking_id,
format(booking_datetime,'yyyy-MM-dd hh:mm tt') as formatted_booking_time
from booking;


/*......CONSTRAINS.......*/

alter table users
add constraint uq_email unique (email);


alter table payment
add constraint chk_transaction_amount check (transaction_amount > 0);


alter table ticket
add constraint df_is_downloaded default 0 for is_downloaded;


alter table fooditem
alter column name varchar(100) not null;



/*........LOGICAL OPERATOR.......*/



select * from users
where email is not null 
and len(cast(phone as varchar)) >= 10;


select * from booking
where total_cost > 500 
or booking_datetime = '2025-06-07 12:00';


select * from payment
where not status = 'Success';


select * from booking
where (user_id = 1 or user_id = 2)
and total_cost > 400;




BEGIN TRANSACTION;

INSERT INTO booking (booking_id, user_id, show_id, booking_datetime, total_cost)
VALUES (9, 1, 1, GETDATE(), 450.00);

INSERT INTO ticket (ticket_id, booking_id, show_seat_id, delivery_method, is_downloaded, scanned_at)
VALUES (6, 9, 1, 'Email', 0, NULL);

COMMIT;




BEGIN TRANSACTION;

UPDATE payment
SET transaction_amount = -999.00 -- invalid value
WHERE payment_id = 1;

ROLLBACK;






USE hexa;
CREATE USER MADDYPOP FOR LOGIN [MADDYPOPS\madha];



SELECT SUSER_NAME() AS login_name;


select name from sys.server_principals where name='maddy';
create login maddy with password ='Madhansai@2004';
use hexa;
create user maddy for login maddy;
grant select, insert, update on booking to maddy;
select * from INFORMATION_SCHEMA.TABLE_PRIVILEGES where GRANTEE = 'maddy';



revoke insert, update on booking from maddy;

 
GRANT SELECT ON booking TO [MADDYPOPS\madha] ;

