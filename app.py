'''
app.py

EST server main flask file to be deployed through Gunicorn

James Jenkins 2025
'''

# Flask imports
from flask import Flask, render_template, abort
from est import est_blueprint

# Other imports
import json

# Initialize app
app = Flask(__name__)

# Load config file into app config
with open("config.json", "r") as config_file:
        app.config["estconfig"] = json.loads(config_file.read())

# Create est server at each server location directive
for server in app.config["estconfig"]["servers"]:
        print(f"Starting EST server at {server['url_prefix']}")
        app.register_blueprint(est_blueprint, url_prefix=server["url_prefix"])

# Route / : Web interface, should show signed certs, log, offer revocation
@app.route("/", methods=["GET", "POST"]) 
def est_ui():
        if app.config["estconfig"]["enable_ui"] == False:
                return abort(405)