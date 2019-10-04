# Jupyterhub
Docker image to setup Jupyterhub on a single server for
* Multiple users
* Support for R
* Jupyterlab

Easy to setup and use for a small organisation.

## Build
```
docker build .
```

## Run with docker compose

```
version: '3'
services:
  jupyter:
    image: jupyterhub-image
    restart: always
    container_name: jupyterhub
    env_file:
      - .env
    ports:
      - "8080:8000"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "data:/home"

volumes:
  data:
    external:
      name: jupyterhub-data
```


