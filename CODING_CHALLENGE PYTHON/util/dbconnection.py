import pyodbc

def get_db_connection():

    try:
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=MADDYPOPS;'
            'DATABASE=orders;'
            'Trusted_Connection=yes;'
        )
        print("✅ Database connection successful!")
        return conn
    except pyodbc.Error as e:
        print("❌ Error connecting to the database:", e)
        return None
