CREATE DATABASE ecommerce;

\c ecommerce;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password TEXT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    image TEXT,
    description TEXT
);

CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    product_id INT REFERENCES products(id),
    quantity INT DEFAULT 1
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    total NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, price, image, description) VALUES
('Laptop', 55000, 'laptop.jpg', 'Gaming laptop'),
('Phone', 20000, 'phone.jpg', 'Smartphone'),
('Headphones', 2000, 'headphones.jpg', 'Wireless headphones');