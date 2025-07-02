
USE hexa;

insert into screen values
(1, 'Screen A', 'Gold', 100),
(2, 'Screen B', 'Silver', 80),
(3, 'Screen C', 'Platinum', 120);

insert into seat values
(1, 1, 'A1'),
(2, 1, 'A2'),
(3, 2, 'B1'),
(4, 2, 'B2'),
(5, 3, 'C1');

insert into movie values
(1, 'Inception', 'Sci-Fi', 8.8, 'Now Showing', 'url1.jpg'),
(2, 'Avatar', 'Fantasy', 8.0, 'Now Showing', 'url2.jpg'),
(3, 'Oppenheimer', 'Drama', 9.1, 'Upcoming', 'url3.jpg'),
(4, 'The Dark Knight', 'Action', 9.0, 'Now Showing', 'url4.jpg'),
(5, 'Interstellar', 'Sci-Fi', 8.6, 'Upcoming', 'url5.jpg'),
(6, 'The Matrix', 'Sci-Fi', 8.7, 'Now Showing', 'url6.jpg'),
(7, 'Titanic', 'Romance', 7.9, 'Archived', 'url7.jpg'),
(8, 'Dune', 'Sci-Fi', 8.2, 'Now Showing', 'url8.jpg');

insert into moviecast values
(1, 1, 'Leonardo DiCaprio', 'Cobb'),
(2, 1, 'Joseph Gordon-Levitt', 'Arthur'),
(3, 2, 'Sam Worthington', 'Jake Sully'),
(4, 3, 'Cillian Murphy', 'Oppenheimer');


insert into review values
(1, 1, 'Mind-blowing visuals and concept!', '2025-06-01', 'Alice'),
(2, 2, 'Stunning CGI and storyline!', '2025-06-02', 'Bob'),
(3, 1, 'Complex but engaging.', '2025-06-03', 'Charlie'),
(4, 1, 'Nolan at his best, a puzzle worth solving.', '2025-06-13', 'Alice Johnson'),
(5, 2, 'Still a visual marvel even years later.', '2025-06-14', 'Michael Brown'),
(6, 3, 'A heavy but essential story, brilliantly acted.', '2025-06-15', 'Sara Wilson');


insert into show values
(1, 1, 1, '2025-06-10 18:00'),
(2, 2, 2, '2025-06-11 15:00'),
(3, 3, 3, '2025-06-12 20:00');

insert into show_seat values 
(1, 1, 1, 1),
(2, 1, 2, 0),
(3, 2, 3, 1),
(4, 2, 4, 0),
(5, 3, 5, 1);

insert into users values
(1, '     John Doe', 'john@example.com', 9876543210),
(2, '     Jane Smith', 'jane@example.com', 9123456789),
(3, '     Bob Lee', 'bob@example.com', 9988776655),
(4, '     Alice Johnson', 'alice@example.com', 9012345678),
(5, '     Michael Brown', 'michaelb@example.com', 9345678901),
(6, '     Sara Wilson', 'sara.w@example.com', 9765432109);


insert into membership values
(1, 1, 100),
(2, 2, 50),
(3, 3, 150);

insert into booking values 
(1, 1, 1, '2025-06-05 10:00', 500.00),
(2, 2, 2, '2025-06-06 11:00', 400.00),
(3, 3, 3, '2025-06-07 12:00', 600.00);
insert into booking values 
(4, 1, 2, '2025-06-08 14:00', 450.00), 
(5, 2, 3, '2025-06-09 16:30', 550.00), 
(6, 1, 1, '2025-06-11 18:00', 400.00), 
(7, 3, 2, '2024-12-15 19:45', 480.00), 
(8, 3, 1, '2025-01-12 13:15', 300.00);  

insert into ticket values
(1, 1, 1, 'Email', 1, '2025-06-10 17:00'),
(2, 1, 2, 'SMS', 0, NULL),
(3, 2, 3, 'Email', 1, '2025-06-11 14:30');


insert into paymentgateway values
(1, 'Razorpay'),
(2, 'PayPal'),
(3, 'Stripe'),
(4, 'Google Pay');


INSERT INTO payment VALUES
(1, 1, 1, 550.00, '2025-06-01 10:00', 'Success', NULL, 'John Doe', '4111111111111111', '2026-12-01', '123'),
(2, 2, 2, 400.00, '2025-06-02 11:00', 'Failed', 'Card declined', 'Jane Smith', '4222222222222', '2025-11-01', '321'),
(3, 3, 3, 300.50, '2025-06-03 12:30', 'Success', NULL, 'Bob Lee', '4012888888881881', '2027-10-01', '111'),
(4, 1, 1, 550.00, '2025-06-04 15:00', 'Success', NULL, 'John Doe', '5105105105105100', '2028-09-01', '456'),
(5, 2, 2, 400.00, '2025-06-05 09:00', 'Success', NULL, 'Jane Smith', '6011000990139424', '2029-08-01', '789');


INSERT INTO fooditem VALUES
(1, 'Popcorn', 'Salted buttery popcorn', 0),
(2, 'Combo Meal', 'Popcorn + Coke + Nachos', 1),
(3, 'Coke', 'Chilled soft drink', 0),
(4, 'Nachos', 'Cheesy nachos with dip', 0),
(5, 'Hotdog Combo', 'Hotdog + Fries + Drink', 1);


INSERT INTO fooditemsize VALUES
(1, 1, 'Small', 100.00),
(2, 1, 'Large', 150.00),
(3, 3, 'Regular', 60.00),
(4, 3, 'Large', 80.00),
(5, 2, 'Standard Combo', 250.00);


INSERT INTO foodorder VALUES
(1, 1, 1, 1, '2025-06-01 18:00', 310.00, 'Seat Delivery'),
(2, 2, 2, 3, '2025-06-02 19:00', 200.00, 'Pickup'),
(3, 3, 3, 5, '2025-06-03 20:00', 270.00, 'Seat Delivery'),
(4, 1, 1, 2, '2025-06-04 18:30', 150.00, 'Pickup'),
(5, 2, 2, 4, '2025-06-05 21:00', 300.00, 'Seat Delivery');


INSERT INTO foodorderitem VALUES
(1, 1, 1, 2, 2, 150.00),
(2, 1, 3, 3, 1, 60.00),
(3, 2, 4, 4, 1, 80.00),
(4, 3, 2, 5, 1, 250.00),
(5, 5, 5, 5, 1, 300.00);


INSERT INTO pointstransaction VALUES
(1, 1, 500.00, 50, '2025-06-01 10:10', 'Earned'),
(2, 2, 400.00, 40, '2025-06-02 11:15', 'Earned'),
(3, 3, 300.00, 30, '2025-06-03 12:20', 'Earned'),
(4, 1, 200.00, 20, '2025-06-04 09:00', 'Redeemed'),
(5, 2, 100.00, 10, '2025-06-05 14:00', 'Earned');



