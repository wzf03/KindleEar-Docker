# KindleEar-Docker
kindleear's docker image

## Usage

### docker-compose ([recommended](https://github.com/docker/compose))
create `docker-compose.yml` in a new directory
```yaml
version: "3"
services:
  kindleear:
    image: ghcr.io/wzf03/kindleear:latest
    container_name: kindleear
    ports:
      - 8080:8080
    volumes:
      - ./data:/app/data
    restart: unless-stopped
```
crate `config.json` in the data directory you created
```json
{
    // Necessary
    "email": "youremail",
    "smtpServer": "smtp.example.com",
    "smtpPort": 587,
    "smtpPassword": "password",
    "domain": "http://example.com"
}
```
then run the container using [docker-compose](https://github.com/docker/compose)
```
docker-compose up -d
```

### docker cli

create a `config.json` like above, then
```
docker run -d \
  --name=kindleear \
  -p 8080:8080 \
  -v ./data:/app/data \
  --restart unless-stopped \
  ghcr.io/wzf03/kindleear:latest
```

## Note
* Use crontab to support scheduled delivery
* Also support configuration through environment variable to be compatible with older version
* Known problem: database cannot be saved after the container stop
