create table customerstable (
	customer_id int primary key,
	name varchar(100),
	email varchar(100),
	city varchar(50),
	created_at date
	);


create table product (
	product_id int primary key,
	name varchar(100),
	category varchar(50),
	price decimal(10,2),
	stock int
	);


create table orderstable (
	order_id int primary key,
	customer_id int,
	product_id int,
	quantity int,
	order_date date,
	total_price decimal(10,2),
	foreign key (customer_id) references customerstable(customer_id),
	foreign key (product_id) references product(product_id)
	);


insert into customerstable (customer_id, name, email, city, created_at)
values
	(1, 'madhan', 'madhansaisj@gmail.com', 'tirupathur', '2024-05-02'),
	(2, 'sai', 'mdhnsai@gmail.com', 'vellore', '2025-05-03'),
	(3, 'jamuna', 'jamunasj@gmail.com', 'chennai', '2026-05-04');


insert into product (product_id, name, category, price, stock)
values
	(1, 'laptop', 'electronics', 80000, 40),
	(2, 'phone', 'electronics', 30000, 50),
	(3, 'sofa', 'furniture', 20000, 10);


insert into orderstable(order_id, customer_id, product_id, quantity, order_date, total_price)
values 
	(1,1,1,2,'2024-05-02', 80000),
	(2,2,2,1,'2025-05-03', 30000),
	(3,3,3,1,'2026-06-01', 20000);



select o.order_id, c.name as customer_name, o.total_price
from orderstable o 
join customerstable c on o.customer_id = c.customer_id;


select distinct order_id, c.name, order_date 
from customerstable c
join orderstable o on c.customer_id = o.customer_id
where year(o.order_date) = 2025;


select p.name  as productname, sum(o.quantity ) as total_sold, sum(o.total_price) as revenue
from orderstable o
join product p on p.product_id = o.product_id
group by p.name;


select p.name as product_name, sum(o.total_price) as revenue
from Orderstable o
join Product p on o.product_id = p.product_id
group by p.name
order by revenue desc
offset 0 rows fetch next 1 rows only;


select c.name as customer_name, AVG(o.total_price) AS avg_order_value
from Customerstable c
join Orderstable o on c.customer_id = o.customer_id
group by c.name;



select distinct c.name
from Customerstable c
Join Orderstable o ON c.customer_id = o.customer_id
join Product p ON o.product_id = p.product_id
WHERE p.stock < 30;


alter table Customerstable
Add referrer_id int;


update Customerstable
set referrer_id = NULL
where customer_id = 1;


update Customerstable
set referrer_id = 1
where customer_id IN (2, 3);


update Customerstable
set referrer_id = 2
where customer_id = 4;


update Customerstable
set referrer_id = 3
where customer_id = 5;



with referral_tree as (
    select customer_id, name, referrer_id, 0 as level 
    from Customerstable
    where referrer_id IS NULL

    union ALL
	
    select  c.customer_id, c.name,  c.referrer_id,  rt.level + 1 AS level
    from Customerstable c
    join referral_tree rt ON c.referrer_id = rt.customer_id
)

select customer_id, name, referrer_id, level
from referral_tree
order by level, customer_id;




select b.booking_id,u.name as customer_name,b.total_cost 
from booking b 
join users u on b.user_id=u.user_id;

select distinct u.name 
from users u join booking b on u.user_id=b.user_id 
where year(b.booking_datetime)=2023;

select fi.name as product_name,sum(foi.quantity) as total_sold,sum(foi.price_at_time*foi.quantity) as total_revenue 
from foodorderitem foi 
join fooditem fi on foi.item_id=fi.item_id 
group by fi.name;

select top 1 fi.name as product_name,sum(foi.price_at_time*foi.quantity) as revenue 
from foodorderitem foi 
join fooditem fi on foi.item_id=fi.item_id 
group by fi.name 
order by revenue desc;

select u.name as customer_name,avg(b.total_cost) as avg_order_value 
from users u 
join booking b on u.user_id=b.user_id 
group by u.name;

--------------------------------------------------------------------------------------

create procedure getusersbycity
@city nvarchar(50)
as
begin
    select user_id,name,email
    from users
    where email like '%' + @city + '%';
end;

exec getusersbycity @city='chennai';



create procedure getuserbookingcount
@userid int,
@bookingcount int output
as
begin
    select @bookingcount=count(*)
    from booking
    where user_id=@userid;
end;

declare @count int;
exec getuserbookingcount @userid=1, @bookingcount=@count output;
print @count;




select name,email
from users
where user_id in (
    select user_id from booking where total_cost > 500
);



select u.user_id,u.name,u.email,
(select count(*) from booking b where b.user_id=u.user_id) as total_bookings
from users u;



select item_id,name
from fooditem
where item_id not in (
    select distinct item_id from foodorderitem
);



select name,email
from users
where user_id in (
    select user_id
    from booking
    group by user_id
    having sum(total_cost) > (
        select avg(total_cost) from booking
    )
);



select u.name,t.total_spent
from users u
join (
    select user_id,sum(total_cost) as total_spent
    from booking
    group by user_id
) t on u.user_id=t.user_id;



select item_id,name
from fooditem
where item_id not in (select item_id from foodorderitem);



select user_id,count(booking_id) as total_bookings
from booking
group by user_id
having count(booking_id) > (
    select avg(total_bookings)
    from (
        select count(booking_id) as total_bookings
        from booking
        group by user_id
    ) sub
);



select email,count(*) from users
group by email
having count(*) > 1;








-----------------1NF---------------------

create table user_bookings (
    user_id int,
    booking_id int,
    primary key (user_id, booking_id),
    foreign key (user_id) references users(user_id),
    foreign key (booking_id) references booking(booking_id)
);



-----------------2NF----------------------

create table booking (
    booking_id int primary key,
    user_id int,
    show_id int,
    booking_datetime datetime,
    total_cost decimal(10,2),
    foreign key (user_id) references users(user_id),
    foreign key (show_id) references show(show_id)
);

create table booking_fooditems (
    booking_id int,
    item_id int,
    quantity int,
    foreign key (booking_id) references booking(booking_id),
    foreign key (item_id) references fooditem(item_id)
);


-------------------3NF------------------------
create table genres (
    genre_id int primary key,
    genre_name varchar(50)
);

create table movie (
    movie_id int primary key,
    title varchar(200),
    genre_id int,
    rating decimal(3,1),
    status varchar(30),
    poster_image_url varchar(300),
    foreign key (genre_id) references genres(genre_id)
);





---------------insert-sample-data----------------
insert into genres 
values (1, 'action'), (2, 'comedy');


insert into movie 
values 
(1, 'avengers', 1, 8.5, 'released', 'url1'),
(2, 'the mask', 2, 7.0, 'released', 'url2');

insert into users 
values (1, 'alice', 'alice@mail.com', 9876543210);


insert into booking 
values (1, 1, 1, getdate(), 450.00);


insert into booking_fooditems 
values (1, 1, 2);

--------------------retrival-------------------------

select u.name, b.booking_id, b.total_cost
from users u
join booking b on u.user_id = b.user_id;


select m.title, g.genre_name
from movie m
join genres g on m.genre_id = g.genre_id;

select booking_id, sum(quantity) as total_items
from booking_fooditems
group by booking_id;
