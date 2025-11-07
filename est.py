'''
est.py

EST server functionality blueprint

James Jenkins 2025
'''

# Flask imports
from flask import Blueprint, current_app, request, abort

# Other imports
import subprocess

est_blueprint = Blueprint('est', __name__)

def route_enabled(location, server_config):
        '''Check each server for a matching url_prefix and enabled route status. If both are found, the route is enabled.'''
        url_prefix, route = f"{location}".rsplit("/", 1) # Split the current location object into server prefix and route

        for server in server_config:
                if server["url_prefix"] == url_prefix and server["endpoints_enabled"][route] == True:
                        return True

        return False

@est_blueprint.route('/cacerts') # MUST
def cacerts():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        
        return "cacerts reached"

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