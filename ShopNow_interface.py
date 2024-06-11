import mysql.connector
import datetime 

mydb=mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="Nabh@2003",
    database="shopnow"
)

mycurs=mydb.cursor()
mycurs.execute("USE shopnow")

while(1):
    try:
        print(" SELECT FROM CHOICES GIVEN BELOW")
        print("Enter 1 for viewing customers from a specific state")
        print("Enter 2 for viewing orders made by a specific customer")
        print("ENTER 3 FOR UPDATING products in a specific category")
        print("ENTER 4 FOR VIEWING customers who made orders and payments with their total payment amount")
        print("ENTER 5 FOR DELETING categories with their respective products")
        print("ENTER 6 FOR VIEWING the total revenue generated")
        print("ENTER 7 for viewing products in the customer's wishlist")
        print("ENTER 8 for viewing top 5 customer on the basis of amount spent")
        print("Enter 9 for viewing orders placed within a specific date range")
        print("ENTER 10 for Updating the quantity of a product")
        print("ENTER 11 for Adding Product into Cart")
        print("ENTER 12 For Adding a New Customer")
        print("ENTER 13 to EXIT")
        print()
        inp=int(input("Enter your choice : "))

        if(inp==1): #Enter 1 for viewing customers from a specific state
            sq="SELECT * FROM customer WHERE state =%s;"
            st = input("Enter the State : ")
            print()
            mycurs.execute(sq,(st,))
            myres=mycurs.fetchall()
        
            for i in myres:
                print(f"Customer ID : {i[0]}")
                print(f"Customer Name : {i[1]} {i[2]}")
                print(f"Customer Address : Street No. {i[3]} , {i[4]} - {i[5]}")
                print(f"Email : {i[6]}")
                print(f"Contact No. : {i[7]}")
                print(f"Date of Birth : {i[8]}")
                print(f"Age : {i[9]}")
                print()

        elif(inp==2): #Enter 2 for viewing orders made by a specific customer
            all_cust = "SELECT id, first_name , last_name from customer"
            mycurs.execute(all_cust)
            get_all_cust=mycurs.fetchall()

            print("No.\tID\tFirstName\tLastname")
            no = 1
            for j in get_all_cust:
                print(f"{no}\t{j[0]}\t{j[1]}\t{j[2]}")
                no += 1

            sq="SELECT * FROM orders WHERE cust_id =%s;"

            custid=int(input("Enter the Customer ID : "))
            
            mycurs.execute(sq,(get_all_cust[custid-1][0],))
            myres=mycurs.fetchall()

            #id, order_date, order_time,cust_id,seller_id
            print(f"Following are the orders of {get_all_cust[custid-1][1]} {get_all_cust[custid-1][2]}")
            if(len(myres) != 0):
                for i in myres:
                    print(f"Order ID : {i[0]}")
                    print(f"Order Date : {i[1]}")
                    print(f"Order Time : {i[2]}")
                    print(f"Seller ID : {i[4]}")
                    print()
            else:
                print("No orders Found\n")

        elif inp == 3:  # ENTER 3 FOR UPDATING products in a specific category
    # Display all products in the database
            all_products_query = "SELECT * FROM product"
            mycurs.execute(all_products_query)
            all_products = mycurs.fetchall()

            no = 1
            print("Product ID\tName\tCategory ID\tQuantity\tPrice\tDiscount")
            for product in all_products:
                print(f"{no}\t{product[0]}\t{product[1]}\t{product[2]}\t{product[3]}\t{product[4]}\t{product[5]}")
                no += 1

            # Select the category to update and the new category ID
            category_id = input("\nEnter Category ID to Update: ")
            new_category_id = input("Enter New Category ID: ")

            # Execute the update query on the category table to trigger the update_product_category trigger
            update_category_query = "UPDATE category SET id = %s WHERE id = %s;"
            mycurs.execute(update_category_query, (new_category_id, category_id))
            mydb.commit()

            print("\nCategory Updated\n")

            # Display updated product information
            mycurs.execute(all_products_query)
            updated_products = mycurs.fetchall()

            no = 1
            print("Product ID\tName\tCategory ID\tQuantity\tPrice\tDiscount")
            for product in updated_products:
                print(f"{no}\t{product[0]}\t{product[1]}\t{product[2]}\t{product[3]}\t{product[4]}\t{product[5]}")
                no += 1

            print()



            
        elif(inp==4): #ENTER 4 FOR VIEWING customers who made orders and payments with their total payment amount
            sq='''SELECT c.id, c.first_name, c.last_name, SUM(p.amount) AS total_amount_paid FROM customer c
INNER JOIN payment p ON c.id = p.cust_id
INNER JOIN orders o ON c.id = o.cust_id
GROUP BY c.id, c.first_name, c.last_name;'''
            mycurs.execute(sq)
            myres=mycurs.fetchall()
            for i in myres:
                print(f"Customer ID : {i[0]}")
                print(f"Customer Name : {i[1]} {i[2]}")
                print(f"Total Money Spent : {i[3]}")
                print()

        elif(inp==5): #ENTER 5 FOR DELETING categories with their respective products
            # Display all categories and their products
            all_categories_query = "SELECT * FROM category"
            mycurs.execute(all_categories_query)
            all_categories = mycurs.fetchall()

            no = 1
            print("No.\tCategory ID\tCategory Name")
            for category in all_categories:
                print(f"{no}\t{category[0]}\t{category[1]}")
                no += 1

            category_number = int(input("\nEnter Category Number to Delete: "))

            # Fetch products in the selected category
            category_id_to_delete = all_categories[category_number-1][0]
            products_to_delete_query = "SELECT id FROM product WHERE category_id = %s"
            mycurs.execute(products_to_delete_query, (category_id_to_delete,))
            products_to_delete = mycurs.fetchall()

            # Delete products
            delete_product_query = "DELETE FROM product WHERE category_id = %s"
            mycurs.execute(delete_product_query, (category_id_to_delete,))
            mydb.commit()

            # Delete category
            delete_category_query = "DELETE FROM category WHERE id = %s"
            mycurs.execute(delete_category_query, (category_id_to_delete,))
            mydb.commit()

            print("\nCategory and its products have been deleted successfully.\n")

            all_categories_query = "SELECT * FROM category"
            mycurs.execute(all_categories_query)
            all_categories = mycurs.fetchall()

            no = 1
            print("No.\tCategory ID\tCategory Name")
            for category in all_categories:
                print(f"{no}\t{category[0]}\t{category[1]}")
                no += 1

    
        elif(inp==6): #ENTER 6 FOR VIEWING the total revenue generated
            sq='''SELECT SUM(p.amount) AS total_revenue
FROM payment p
INNER JOIN orders o ON p.order_id = o.id;'''
            mycurs.execute(sq)
            myres=mycurs.fetchall()

            print(f"Total Revenue Generated is {myres[0][0]}\n")

        elif(inp==7): # ENTER 7 for viewing products in the customer's wishlist
            # List of Customers
            all_cust="SELECT * FROM customer;"
            print()
            mycurs.execute(all_cust)
            get_all_cust=mycurs.fetchall()
            print(f"No.\tCustomer ID\tCustomer Name\tContact No.\tDOB\tAge")
            no = 1
            for i in get_all_cust:
                print(f"{no}\t{i[0]}\t{i[1]} {i[2]}\t{i[7]}\t{i[8]}{i[9]}")
                no += 1

            customer_no = int(input("Enter customer No. to view wishlist : "))
            customer_id = get_all_cust[customer_no-1][0]

            # Query to fetch products in customer's wishlist
            wishlist_query = "SELECT p.id, p.name, p.category_id, p.quan_avail, p.price, p.discount \
                            FROM wishlist w \
                            JOIN product p ON w.product_id = p.id \
                            WHERE w.customer_id = %s"
            mycurs.execute(wishlist_query, (customer_id,))
            wishlist_products = mycurs.fetchall()

            # Display wishlist products
            print(f"Products in {get_all_cust[customer_no-1][1]} {get_all_cust[customer_no-1][2]} : {customer_id} Wishlist:")
            print("Product ID\tProd. Name\tCat. ID\tQuantity\tPrice\tDiscount")
            for product in wishlist_products:
                print(f"{product[0]}\t{product[1]}\t{product[2]}\t{product[3]}\t{product[4]}\t{product[5]}")
            print()


        elif(inp==8): #ENTER 8 for viewing top 5 customer on the basis of amount spent
            sq="SELECT c.id, c.first_name, c.last_name, SUM(p.amount) AS total_amount_spent \
            FROM customer c \
            INNER JOIN payment p ON c.id = p.cust_id \
            GROUP BY c.id, c.first_name, c.last_name \
            ORDER BY total_amount_spent DESC \
            LIMIT 5;"

            mycurs.execute(sq)
            myres=mycurs.fetchall()
            no = 1
            for i in myres:
                print(f"Customer Number : {no}")
                print(f"Customer ID : {i[0]}")
                print(f"Customer Name : {i[1]} {i[2]}")
                print(f"Total Amount Spent : {i[3]}")
                print()
                no += 1

        elif(inp==9):  # Enter 9 for viewing orders placed within a specific date range
            start_date = input("Enter start date (YYYY-MM-DD): ")
            end_date = input("Enter end date (YYYY-MM-DD): ")

            # Query to fetch orders within the specified date range
            orders_query = "SELECT * FROM orders WHERE order_date BETWEEN %s AND %s"
            mycurs.execute(orders_query, (start_date, end_date))
            orders_within_range = mycurs.fetchall()

            # Display orders within the date range
            print("Orders Placed Within the Specified Date Range:")
            print("Order ID\tOrder Date\tOrder Time\tCustomer ID\tSeller ID")
            for order in orders_within_range:
                print(f"{order[0]}\t{order[1]}\t{order[2]}\t{order[3]}\t{order[4]}")


        elif(inp==10): # ENTER 10 for Updating the quantity of a product
    # Display all products in the database
            all_products_query = "SELECT * FROM product"
            mycurs.execute(all_products_query)
            all_products = mycurs.fetchall()
            
            print("No.\tProduct ID\tName\tCategory ID\tQuantity\tPrice\tDiscount")
            no = 1
            for product in all_products:
                print(f"{no}\t{product[0]}\t{product[1]}\t{product[2]}\t{product[3]}\t{product[4]}\t{product[5]}")
                no += 1

            # Select the product to update and the new quantity
            product_no = int(input("\nEnter Product No. to Update Quantity: "))
            product_id = all_products[product_no-1][0] 
            new_quantity = input("Enter New Quantity: ")

            # Execute the update query on the product table
            update_quantity_query = "UPDATE product SET quan_avail = %s WHERE id = %s;"
            mycurs.execute(update_quantity_query, (new_quantity, product_id))
            mydb.commit()

            print("\nQuantity Updated\n")

        
        elif(inp == 11):
            all_cust="SELECT * FROM customer;"
            print()
            mycurs.execute(all_cust)
            get_all_cust=mycurs.fetchall()
            print(f"No.\tCustomer ID\tCustomer Name\tContact No.\tDOB\tAge")
            no = 1
            for i in get_all_cust:
                print(f"{no}\t{i[0]}\t{i[1]} {i[2]}\t{i[7]}\t{i[8]}{i[9]}")
                no += 1

            customer_no = int(input("Enter customer No. to add product into cart : "))
            customer_id = get_all_cust[customer_no-1][0]

            print(f"\n Welcome {get_all_cust[customer_no-1][1]} {get_all_cust[customer_no-1][2]}")


            all_products_query = "SELECT * FROM product"
            mycurs.execute(all_products_query)
            all_products = mycurs.fetchall()
            
            print("Product ID\tName\tCategory ID\tQuantity\tPrice\tDiscount")
            no = 1
            for product in all_products:
                print(f"{product[0]}\t{product[1]}\t{product[2]}\t{product[3]}\t{product[4]}\t{product[5]}")
                no += 1

            product_no = int(input("\nEnter Product No. to Add to cart: "))
            product_id = all_products[product_no-1][0]
            new_quantity = int(input("Enter Quantity: "))

            update_quantity_query = "INSERT INTO cart (cust_id, prod_id, quan, cost) VALUES (%s, %s, %s, %s)"
            new_cost = new_quantity * all_products[product_no-1][4]
            values = (customer_id, product_id, new_quantity, new_cost)
            print(values)
            mycurs.execute(update_quantity_query, values)
            mydb.commit()

            
            print("Product Added to cart")

            all_cart = "Select * from cart;"
            mycurs.execute(all_cart)
            get_all_cart = mycurs.fetchall()

            print("Item No.\tCust Id\tQuantity\tCost")
            no = 1
            for order in get_all_cart:
                print(f"{no}\t{order[0]}\t{order[1]}\t{order[2]}\t{order[3]}")
                no += 1

        elif(inp == 12):
            #inserting new customer 
            #INSERT INTO customer (id, first_name, last_name, street_number, pincode, state, email_id, phone_no, dob, age)
            all_cust="SELECT * FROM customer;"
            print()
            mycurs.execute(all_cust)
            get_all_cust=mycurs.fetchall()

            new_customer_id = get_all_cust[len(get_all_cust) - 1][0]
            new_id_no = "C00" + str(int(new_customer_id[3:]) + 1)

            f_name = input("Enter First Name : ")
            l_name = input("Enter Last Name : ")
            s_no = input("Enter Street No. : ")
            pincode = input("Enter Pincode : ")
            state = input("Enter State Name : " )
            email_no = input("Enter Email-ID : ")
            phone_no = input("Enter Phone No. : ")
            dob = input("Enter DOB format (YYYY-MM-DD) : ")
            age = int(dob[0:4]) - datetime.datetime.now().year 
            print(age,type(age))

            hard_code_age = 24
            insert_customer_query = "INSERT INTO customer (id, first_name, last_name, street_number, pincode, state, email_id, phone_no, dob, age) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            values = (new_id_no, f_name, l_name, s_no, pincode, state, email_no, phone_no, dob, hard_code_age)
            mycurs.execute(insert_customer_query, values)
            mydb.commit()

            print("Customer Added")

            all_cust="SELECT * FROM customer;"
            print()
            mycurs.execute(all_cust)
            get_all_cust=mycurs.fetchall()
            print(f"No.\tCustomer ID\tCustomer Name\tContact No.\tDOB\tAge")
            no = 1
            for i in get_all_cust:
                print(f"{no}\t{i[0]}\t{i[1]} {i[2]}\t{i[7]}\t{i[8]}{i[9]}")
                no += 1

        elif(inp==13):
            break
        
        else:
            print("Enter a Vaild Choice")

        print("Thank You visit Again")
    except Exception as e:
        print(f"Error : {e}\n")