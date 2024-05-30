# Database configuration
HOSTNAME = "localhost"  # IP address
PORT = 3306  # Port number
USERNAME = "root"  # Username
PASSWORD = "rootroot"  # Password
DATABASE = "holiday_planner"  # Database name
DB_URI = 'mysql+pymysql://{}:{}@{}:{}/{}?charset=utf8'.format(USERNAME, PASSWORD, HOSTNAME, PORT, DATABASE)
SQLALCHEMY_DATABASE_URI = DB_URI