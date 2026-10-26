CREATE DATABASE hotel_booking;

USE hotel_booking;

CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    address VARCHAR(200),
    rating DECIMAL(2,1)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT,
    room_number VARCHAR(10),
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    availability VARCHAR(20) DEFAULT 'Available',
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

INSERT INTO Hotels
(hotel_name, city, address, rating)
VALUES
('Grand Palace Hotel', 'Hyderabad', 'Banjara Hills', 4.5),
('Sunrise Residency', 'Vijayawada', 'MG Road', 4.2),
('Royal Comfort Inn', 'Bangalore', 'Whitefield', 4.6),
('Green Valley Hotel', 'Chennai', 'T Nagar', 4.0),
('Ocean View Resort', 'Goa', 'Calangute Beach', 4.8);

INSERT INTO Rooms
(hotel_id, room_number, room_type, price_per_night, availability)
VALUES
(1, '101', 'Deluxe', 3500.00, 'Available'),
(1, '102', 'Suite', 5500.00, 'Available'),
(2, '201', 'Standard', 2200.00, 'Available'),
(2, '202', 'Deluxe', 3200.00, 'Booked'),
(3, '301', 'Suite', 6000.00, 'Available'),
(3, '302', 'Deluxe', 4000.00, 'Available'),
(4, '401', 'Standard', 2000.00, 'Available'),
(4, '402', 'Deluxe', 3000.00, 'Booked'),
(5, '501', 'Suite', 7500.00, 'Available'),
(5, '502', 'Deluxe', 5000.00, 'Available');

INSERT INTO Customers
(customer_name, email, phone)
VALUES
('Rahul', 'rahul@gmail.com', '9876543210'),
('Priya', 'priya@gmail.com', '9876543211'),
('Kiran', 'kiran@gmail.com', '9876543212'),
('Sneha', 'sneha@gmail.com', '9876543213'),
('Arjun', 'arjun@gmail.com', '9876543214');

INSERT INTO Bookings
(customer_id, room_id, check_in, check_out, booking_status)
VALUES
(1, 1, '2026-09-01', '2026-09-03', 'Confirmed'),
(2, 3, '2026-09-05', '2026-09-07', 'Confirmed'),
(3, 5, '2026-09-10', '2026-09-13', 'Confirmed'),
(4, 7, '2026-09-15', '2026-09-17', 'Confirmed'),
(5, 9, '2026-09-20', '2026-09-23', 'Confirmed');

SHOW TABLES;

SELECT * FROM Hotels;

SELECT * FROM Rooms;

SELECT * FROM Customers;

SELECT * FROM Bookings;

SELECT
    b.booking_id,
    c.customer_name,
    c.email,
    h.hotel_name,
    h.city,
    r.room_number,
    r.room_type,
    r.price_per_night,
    b.check_in,
    b.check_out,
    b.booking_status
FROM Bookings b
JOIN Customers c
    ON b.customer_id = c.customer_id
JOIN Rooms r
    ON b.room_id = r.room_id
JOIN Hotels h
    ON r.hotel_id = h.hotel_id
ORDER BY b.booking_id;

SELECT
    b.booking_id,
    c.customer_name,
    h.hotel_name,
    r.room_type,
    r.price_per_night,
    DATEDIFF(b.check_out, b.check_in) AS nights,
    (DATEDIFF(b.check_out, b.check_in) * r.price_per_night) AS total_amount
FROM Bookings b
JOIN Customers c
    ON b.customer_id = c.customer_id
JOIN Rooms r
    ON b.room_id = r.room_id
JOIN Hotels h
    ON r.hotel_id = h.hotel_id
ORDER BY b.booking_id;