from flask import Blueprint, render_template, request, g, redirect, url_for, flash
from exts import db
from models import Itinerary, Plan

bp = Blueprint("plan", __name__, url_prefix="/")

@bp.route("/", methods=["GET", "POST"])
def verify():
    if request.method == "POST":
        access_code = request.form.get("access_code")
        plan = Plan.query.filter_by(access_code=access_code).first()
        if plan:
            return redirect(url_for("itinerary.show_itineraries", plan_id=plan.id))
        else:
            flash("Invalid access code. Please try again.")
    return render_template("verify.html")