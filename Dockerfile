FROM alpine:latest

COPY . /app

WORKDIR /app

RUN apk update && \
    apk add --no-cache python2 jpeg zlib libxslt && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    apk add --no-cache --virtual build-dep wget unzip g++ gcc python2-dev jpeg-dev zlib-dev libxslt-dev && \
    pip install pillow lxml jinja2 pycrypto && \
    wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.91.zip && \
    unzip google_appengine_1.9.91.zip && \
    rm google_appengine_1.9.91.zip && \
    echo -e 'opt_in: false\ntimestamp: 0.0' > /root/.appcfg_nag && \
    apk del build-dep
EXPOSE 8080

CMD sh ./start.sh