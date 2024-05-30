from flask import Flask
import config
from exts import db
from models import User
from blueprints.packing import bp as packing_bp
from flask_migrate import Migrate

app = Flask(__name__)
app.config.from_object(config)
db.init_app(app)

migrate = Migrate(app, db)

app.register_blueprint(packing_bp)

@app.route('/')
def user():
    users = User.query.all()
    user_info = "<br>".join([f"{user.first_name} {user.last_name}, Email: {user.email}" for user in users])
    return f"Hello World!<br><br>User Info:<br>{user_info}"


if __name__ == '__main__':
    app.run()
