import pyodbc
from dao.iordermanagementrepository import IOrderManagementRepository
from Entity.user import User
from Entity.electronics import Electronics
from Entity.clothing import Clothing
from exception.usernotfoundexception import UserNotFoundException
from exception.ordernotfoundexception import OrderNotFoundException
from exception.productcreationexception import ProductCreationException
from util.dbconnection import get_db_connection

class OrderProcessor(IOrderManagementRepository):
    def __init__(self):
        self.conn = get_db_connection()
        self.cursor = self.conn.cursor()

    def create_user(self, user: User):
        self.cursor.execute("INSERT INTO Users (userId, username, password, role) VALUES (?,?,?,?)",
                            user.user_id, user.username, user.password, user.role)
        self.conn.commit()
        print("✅ User created")

    def create_product(self, user: User, product):
        if user.role.lower() != "admin":
            raise ProductCreationException("Only Admin can create products.")
        self.cursor.execute("INSERT INTO Product (productId, productName, description, price, quantityInStock, type) VALUES (?,?,?,?,?,?)",
                            product.product_id, product.product_name, product.description,
                            product.price, product.quantity_in_stock, product.product_type)
        if isinstance(product, Electronics):
            self.cursor.execute("INSERT INTO Electronics (productId, brand, warrantyPeriod) VALUES (?,?,?)",
                                product.product_id, product.brand, product.warranty_period)
        if isinstance(product, Clothing):
            self.cursor.execute("INSERT INTO Clothing (productId, size, color) VALUES (?,?,?)",
                                product.product_id, product.size, product.color)
        self.conn.commit()
        print("✅ Product created")

    def _check_user_exists(self, user: User):
        row = self.cursor.execute("SELECT userId FROM Users WHERE userId = ?", user.user_id).fetchone()
        print(f"DEBUG: Checking user {user.user_id} — Found: {row}")
        if not row:
            raise UserNotFoundException(f"User with ID {user.user_id} not found.")

    def create_order(self, user: User, products):
        self._check_user_exists(user)

        # Use OUTPUT to get inserted ID
        self.cursor.execute("INSERT INTO [Order] (userId) OUTPUT INSERTED.orderId VALUES (?)", user.user_id)
        order_id = self.cursor.fetchone()[0]

        for item, qty in products:
            self.cursor.execute("INSERT INTO OrderDetails (orderId, productId, quantity) VALUES (?,?,?)",
                                order_id, item.product_id, qty)
        self.conn.commit()
        print(f"✅ Order {order_id} created successfully.")

    def cancel_order(self, user_id, order_id):
        self.cursor.execute("DELETE FROM OrderDetails WHERE orderId = ?", order_id)
        rows_deleted = self.cursor.execute("DELETE FROM [Order] WHERE orderId = ? AND userId = ?", order_id, user_id).rowcount
        self.conn.commit()
        if rows_deleted == 0:
            raise OrderNotFoundException(f"Order {order_id} not found or not owned by user {user_id}.")
        print(f"✅ Order {order_id} cancelled.")

    def get_all_products(self):
        rows = self.cursor.execute("SELECT productId, productName, price, type FROM Product").fetchall()
        for row in rows:
            print(row)

    def get_order_by_user(self, user: User):
        self._check_user_exists(user)
        rows = self.cursor.execute(
            "SELECT o.orderId, p.productName, od.quantity "
            "FROM [Order] o "
            "JOIN OrderDetails od ON o.orderId = od.orderId "
            "JOIN Product p ON od.productId = p.productId "
            "WHERE o.userId = ?", user.user_id
        ).fetchall()

        if not rows:
            print("No orders found for this user.")
            return

        print(f"Orders for User ID {user.user_id}:")
        for row in rows:
            print(f"Order ID: {row[0]}, Product: {row[1]}, Quantity: {row[2]}")

