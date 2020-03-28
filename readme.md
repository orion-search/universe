# Orion Universe

## Introduction

A monorepo utilizing Git submodules. This facilitates selective or holistic local execution of Orion-related microservices for local use — it also documents some subtle changes to our production environment.

### Retrieving submodules

If you've already cloned the repo:

```
git submodule init
git submodule update
```

If cloning the repo

```
git clone --recursive https://github.com/orion-search/universe
```

### Obtaining API keys

@todo

Don't forget to configure `orion/boto.cfg` with your AWS credentials.

### Environment variables

To start off with limited functionality, copy `.env.example` onto `.env` and make then necessary changes. The current DB configuration works for a locally-hosted database (inside the `postgres` container).

## Micro-services

`docker-compose.ec2.yaml` orchestrates the services needed for our APIs, which are currently deployed on EC2. You'll need to edit security rules to allow for port 443 inbound traffic. We have an `A Name` record pointing to our EC2 container's Elastic IP.

`docker-compose.yaml`is for local use, and will include both Airflow and our front-end, for people who don't want to spin up a remote container.

### Building and running locally

`docker-compose -f docker-compose.yaml build` and `docker-compose -f docker-compose.yaml up` to run the containers locally.

This exposes the below services in respective ports (unless otherwise configured):

- Our search engine (port 5000): `curl -X GET http://localhost:5000 -d query='artificial intelligence' -d results='10'`
- A Hasura GraphQL interface (port 8080)
- Our Airflow DAG (port 8081)
- A PostgreSQL database (port 5432)

`docker exec -it caddy /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"` to run a Bash shell inside the Caddy container, access the logs, and ensure everything is working properly.

To copy the folder containing certificates from our Caddy container, do:
`docker cp caddy:/etc/caddycerts/.caddy backend/certs`.

### Setting up Caddy

Caddy configures HTTPS automatically, and if you want to deploy to your own domain, all you need to do is change the host name inside `backend/Caddyfile`.

During the development process, and in order not to get rate limited, I'm copying over the `backend/certs/.caddy folder` to `$CADDYPATH`. See [here](https://github.com/abiosoft/caddy-docker#saving-certificates) for more details.

In order to achieve [dev/prod parity](https://12factor.net/dev-prod-parity), the approach outlined [here](https://codewithhugo.com/docker-compose-local-https/) is also recommended, but is not currently implemented.
