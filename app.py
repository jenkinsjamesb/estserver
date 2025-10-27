'''
app.py

EST server main flask file to be deployed through Gunicorn

James Jenkins 2025
'''

# Flask imports
from flask import Flask
from est import est_blueprint

# Other imports
import yaml

# config vars:
# - which routes are enabled
# - presence of rollover CA
# - CA dirs

app = Flask(__name__)
app.register_blueprint(est_blueprint, url_prefix='/.well-known/est') # FIXME: replace w/ config

# Route / : Web interface, should show signed certs, log, offer revocation
@app.route("/", methods=["GET", "POST"]) 
def est_ui():
    return "<p>Hello, World!</p>"