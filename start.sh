#!/bin/bash

work_dir=/app/KindleEar
config_py=$work_dir/config.py
dev_appserver=/app/google_appengine/dev_appserver.py

# test environment

# KINDLEEAR_EMAIL
if [ ${#KINDLEEAR_EMAIL} -eq 0 ] 
then
	echo "error: KINDLEEAR_EMAIL hasn't been set!"
fi

# KKINDLEEAR_SMTP_SERVER
if [ ${#KINDLEEAR_SMTP_SERVER} -eq 0 ] 
then
	echo "error: KINDLEEAR_SMTP_SERVER hasn't been set!"
fi

# KINDLEEAR_SMTP_PORT
if [ ${#KINDLEEAR_SMTP_PORT} -eq 0 ] 
then
	echo "error: KINDLEEAR_SMTP_PORT hasn't been set!"
fi

# KINDLEEAR_SMTP_PASSWORD
if [ ${#KINDLEEAR_SMTP_PASSWORD} -eq 0 ] 
then
	echo "error: KINDLEEAR_SMTP_PASSWORD hasn't been set!"
fi

# KINDLEEAR_DOMAIN
if [ ${#KINDLEEAR_DOMAIN} -eq 0 ] 
then
	echo "error: KINDLEEAR_DOMAIN hasn't been set!"
fi

# change settings
sed -i "s/^SRC_EMAIL\ =\ \".*\"/SRC_EMAIL\ =\ \"$KINDLEEAR_EMAIL\"/g" $config_py
sed -i "s|^DOMAIN\ =\ \".*\"|DOMAIN\ =\ \"$KINDLEEAR_DOMAIN\"|g" $config_py

python $dev_appserver --port=8080 --host=0.0.0.0 --enable_host_checking=false \
	--smtp_host=$KINDLEEAR_SMTP_SERVER --smtp_port=$KINDLEEAR_SMTP_PORT \
	--smtp_user=$KINDLEEAR_EMAIL --smtp_password=$KINDLEEAR_SMTP_PASSWORD \
	$work_dir/app.yaml $work_dir/module-worker.yaml
