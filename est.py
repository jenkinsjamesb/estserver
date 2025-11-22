'''
est.py

EST server functionality blueprint

James Jenkins 2025
'''

# Flask imports
from flask import Blueprint, current_app, request, abort, Response

# Other imports
import subprocess

est_blueprint = Blueprint('est', __name__)

def ca_path(location, server_config):
        '''Check each server for a matching url_prefix and return its CA directory.'''
        url_prefix, route = f"{location}".rsplit("/", 1) # Split the current location object into server prefix and route

        for server in server_config:
                if server["url_prefix"] == url_prefix:
                        return server["ca"]

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

        # call openssl_util or get files
        ca_path = ca_path(request.url_rule.rule, current_app.config["estconfig"]["servers"])
        
        open(ca_path, "rb")
        

        if status == 0:
                return Response(
                        response_bytes,
                        mimetype='application/pkcs7-mime'
                )
        else:
                abort(500)

@est_blueprint.route('/simpleenroll') # MUST
def simpleenroll():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        pass

@est_blueprint.route('/simplereenroll') # MUST
def simplereenroll():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        pass

@est_blueprint.route('/fullcmc') # OPT
def fullcmc():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        pass

@est_blueprint.route('/serverkeygen') # OPT
def serverkeygen():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        pass

@est_blueprint.route('/csrattrs') # OPT
def csrattrs():
        if route_enabled(request.url_rule.rule, current_app.config["estconfig"]["servers"]) == False:
                abort(405)
        pass