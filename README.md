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
- Python 3.x
- MySQL

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/shopnow-dbms.git
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

## License
This project is licensed under the MIT License.

## Contact
For any questions or inquiries, please contact:
- Nabh Rajput: [your-email@example.com]

