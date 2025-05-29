# Variables
BINARY_NAME=swarmui
GITHASH := $(shell git rev-parse --short HEAD)

# Build a docker image
image:
	docker build -f launchtools/StandardDockerfile.docker -t registry.aerye.net/$(BINARY_NAME):$(GITHASH) -t registry.aerye.net/$(BINARY_NAME):latest-custom .

# Push a docker image
push:
	docker push registry.aerye.net/$(BINARY_NAME):$(GITHASH)
	docker push registry.aerye.net/$(BINARY_NAME):latest

# Deploy the image to the docker swarm
deploy:
	curl -s -u user:$(DEPLOY_KEY) https://deploy.swarm.aerye.net/deploy/$(BINARY_NAME)_$(BINARY_NAME)/$(GITHASH)
	curl -s -u user:$(DEPLOY_KEY) https://deploy.swarm.aerye.net/deploy/$(BINARY_NAME)_$(BINARY_NAME)-p/$(GITHASH)

.PHONY: image push deploy