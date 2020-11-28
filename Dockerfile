FROM python:2.7-alpine
COPY . /app
WORKDIR /app
RUN apk add --no-cache --virtual build-dep wget unzip g++ gcc python-dev jpeg-dev zlib-dev libxslt-dev && \
	pip install pillow lxml jinja2 pycrypto && \
	wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.91.zip && \
	unzip google_appengine_1.9.91.zip && \
	rm google_appengine_1.9.91.zip && \
	echo 'opt_in: false\ntimestamp: 0.0' > /root/.appcfg_nag && \
	apk del build-dep
EXPOSE 8080
CMD ./start.sh
