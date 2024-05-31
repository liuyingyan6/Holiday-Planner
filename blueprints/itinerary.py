from flask import Blueprint, render_template, request, g, redirect, url_for
from exts import db
from models import Itinerary, Plan

bp = Blueprint("itinerary", __name__, url_prefix="/")


@bp.route("/<int:plan_id>/itinerary")
def show_itineraries(plan_id):
    plan = Plan.query.get_or_404(plan_id)
    itineraries = Itinerary.query.filter_by(plan_id=plan_id).all()
    return render_template("itinerary.html", plan=plan, itineraries=itineraries)
