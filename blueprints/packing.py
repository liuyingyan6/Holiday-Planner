from flask import Blueprint, render_template, request, g, redirect, url_for
from exts import db
from models import PackingItem

bp = Blueprint("packing", __name__, url_prefix="/")


@bp.route("/<plan_id>/packing")
def index(plan_id):
    packings = PackingItem.query.filter_by(plan_id=plan_id).all()
    return render_template("packing.html", packings=packings)
