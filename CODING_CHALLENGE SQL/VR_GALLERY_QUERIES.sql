--------------------------QUERIES-------------------------------
----the names of all artists along with the number of artworks they have in the gallery, and list them in descending order of the number of artworks.----------

select a.name as artist_name, count(aw.artwork_id) as artwork_count
from artist a
left join artwork aw on a.artist_id = aw.artist_id
group by a.name
order by artwork_count desc;


---the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order them by the year in ascending order.----------------------

select aw.title, aw.year, a.nationality as nationalities
from artwork aw 
left join artist a on a.artist_id = aw.artist_id 
where a.nationality in ('spanish','dutch')
order by year;

-----the names of all artists who have artworks in the 'Painting' category, and the number of artworks they have in this category.-----------------------

select a.name as artist_name, count(aw.artwork_id) as painting_count
from artist a
join artwork aw on a.artist_id = aw.artist_id
join categories c on aw.category_id = c.category_id
where c.name = 'Painting'
group by a.name;


------the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.-----------------------------

select aw.title as artwork_title, a.name as artist_name, c.name
from artwork aw
join artist a on aw.artist_id = a.artist_id
join categories c on aw.category_id = c.category_id
join exhibitionartworks ea on aw.artwork_id = ea.artwork_id
join exhibition e on ea.exhibition_id = e.exhibition_id
where e.title = 'Modern Art Masterpieces';


--------the artists who have more than two artworks in the gallery.------------------

select a.name, count(aw.artwork_id) as artwork_count
from artist a 
join artwork aw on a.artist_id = aw.artist_id 
group by a.name 
having count(aw.artwork_id)>2;


--------the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 'Renaissance Art' exhibitions-----------------------------

select aw.title as artwork_title
from artwork aw
join exhibitionartworks ea on aw.artwork_id = ea.artwork_id
join exhibition e on ea.exhibition_id = e.exhibition_id
where e.title in ('Modern Art Masterpieces','Renaissance Art');


---------Find the total number of artworks in each category---------------------

select c.name, count(aw.artwork_id) as total_artwork
from artwork aw 
join categories c on aw.category_id = c.category_id
group by c.name;


select c.name, count(aw.artwork_id) as total_artworks
from categories c
left join artwork aw on c.category_id = aw.category_id
group by c.name;


--------------artists who have more than 3 artworks in the gallery.----------

select a.name, count(aw.artwork_id) as artwork_count
from artist a 
join artwork aw on a.artist_id = aw.artist_id 
group by a.name 
having count(aw.artwork_id)>=3;


--------------the artworks created by artists from a specific nationality--------------------

select aw.title, aw.year, a.nationality as nationalities
from artwork aw 
left join artist a on a.artist_id = aw.artist_id 
where a.nationality = 'American';


--------------exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.--------------

select title
from exhibition
where exhibition_id in (
    select exhibition_id
    from exhibitionartworks ea
    join artwork aw on ea.artwork_id = aw.artwork_id
    join artist a on aw.artist_id = a.artist_id
    where a.name in ('Vincent van Gogh', 'Leonardo da Vinci')
    group by exhibition_id
    having count(distinct a.name) = 2
);


--------------all the artworks that have not been included in any exhibition.-------------------------

select title
from artwork
where artwork_id not in (
    select artwork_id from exhibitionartworks
);


/*......using left join and is null ............*/

select aw.title
from artwork aw
left join exhibitionartworks ea on aw.artwork_id = ea.artwork_id
where ea.artwork_id is null;


---------------artists who have created artworks in all available categories.-----------------------

select a.name
from artist a
join artwork aw on a.artist_id = aw.artist_id
group by a.artist_id, a.name
having count(distinct aw.category_id) = (
    select count(*) from categories
);


---------------List the total number of artworks in each category.--------------

select name,
    (   select count(*) 
        from artwork aw 
        where aw.category_id = c.category_id
    ) as total_artworks
from categories c;


--------------the artists who have more than 2 artworks in the gallery.-----------

select name
from artist
where artist_id in (
    select artist_id
    from artwork
    group by artist_id
    having count(artwork_id) >= 2
);


-------------List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.-----------------------

select c.name, avg(aw.year) as average_year
from categories c
join artwork aw on c.category_id = aw.category_id
group by c.name
having count(aw.artwork_id) > 1;


---------the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.--------

select title
from artwork
where artwork_id in (
    select artwork_id
    from exhibitionartworks
    where exhibition_id = (
        select exhibition_id
        from exhibition
        where title = 'Modern Art Masterpieces'
    )
);


---------the categories where the average year of artworks is greater than the average year of all artworks.------------------

select c.name, avg(aw.year) as average_year
from categories c
join artwork aw on c.category_id = aw.category_id
group by c.name
having avg(aw.year) > (
    select avg(year) from artwork
);


---------the artworks that were not exhibited in any exhibition.---------

select title
from artwork
where artwork_id not in (
    select artwork_id from exhibitionartworks
);


---------artists who have artworks in the same category as "Mona Lisa."-----------------


select a.name as artist_name, count(aw.artwork_id) as artwork_count
from artist a
join artwork aw on a.artist_id = aw.artist_id
where aw.category_id = (
    select category_id
    from artwork
    where title = 'Mona Lisa'
)
group by a.name;


----------the names of artists and the number of artworks they have in the gallery.--------------


select a.name as artist_name, count(aw.artwork_id) as artwork_count
from artist a
left join artwork aw on a.artist_id = aw.artist_id
group by a.name;







































































