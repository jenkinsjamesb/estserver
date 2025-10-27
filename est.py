'''
est.py

EST server functionality blueprint

James Jenkins 2025
'''

# Flask imports
from flask import Blueprint

# Other imports
import subprocess

est_blueprint = Blueprint('est', __name__)

@est_blueprint.route('/cacerts') # MUST
def cacerts():
        pass

@est_blueprint.route('/simpleenroll') # MUST
def simpleenroll():
        pass

@est_blueprint.route('/simplereenroll') # MUST
def simplereenroll():
        pass

@est_blueprint.route('/fullcmc') # OPT
def fullcmc():
        pass

@est_blueprint.route('/serverkeygen') # OPT
def serverkeygen():
        pass

@est_blueprint.route('/csrattrs') # OPT
def csrattrs():
        pass