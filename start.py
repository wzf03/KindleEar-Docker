# coding:utf-8
import json5
import os
import sys
import re

CONFIG_PATH = "/app/data/config.json"

# load config.json
config = {}
if os.path.isfile(CONFIG_PATH):
    config_file = open(CONFIG_PATH)
    config = json5.loads(config_file.read())
    config_file.close()

# load env
env = os.environ

# necessary settings
EMAIL = config.get("email") or env.get("KINDLEEAR_EMAIL")
SMTP_SERVER = config.get("smtpServer") or env.get("KINDLEEAR_SMTP_SERVER")
SMTP_PORT = config.get("smtpPort") or env.get("KINDLEEAR_SMTP_PORT")
SMTP_PASSWORD = config.get("smtpPassword") or env.get(
    "KINDLEEAR_SMTP_PASSWORD")
DOMAIN = config.get("domain") or env.get("KINDLEEAR_DOMAIN")

if EMAIL == None or SMTP_SERVER == None or SMTP_PORT == None or SMTP_PORT == None or SMTP_PASSWORD == None or DOMAIN == None:
    print "ERROR: config.json isn't completed"
    sys.exit(1)

# change settings
CONFIG_PY = "/app/KindleEar/config.py"
os.system("""sed -i "s|^SRC_EMAIL\\ =\\ \\".*\\"|SRC_EMAIL\\ =\\ \\"{}\\"|g" {}""".format(EMAIL, CONFIG_PY))
os.system(
    """sed -i "s|^DOMAIN\\ =\\ \\".*\\"|DOMAIN\\ =\\ \\"{}\\"|g" {}""".format(DOMAIN, CONFIG_PY))

# run KindleEar
exec_template = "python /app/google_appengine/dev_appserver.py --datastore_path=/app/data/datastore --port=8080 --host=0.0.0.0 --enable_host_checking=false --smtp_host={} --smtp_port={} --smtp_user={} --smtp_password={} /app/KindleEar/app.yaml /app/KindleEar/module-worker.yaml"
os.system("crond")
os.system(exec_template.format(SMTP_SERVER, SMTP_PORT, EMAIL, SMTP_PASSWORD))
