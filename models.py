from exts import db
from datetime import datetime


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(100), unique=True)
    phone_number = db.Column(db.String(15), unique=True)
    user_plans = db.relationship('UserPlan', backref='user')
    feedbacks = db.relationship('Feedback', backref='user')


class Plan(db.Model):
    __tablename__ = 'plans'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    access_code = db.Column(db.String(100), unique=True)
    packing_items = db.relationship('PackingItem', backref='plan')
    user_plans = db.relationship('UserPlan', backref='plan')


class UserPlan(db.Model):
    __tablename__ = 'user_plans'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)  # 修正这里的表名
    plan_id = db.Column(db.Integer, db.ForeignKey('plans.id'), nullable=False)


class PackingItem(db.Model):
    __tablename__ = 'packing_items'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    plan_id = db.Column(db.Integer, db.ForeignKey('plans.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))


class Feedback(db.Model):
    __tablename__ = 'feedbacks'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)  # 修正这里的表名
    content = db.Column(db.Text, nullable=False)
    create_date = db.Column(db.DateTime, default=db.func.current_timestamp())
