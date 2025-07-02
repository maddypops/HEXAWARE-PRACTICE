from dao.orderprocessor import OrderProcessor
from Entity.user import User
from Entity.electronics import Electronics
from Entity.clothing import Clothing
from exception.usernotfoundexception import UserNotFoundException
from exception.productcreationexception import ProductCreationException

def main_menu():
    proc = OrderProcessor()

    while True:
        print("\n=== Order Management System ===")
        print("1. Create User")
        print("2. Create Product (Admin Only)")
        print("3. Create Order")
        print("4. Cancel Order")
        print("5. View All Products")
        print("6. View Orders by User")
        print("7. Exit")

        ch = input("Enter your choice: ")

        try:
            if ch == '1':
                u = User(int(input("User ID: ")), input("Username: "), input("Password: "), input("Role (Admin/User): "))
                proc.create_user(u)

            elif ch == '2':
                admin_id = int(input("Enter Admin User ID: "))
                admin = User(admin_id, input("Username: "), '', 'Admin')

                pid = int(input("Product ID: "))
                name = input("Product Name: ")
                desc = input("Description: ")
                price = float(input("Price: "))
                qty = int(input("Quantity: "))
                ptype = input("Product Type (Electronics/Clothing): ")

                if ptype.lower() == 'electronics':
                    brand = input("Brand: ")
                    warranty = int(input("Warranty (Months): "))
                    product = Electronics(pid, name, desc, price, qty, brand, warranty)
                elif ptype.lower() == 'clothing':
                    size = input("Size: ")
                    color = input("Color: ")
                    product = Clothing(pid, name, desc, price, qty, size, color)
                else:
                    print("Invalid product type.")
                    continue

                proc.create_product(admin, product)

            elif ch == '3':
                uid = int(input("User ID: "))
                user = User(uid, '', '', '')
                proc.get_all_products()

                product_list = []
                while True:
                    pid = int(input("Enter Product ID to order: "))
                    qty = int(input("Enter Quantity: "))
                    row = proc.cursor.execute("SELECT * FROM Product WHERE productId=?", pid).fetchone()
                    if row[5] == 'Electronics':
                        product = Electronics(row[0], row[1], row[2], row[3], row[4], '', 0)
                    else:
                        product = Clothing(row[0], row[1], row[2], row[3], row[4], '', '')
                    product_list.append((product, qty))

                    if input("Add more products? (y/n): ") != 'y':
                        break

                proc.create_order(user, product_list)

            elif ch == '4':
                uid = int(input("Enter User ID: "))
                oid = int(input("Enter Order ID: "))
                proc.cancel_order(uid, oid)

            elif ch == '5':
                proc.get_all_products()

            elif ch == '6':
                uid = int(input("Enter User ID: "))
                user = User(uid, '', '', '')
                proc.get_order_by_user(user)

            elif ch == '7':
                print("Thank you! Exiting.")
                break

            else:
                print("Invalid choice!")

        except Exception as e:
            print(f"Error: {e}")

if __name__ == "__main__":
    main_menu()


class Example:
    count = 0

    def __init__(self):
        Example.count += 2

obj1 = Example()
Example.count -= 1
obj2 = Example()
print(Example.count)

