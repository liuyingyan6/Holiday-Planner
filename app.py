from flask import Flask
import config
from exts import db
from models import User
from blueprints.packing import bp as packing_bp
from blueprints.itinerary import bp as itinerary_bp
from blueprints.plan import bp as plan_bp
from flask_migrate import Migrate

app = Flask(__name__)
app.config.from_object(config)
db.init_app(app)

migrate = Migrate(app, db)

app.register_blueprint(packing_bp)
app.register_blueprint(itinerary_bp)
app.register_blueprint(plan_bp)

# for flash in plan.py
app.config['SECRET_KEY'] = 'my_secret_key_123'



if __name__ == '__main__':
    app.run()
