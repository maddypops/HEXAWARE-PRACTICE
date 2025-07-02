/*.......ORDERBY clause......*/
use hexa;

select transaction_amount from payment
order by transaction_amount ;

select transaction_amount from payment
order by transaction_amount desc;

select booking_id, total_cost
from foodorder
order by booking_id desc, total_cost asc;


/*.........LIMIT and OFFSET...........

select transaction_amount
from payment
order by transaction_amount ASC
limit 3 offset 4;

*/

/*........ GROUPBY CLAUSE.....*/

select transaction_amount , payment_id as ID
from payment
where transaction_amount > 300
group by transaction_amount,payment_id 
order by transaction_amount;


select distinct transaction_amount , payment_id as ID
from payment
where transaction_amount > 300
group by transaction_amount,payment_id 
order by transaction_amount;

/*with having*/
select user_id, YEAR(booking_datetime) AS booking_year, COUNT(booking_id) AS total_bookings
FROM booking
GROUP BY user_id, YEAR(booking_datetime)
HAVING COUNT(booking_id) >= 2
ORDER BY user_id;


/*...........AGGREGATEFUNCTION..............*/
select  user_id, COUNT(booking_id) as total_bookings
from booking
group by user_id;


select user_id,count(booking_id) as total_bookings 
from booking 
group by user_id;

select booking.user_id,sum(payment.transaction_amount) as total_paid 
from payment 
join booking on payment.booking_id=booking.booking_id        /*..........usingjoin.........*/
group by booking.user_id;

select gateway_id,avg(transaction_amount) as avg_transaction 
from payment 
group by gateway_id;

select max(total_cost) as max_booking_cost,min(total_cost) as min_booking_cost 
from booking;

select user_id,sum(points_earned) as total_points 
from pointstransaction 
group by user_id;

select screen_id,sum(total_cost) as total_food_sales 
from foodorder 
group by screen_id;

select movie_id,count(review_id) as review_count 
from review 
group by movie_id;



/*............SQL joins................*/

select u.user_id,u.name,b.booking_id,b.total_cost 
from users u
inner join booking b on u.user_id=b.user_id;


select u.user_id,u.name,b.booking_id,b.total_cost 
from users u
left join booking b on u.user_id=b.user_id;

select u.user_id,u.name,b.booking_id,b.total_cost 
from users u
right join booking b on u.user_id=b.user_id;


select u.user_id,u.name,b.booking_id,b.total_cost 
from users u
full outer join booking b on u.user_id=b.user_id;


select u.user_id,u.name,b.booking_id,b.total_cost 
from users u
cross join booking b;


select b1.booking_id as booking1,b2.booking_id as booking2,b1.user_id,b1.total_cost as cost1,b2.total_cost as cost2
from booking b1
join booking b2 on b1.user_id=b2.user_id and b1.booking_id<>b2.booking_id;


select u.user_id, u.name, b.booking_id, b.booking_datetime, p.transaction_amount
from users u
join booking b on u.user_id = b.user_id
join payment p on b.booking_id = p.booking_id;



select  u.user_id, u.name, g.gateway_id, g.name as gateway_name
from users u
cross join paymentgateway g;


select f.order_id, f.order_datetime, b.booking_id,s.screen_id,o.order_id, i.size_id
from foodorder f
join booking b on f.booking_id = b.booking_id
join screen s on f.screen_id = s.screen_id
join foodorderitem o on f.order_id = o.order_id
join fooditemsize i on o.size_id = i.size_id;











/*....................CASESTATEMENT....................*/

select booking_id, total_cost,
case 
    when total_cost >= 500 then 'High Value'
    when total_cost between 300 and 499 then 'Medium Value'
    else 'Low Value'
end as cost_category
from booking;




select payment_id, transaction_amount, status,
case 
    when status = 'Success' then 'Payment completed'
    when status = 'Failed' then 'Payment failed'
    else 'Pending or Unknown'
end as status_message
from payment;




select user_id, name, email,
case 
    when email is null or email = '' then 'No Email'
    else 'Email Provided'
end as email_status
from users;



select membership_id, user_id, current_points,
case
    when current_points >=100 then 'gold'
    when current_points >=50 then 'silver'
    else 'bronze'
end as reward_tier
from membership;






/*................... Subquery.......................*/

select * from users
where user_id in (
    select user_id from booking
);




select booking_id,(select sum(transaction_amount) 
from payment where payment.booking_id = booking.booking_id) as total_paid
from booking;


select booking_id, user_id, total_cost
from booking b1
where total_cost > (
    select avg(total_cost) from booking b2 where b1.user_id = b2.user_id
);


select user_id, avg_paid
from (
    select b.user_id, sum(p.transaction_amount) as avg_paid
    from payment p
    join booking b on b.booking_id = p.booking_id
    group by b.user_id)
 as payment_summary;
