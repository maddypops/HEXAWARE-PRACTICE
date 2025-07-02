use hexa;
---------------TABLE-CREATION-----------------------
create table artist(
	artist_id int primary key,
	name varchar(200) not null,
	biography text,
	nationality varchar(100)
	);

create table categories(
	category_id int primary key,
	name varchar(100) not null
	);

create table artwork(
	artwork_id int primary key,
	title varchar(200) not null,
	artist_id int,
	category_id int,
	year int,
	description text,
	image_url varchar(200),
	foreign key (artist_id) references artist(artist_id),
	foreign key (category_id) references categories(category_id)
	);

create table exhibition(
	exhibition_id int primary key,
	title varchar(200)not null,
	startdate date,
	enddate date,
	description text
	);

create table exhibitionartworks (
	exhibition_id int,
	artwork_id int,
	primary key (exhibition_id, artwork_id),
	foreign key (exhibition_id) references exhibition(exhibition_id),
	foreign key (artwork_id) references artwork(artwork_id)
	);


----------------INSERT DATA----------------

insert into artist 
values	
	(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
	(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
	(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian'),
	(4, 'Frida Kahlo', 'Mexican painter known for self-portraits.', 'Mexican'),
	(5, 'Andy Warhol', 'Leading figure in the visual art movement known as pop art.', 'American'),
	(6, 'Claude Monet', 'Founder of French Impressionist painting.', 'French'),
	(7, 'Georgia O''Keeffe', 'Mother of American modernism.', 'American');

insert into categories 
values
	(1, 'Painting'),
	(2, 'Sculpture'),
	(3, 'Photography');

insert into artwork 
values
	(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
	(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
	(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso''s powerful anti-war mural.', 'guernica.jpg'),
	(4, 'The Two Fridas', 4, 1, 1939, 'A double self-portrait by Frida Kahlo.', 'the_two_fridas.jpg'),
	(5, 'Campbell''s Soup Cans', 5, 1, 1962, 'A famous pop art piece by Andy Warhol.', 'campbells_soup.jpg'),
	(6, 'Water Lilies', 6, 1, 1916, 'A serene depiction of Monet''s garden pond.', 'water_lilies.jpg'),
	(7, 'Red Canna', 7, 1, 1924, 'Floral abstract by Georgia O''Keeffe.', 'red_canna.jpg'),
	(8, 'Sunflowers', 2, 1, 1888, 'A vibrant still-life of sunflowers.', 'sunflowers.jpg'),
	(9, 'The Bedroom', 2, 1, 1889, 'Van Gogh''s bedroom in Arles.', 'the_bedroom.jpg'),
	(10, 'The Last Supper', 3, 1, 1498, 'Depiction of Jesus'' last meal with the apostles.', 'the_last_supper.jpg'),
	(11, 'Vitruvian Man', 3, 1, 1490, 'A study of human anatomy and proportion.', 'vitruvian_man.jpg');


insert into exhibition 
values
	(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
	(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.'),
	(3, 'Impressionist Visions', '2023-07-10', '2023-09-15', 'A journey through light and color in Impressionism.'),
	(4, 'Abstract Expressions', '2023-10-01', '2023-12-15', 'Dive into the bold and emotional world of abstract art.'),
	(5, 'Women in Art', '2024-01-01', '2024-03-31', 'Celebrating works by female artists across generations.'),
	(6, 'Pop Culture Icons', '2024-04-10', '2024-06-15', 'Highlighting artwork inspired by pop culture.'),
	(7, 'Nature and Landscape', '2024-07-01', '2024-09-30', 'Landscapes and nature in classical and modern art.');


insert into exhibitionartworks 
values
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 2),
	(2, 10),
	(2, 11),
	(5, 4),
	(5, 7), 
	(6, 5),
	(7, 6);

select * from artist ;
select * from categories ;
select * from artwork ;
select * from exhibition ;
select * from exhibitionartworks ;


alter table artwork
add dimensions varchar(100);



update artwork 
set category_id = 2
where artwork_id =10;

update artwork 
set category_id = 3
where artwork_id =11;


delete from artwork where title = 'Untitled';



select title, year 
from artwork 
where year between 1900 and 1950;



delete from orderstable 
where place=
	(
	select place
	from city
	where place = 'chennai'
	);

select e.employee_name
from employee e
join orders o on e.employee_id = o.employee_id
where o.total_amount > 1000;