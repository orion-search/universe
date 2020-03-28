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

#### Microsoft Academic Knowledge ####
- Sign up for an account with [Microsoft Research](https://msr-apis.portal.azure-api.net/signup).
- Activate your account and subscribe to the **Project Academic Knowledge**.
- You can use the **Primary Key** in your profile page to query the API. Test queries using the _Evaluate_ method in the [API Explorer](https://msr-apis.portal.azure-api.net/docs/services/academic-search-api/).

#### Google Places ####
- Sign in with your Google account to [Google Cloud Platform (GCP)](https://console.cloud.google.com/). 
- Set up a project and enable billing.
- Find the **Places API** in the **Marketplace** and enable it.
- Click on the **CREDENTIALS** tab and generate an API key.

#### GenderAPI ####
- Sign up on [Gender API](https://gender-api.com/en/).
- Navigate to the _Authorization tokens_ page and create a new key. 

Don't forget to configure `orion/boto.cfg` with your AWS credentials.

### Environment variables

To start off with limited functionality, copy `.env.example` onto `.env` and make then necessary changes. The current DB configuration works for a locally-hosted database (inside the `postgres` container).

## Micro-services

`docker-compose.ec2.yaml` orchestrates the services needed for our APIs, which are currently deployed on EC2. You'll need to edit security rules to allow for port 443 inbound traffic. We have an `A Name` record pointing to our EC2 container's Elastic IP.

`docker-compose.yaml`is for local use, and will include both Airflow and our front-end, for people who don't want to spin up a remote container.

### Building and running locally

Before building the container, configure Orion with `orion/model_config.yaml`. We currently use Orion to collect all of the **bioRxiv** but you can fetch a different subset of the Microsoft Academic Graph. For example, you can configure Orion to collect all of the papers with `habitat destruction` as a Field of Study:

``` yaml
data:
    mag:
        query_values: ['habitat destruction']
        entity_name: 'F.FN'
```

Then, do `docker-compose -f docker-compose.yaml build` and `docker-compose -f docker-compose.yaml up` to run the containers locally.

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
