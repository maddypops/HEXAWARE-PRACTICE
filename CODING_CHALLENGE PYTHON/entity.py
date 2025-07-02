class Product:
    def __init__(self, product_id, product_name, description, price, quantity_in_stock, product_type):
        self.product_id = product_id
        self.product_name = product_name
        self.description = description
        self.price = price
        self.quantity_in_stock = quantity_in_stock
        self.product_type = product_type  # 'Electronics' or 'Clothing'


class Electronics(Product):
    def __init__(self, product_id, product_name, description, price, quantity_in_stock, brand, warranty_period):
        super().__init__(product_id, product_name, description, price, quantity_in_stock, 'Electronics')
        self.brand = brand
        self.warranty_period = warranty_period  # in months


class Clothing(Product):
    def __init__(self, product_id, product_name, description, price, quantity_in_stock, size, color):
        super().__init__(product_id, product_name, description, price, quantity_in_stock, 'Clothing')
        self.size = size
        self.color = color


class User:
    def __init__(self, user_id, username, password, role):
        self.user_id = user_id
        self.username = username
        self.password = password
        self.role = role  # 'Admin' or 'User'


# ==== Exception Classes ====

class UserNotFoundException(Exception):
    pass


class OrderNotFoundException(Exception):
    pass


class ProductCreationException(Exception):
    pass


# ==== DAO Interface ====

class IOrderManagementRepository:
    def create_user(self, user):
        pass

    def create_product(self, user, product):
        pass

    def create_order(self, user, product_list):
        pass

    def cancel_order(self, user_id, order_id):
        pass

    def get_all_products(self):
        pass

    def get_order_by_user(self, user):
        pass


# ==== DAO Implementation ====

class OrderProcessor(IOrderManagementRepository):
    def __init__(self):
        self.users = []
        self.products = []
        self.orders = {}  # user_id : list of (order_id, product_list)
        self.next_order_id = 1

    def create_user(self, user):
        for u in self.users:
            if u.username == user.username:
                print("User already exists.")
                return
        self.users.append(user)
        print("✅ User created successfully.")

    def create_product(self, user, product):
        if user.role.lower() != "admin":
            raise ProductCreationException("Only Admin can create products.")
        self.products.append(product)
        print("✅ Product created successfully.")

    def create_order(self, user, product_list):
        if user not in self.users:
            raise UserNotFoundException("User not found.")
        if user.user_id not in self.orders:
            self.orders[user.user_id] = []
        self.orders[user.user_id].append((self.next_order_id, product_list))
        print(f"✅ Order ID {self.next_order_id} created successfully for user {user.username}.")
        self.next_order_id += 1

    def cancel_order(self, user_id, order_id):
        if user_id not in self.orders:
            raise UserNotFoundException("User ID not found.")
        order_list = self.orders[user_id]
        for order in order_list:
            if order[0] == order_id:
                order_list.remove(order)
                print(f"✅ Order ID {order_id} cancelled successfully.")
                return
        raise OrderNotFoundException("Order ID not found.")

    def get_all_products(self):
        if not self.products:
            print("No products available.")
        for p in self.products:
            print(f"ID: {p.product_id}, Name: {p.product_name}, Price: {p.price}, Type: {p.product_type}")

    def get_order_by_user(self, user):
        if user.user_id not in self.orders:
            raise UserNotFoundException("No orders found for this user.")
        print(f"✅ Orders for user {user.username}:")
        for order in self.orders[user.user_id]:
            order_id, products = order
            print(f"Order ID: {order_id}")
            for p in products:
                print(f"Product: {p.product_name}, Price: {p.price}")