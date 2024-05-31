from flask import Blueprint, render_template, request, g, redirect, url_for
from exts import db
from models import PackingItem, User

bp = Blueprint("packing", __name__, url_prefix="/")


@bp.route("/<int:plan_id>/packing")
def index(plan_id):
    packings = PackingItem.query.filter_by(plan_id=plan_id).all()
    users = User.query.all()
    user_dict = {user.id: f"{user.first_name} {user.last_name}" for user in users}
    return render_template("packing.html", packings=packings, users=users, user_dict=user_dict, plan_id=plan_id)


@bp.route("/<int:plan_id>/packing/add", methods=["POST"])
def add_item(plan_id):
    name = request.form.get("name")
    user_id = request.form.get("user_id")
    packing_item = PackingItem(name=name, plan_id=plan_id, user_id=user_id)
    db.session.add(packing_item)
    db.session.commit()
    return redirect(url_for("packing.index", plan_id=plan_id))
