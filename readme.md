# Orion Universe

A monorepo utilizing Git submodules. This facilitates selective or holistic local execution of Orion-related microservices for local use — it also documents some subtle changes to our production environment.

## Micro-services

`docker-compose.ec2.yaml` orchestrates the services needed for our APIs, which are currently deployed on EC2. You'll need to edit security rules to allow for port 443 inbound traffic. We have an `A Name` record pointing to our EC2 container's Elastic IP.

`docker-compose.yaml`is for local use, and will include both Airflow and our front-end, for people who don't want to spin up a remote container.

### Setting up Caddy

Caddy configures HTTPS automatically, and if you want to deploy to your own domain, all you need to do is change the host name inside `backend/Caddyfile`.

During the development process, and in order not to get rate limited, I'm copying over the `backend/certs/.caddy folder` to `$CADDYPATH`. See [here](https://github.com/abiosoft/caddy-docker#saving-certificates) for more details.

In order to achieve [dev/prod parity](https://12factor.net/dev-prod-parity), the approach outlined [here](https://codewithhugo.com/docker-compose-local-https/) is also recommended, but is not currently implemented.

### Building and running

`docker-compose -f docker-compose.yaml build` and `docker-compose -f docker-compose.yaml up` to run the containers locally.

`docker exec -it caddy /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"` to run a Bash shell inside the Caddy container, access the logs, and ensure everything is working properly.

To copy the folder containing certificates from our Caddy container, do:
`docker cp caddy:/etc/caddycerts/.caddy backend/certs`.
