from abc import ABC, abstractmethod

class IOrderManagementRepository(ABC):
    @abstractmethod
    def create_user(self, user): ...

    @abstractmethod
    def create_product(self, user, product): ...

    @abstractmethod
    def create_order(self, user, products): ...

    @abstractmethod
    def cancel_order(self, user_id, order_id): ...

    @abstractmethod
    def get_all_products(self): ...

    @abstractmethod
    def get_order_by_user(self, user): ...
