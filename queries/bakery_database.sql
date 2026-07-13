CREATE DATABASE bakery;
USE bakery;


CREATE TABLE ingredient (
    ingredient_id VARCHAR(20) PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL
);


CREATE TABLE product_category (
    category_id VARCHAR(20) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);


CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(50) UNIQUE,
    location VARCHAR(100),
    joined_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    customer_type VARCHAR(50) NOT NULL
);


CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category_id VARCHAR(20),
    unit_price DECIMAL(10 , 2 ) CHECK (unit_price> 0) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_category(category_id) 
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delivery_date DATE NOT NULL,
    payment_mode ENUM ('Cash', 'Mobile Money', 'Card') NOT NULL,
    delivery_mode ENUM ('Pickup', 'Delivery') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);



CREATE TABLE order_details (
    orderdetails_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    unit_price INT CHECK (unit_price > 0) NOT NULL,
    quantity INT CHECK(quantity > 0) NOT NULL,
    discount DECIMAL(5,2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



CREATE TABLE product_ingredient (
    pi_id VARCHAR(20) PRIMARY KEY,
    ingredient_id VARCHAR(20),
    product_id VARCHAR(20),
    ingredient_quantity INT CHECK(ingredient_quantity > 0) NOT NULL,
    product_quantity INT CHECK(product_quantity > 0) NOT NULL,
    production_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE purchases (
    purchase_id VARCHAR(20) PRIMARY KEY,
    ingredient_id VARCHAR(20),
    ingredient_size DECIMAL(10,3),
    ingredient_unit_price DECIMAL(10,2) NOT NULL,
    ingredient_quantity INT CHECK (ingredient_quantity > 0) NOT NULL,
    purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id)
);




