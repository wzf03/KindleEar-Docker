# KindleEar-Docker
kindleear's docker image

## Usage

### docker-compose ([recommended](https://github.com/docker/compose))
create `docker-compose.yml` in a new directory
```yaml
version: "3"
services:
  kindleear:
    image: ghcr.io/kunzfw/kindleear:1.26.9
    container_name: kindleear
    environment:
      - KINDLEEAR_EMAIL=youremail
      - KINDLEEAR_SMTP_SERVER=smtp.example.com
      - KINDLEEAR_SMTP_PORT=587
      - KINDLEEAR_SMTP_PASSWORD=password
      - KINDLEEAR_DOMAIN=http://example.com
    ports:
      - 8080:8080
    restart: unless-stopped
```
then run the container using [docker-compose](https://github.com/docker/compose)
```
docker-compose up -d
```

### docker cli

```
docker run -d \
  --name=kindleear \
  -e KINDLEEAR_EMAIL=youremail \
  -e KINDLEEAR_SMTP_SERVER=smtp.example.com \
  -e KINDLEEAR_SMTP_PORT=587 \
  -e KINDLEEAR_SMTP_PASSWORD=password \
  -e KINDLEEAR_DOMAIN=http://example.com \
  -p 8080:8080 \
  --restart unless-stopped \
  ghcr.io/kunzfw/kindleear:1.26.9
```

## Note
* Use crontab to support scheduled delivery
