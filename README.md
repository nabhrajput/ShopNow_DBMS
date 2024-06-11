# ShopNow DBMS Project

## Overview
This project is a database management system (DBMS) application for a fictional online shopping platform called ShopNow. It provides various functionalities to manage customers, products, orders, payments, and other related information stored in a MySQL database.

## Features
- View customers from a specific state
- View orders made by a specific customer
- Update products in a specific category
- View customers who made orders and payments along with their total payment amount
- Delete categories along with their respective products
- View total revenue generated
- View products in the customer's wishlist
- View top 5 customers based on the amount spent
- View orders placed within a specific date range
- Update the quantity of a product
- Add product into cart
- Add a new customer

## Setup Instructions

### Prerequisites
- Python 3
- MySQL

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/nabhrajput/shopnow-dbms.git
    cd shopnow-dbms
    ```

2. Install the required Python packages:
    ```bash
    pip install mysql-connector-python
    ```

3. Set up the MySQL database:
    - Create a database named `shopnow`.
    - Create the necessary tables and insert initial data using the provided SQL scripts (if available).

4. Update the MySQL connection details in the script:
    ```python
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Nabh@2003",
        database="shopnow"
    )
    ```

## Usage
1. Run the script:
    ```bash
    python shopnow_interface.py
    ```

2. Follow the on-screen instructions to interact with the database:
    - Enter the corresponding number to perform the desired operation.
    - Provide any additional inputs as prompted.

### Available Operations
1. View customers from a specific state
2. View orders made by a specific customer
3. Update products in a specific category
4. View customers who made orders and payments with their total payment amount
5. Delete categories with their respective products
6. View the total revenue generated
7. View products in the customer's wishlist
8. View top 5 customers based on the amount spent
9. View orders placed within a specific date range
10. Update the quantity of a product
11. Add product into cart
12. Add a new customer
13. Exit

## Project Structure
- `shopnow_interface.py`: Main script containing the interface and functionality to interact with the ShopNow database.

Here is the given database schema in markdown format:

# Database Schema

## Tables

### Customer
- **id**: VARCHAR(10), Primary Key
- **first_name**: VARCHAR(15)
- **last_name**: VARCHAR(15)
- **street_number**: VARCHAR(20)
- **pincode**: VARCHAR(6)
- **state**: VARCHAR(15)
- **email_id**: VARCHAR(50)
- **phone_no**: VARCHAR(10)
- **dob**: DATE
- **age**: INT

### Seller
- **id**: VARCHAR(10), Primary Key
- **first_name**: VARCHAR(15)
- **last_name**: VARCHAR(15)
- **street_number**: VARCHAR(20)
- **pincode**: VARCHAR(6)
- **state**: VARCHAR(15)
- **email_id**: VARCHAR(50)
- **phone_no**: VARCHAR(10)
- **dob**: DATE
- **age**: INT

### Admin
- **id**: VARCHAR(10), Primary Key
- **first_name**: VARCHAR(15)
- **last_name**: VARCHAR(15)
- **street_number**: VARCHAR(20)
- **pincode**: VARCHAR(6)
- **state**: VARCHAR(15)
- **email_id**: VARCHAR(50)
- **phone_no**: VARCHAR(10)
- **dob**: DATE
- **age**: INT

### Orders
- **id**: VARCHAR(10), Primary Key
- **order_date**: DATE
- **order_time**: TIME
- **cust_id**: VARCHAR(10), Foreign Key (customer.id)
- **seller_id**: VARCHAR(10), Foreign Key (seller.id)

### Payment
- **id**: VARCHAR(10), Primary Key
- **amount**: DECIMAL(10,2)
- **pay_date**: DATE
- **pay_time**: TIME
- **cust_id**: VARCHAR(10), Foreign Key (customer.id)
- **order_id**: VARCHAR(10), Foreign Key (orders.id)

### Category
- **id**: VARCHAR(10), Primary Key
- **category_name**: VARCHAR(20), UNIQUE

### Product
- **id**: VARCHAR(10), Primary Key
- **name**: VARCHAR(20)
- **category_id**: VARCHAR(10), Foreign Key (category.id)
- **quan_avail**: INT
- **price**: DECIMAL(10,2)
- **discount**: DECIMAL(5,2)

### Cart
- **cust_id**: VARCHAR(10), Primary Key, Foreign Key (customer.id)
- **prod_id**: VARCHAR(10), Primary Key, Foreign Key (product.id)
- **quan**: INT
- **cost**: DECIMAL(10,2)

### Wishlist
- **product_id**: VARCHAR(10), Primary Key, Foreign Key (product.id)
- **customer_id**: VARCHAR(10), Primary Key, Foreign Key (customer.id)

## Contact
For any questions or inquiries, please contact:
- Nabh Rajput: [nabh21170@iiitd.ac.in]

