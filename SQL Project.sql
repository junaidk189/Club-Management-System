create database club ;
use club ;

CREATE TABLE Members(
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    join_date DATE,
    membership_type VARCHAR(50),
    status VARCHAR(20)
);



CREATE TABLE Payments(
    payment_id INT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode VARCHAR(30),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    location VARCHAR(100),
    fee DECIMAL(10,2)
);


CREATE TABLE Reservations(
    reservation_id INT PRIMARY KEY,
    member_id INT,
    event_id INT,
    reservation_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);


INSERT INTO Members VALUES
(1,'Amit Sharma','amit@gmail.com','9876543210','2024-01-10','Regular','Active'),
(2,'Rahul Verma','rahul@gmail.com','9876543211','2024-01-12','Premium','Active'),
(3,'Neha Singh','neha@gmail.com','9876543212','2024-01-15','Regular','Inactive'),
(4,'Pooja Mehta','pooja@gmail.com','9876543213','2024-01-18','Premium','Active'),
(5,'Rohit Kumar','rohit@gmail.com','9876543214','2024-01-20','Regular','Active'),
(6,'Anjali Gupta','anjali@gmail.com','9876543215','2024-01-22','Premium','Active'),
(7,'Vikas Jain','vikas@gmail.com','9876543216','2024-01-25','Regular','Active'),
(8,'Kiran Patel','kiran@gmail.com','9876543217','2024-01-28','Premium','Inactive'),
(9,'Suresh Rao','suresh@gmail.com','9876543218','2024-02-01','Regular','Active'),
(10,'Sneha Iyer','sneha@gmail.com','9876543219','2024-02-05','Premium','Active'),
(11,'Manoj Das','manoj@gmail.com','9876543220','2024-02-08','Regular','Active'),
(12,'Rina Paul','rina@gmail.com','9876543221','2024-02-10','Premium','Active'),
(13,'Arjun Malhotra','arjun@gmail.com','9876543222','2024-02-12','Regular','Inactive'),
(14,'Simran Kaur','simran@gmail.com','9876543223','2024-02-15','Premium','Active'),
(15,'Nitin Joshi','nitin@gmail.com','9876543224','2024-02-18','Regular','Active');

INSERT INTO Payments VALUES
(1,1,500,'2024-01-11','Cash'),
(2,2,1200,'2024-01-13','Credit Card'),
(3,3,300,'2024-01-16','UPI'),
(4,4,1500,'2024-01-19','Credit Card'),
(5,5,400,'2024-01-21','Cash'),
(6,6,2000,'2024-01-23','Credit Card'),
(7,7,350,'2024-01-26','UPI'),
(8,8,1800,'2024-01-29','Cash'),
(9,9,450,'2024-02-02','Credit Card'),
(10,10,1600,'2024-02-06','UPI'),
(11,11,500,'2024-02-09','Cash'),
(12,12,1400,'2024-02-11','Credit Card'),
(13,13,300,'2024-02-13','UPI'),
(14,14,1700,'2024-02-16','Cash'),
(15,15,600,'2024-02-19','Credit Card'); 

INSERT INTO Events VALUES
(1,'Music Night','2024-03-01','Club Hall',500),
(2,'Dance Party','2024-03-05','Main Stage',700),
(3,'Yoga Session','2024-03-10','Wellness Room',300),
(4,'Comedy Show','2024-03-15','Auditorium',600),
(5,'Tech Meetup','2024-03-20','Conference Room',400),
(6,'Food Festival','2024-03-25','Open Ground',800),
(7,'Fitness Camp','2024-03-28','Gym Area',350),
(8,'Art Workshop','2024-04-02','Art Studio',450),
(9,'Startup Talk','2024-04-05','Conference Room',500),
(10,'Movie Night','2024-04-08','Club Hall',300),
(11,'Gaming Event','2024-04-12','Gaming Zone',600),
(12,'Book Reading','2024-04-15','Library',200),
(13,'Photography Walk','2024-04-18','City Park',400),
(14,'DJ Night','2024-04-22','Main Stage',900),
(15,'Charity Event','2024-04-25','Community Hall',250);

INSERT INTO Reservations VALUES
(1,1,1,'2024-02-20','Confirmed'),
(2,2,2,'2024-02-21','Confirmed'),
(3,3,3,'2024-02-22','Cancelled'),
(4,4,4,'2024-02-23','Confirmed'),
(5,5,5,'2024-02-24','Confirmed'),
(6,6,6,'2024-02-25','Confirmed'),
(7,7,7,'2024-02-26','Confirmed'),
(8,8,8,'2024-02-27','Cancelled'),
(9,9,9,'2024-02-28','Confirmed'),
(10,10,10,'2024-03-01','Confirmed'),
(11,11,11,'2024-03-02','Confirmed'),
(12,12,12,'2024-03-03','Confirmed'),
(13,13,13,'2024-03-04','Cancelled'),
(14,14,14,'2024-03-05','Confirmed'),
(15,15,15,'2024-03-06','Confirmed');

-- Testing Data 
SELECT * FROM Members;
SELECT * FROM Payments;
SELECT * FROM Events;
SELECT * FROM Reservations;

#1 Get all active members
SELECT * FROM Members
WHERE status = 'Active';

#2 Count total members
SELECT COUNT(*) AS total_members
FROM Members;

#3 Members who have participated in events
SELECT m.full_name, m.email
FROM Members m
JOIN Reservations r ON m.member_id = r.member_id;

#4 Get members with premium membership
SELECT full_name, email
FROM Members
WHERE membership_type = 'Premium';

#5 Get total revenue collected
SELECT SUM(amount) AS total_revenue
FROM Payments;

#6 Get total amount paid by each member
SELECT m.full_name, SUM(p.amount) AS total_paid
FROM Members m
JOIN Payments p ON m.member_id = p.member_id
GROUP BY m.full_name;

#7 Find members who attended events but are inactive now
SELECT  m.full_name
FROM Members m
JOIN Reservations r ON m.member_id = r.member_id
WHERE m.status = 'Inactive';

#8 Members who made payments using Credit Card or Cash
SELECT  m.full_name, m.email, p.payment_mode
FROM Members m
JOIN Payments p ON m.member_id = p.member_id
WHERE p.payment_mode IN ('Credit Card', 'Cash');

#9 Get highest payment made
SELECT MAX(amount) AS highest_payment
FROM Payments;

#10. Count total events
SELECT COUNT(*) AS total_events
FROM Events;

#11. Get confirmed reservations
SELECT * FROM Reservations
WHERE status = 'Confirmed';

#12 Names and email addresses of all Premium members
SELECT full_name, email
FROM Members
WHERE membership_type = 'Premium';

#13 Members who made payments more than 40 rupees
SELECT  m.full_name, m.email, p.amount
FROM Members m
JOIN Payments p ON m.member_id = p.member_id
WHERE p.amount > 40;

SELECT M.full_name
FROM Members M
JOIN Events E ON M.member_id = E.event_id
WHERE membership_type  = 'Premium'
or amount> 40;


