use hexa;

create table screen(
	screen_id int primary key ,
	name varchar(50),
	class_type varchar(10),
	capacity int
	);


create table seat(
	seat_id int primary key,
	screen_id int,
	seat_number varchar(10),
	foreign key (screen_id) references screen(screen_id)
	);

create table movie(
	movie_id int primary key,
	title varchar(200),
	genre varchar(50),
	rating decimal(3,1),
	status varchar(30),
	poster_image_url varchar(300)
	);

create table moviecast(
	cast_id int primary key,
	movie_id int,
	person_name varchar(100),
	role varchar(100),
	foreign key (movie_id) references movie(movie_id)
	);

create table review(
	review_id int primary key,
	movie_id int,
	content text,
	review_date datetime,
	reviewer_name varchar(100),
	foreign key (movie_id) references movie(movie_id)
	);

create table show(
	show_id int primary key,
	screen_id int,
	movie_id int,
	show_datetime datetime,
	foreign key (screen_id) references screen(screen_id),
	foreign key (movie_id) references movie(movie_id)
	);

create table show_seat(
	show_seat_id int primary key,
	show_id int,
	seat_id int,
	is_available bit,
	foreign key (show_id) references show(show_id),
	foreign key (seat_id) references seat(seat_id)
	);

create table users(
	user_id int primary key,
	name varchar(100),
	email varchar(200),
	phone int
	);

create table membership(
	membership_id int primary key,
	user_id int,
	current_points int,
	foreign key (user_id) references users(user_id)
	);

create table booking(
	booking_id int primary key,
	user_id int,
	show_id int,
	booking_datetime datetime,
	total_cost decimal(10,2),
	foreign key (user_id) references users(user_id),
	foreign key (show_id) references show(show_id)
	);



create table ticket(
	ticket_id int primary key,
	booking_id int,
	show_seat_id int,
	delivery_method varchar(190),
	is_downloaded bit,
	scanned_at datetime,
	foreign key (booking_id) references booking(booking_id),
	foreign key (show_seat_id) references show_seat(show_seat_id)
	);


create table paymentgateway(
	gateway_id int primary key,
	name varchar(100)
	);


create table payment(
	payment_id int primary key,
	booking_id int,
	gateway_id int,
	transaction_amount decimal(10,2),
	transaction_datetime datetime,
	status varchar(20),
	failure_reason text,
	credit_card_name varchar(100),
	credit_card_number varchar(30),
	expiry_date date,
	cvv varchar(4),
	foreign key (booking_id) references booking(booking_id),
	foreign key (gateway_id) references paymentgateway(gateway_id)
	);


create table fooditem(
	item_id int primary key,
	name varchar(100),
	descriptiopn text,
	is_combo bit
	);


create table fooditemsize(
	size_id int primary key,
	item_id int,
	size_name varchar(100),
	rate decimal(10,2)
	);

create table foodorder(
	order_id int primary key,
	booking_id int,
	screen_id int,
	seat_id int,
	order_datetime datetime,
	total_cost decimal(10,2),
	delivery_method varchar(50),
	foreign key (booking_id) references booking(booking_id),
	foreign key (screen_id) references screen(screen_id),
	foreign key (seat_id) references seat(seat_id)
	);


create table foodorderitem(
	order_item_id int primary key,
	order_id int,
	item_id int,
	size_id int,
	quantity int,
	price_at_time decimal(10,2)
	foreign key (order_id) references foodorder(order_id),
	foreign key (item_id) references fooditem(item_id),
	foreign key (size_id) references fooditemsize(size_id)
	);


create table pointstransaction (
	transaction_id int identity primary key,
	user_id int,
	amount decimal (10,2),
	points_earned int ,
	transaction_datetime datetime,
	transaction_type varchar(20),
	foreign key (user_id) references users(user_id)
	);


create table discount_code (
    code_id int primary key,
    code varchar(50) unique not null,
    discount_percent int check (discount_percent between 1 and 100),
    created_at datetime default getdate()
	);
