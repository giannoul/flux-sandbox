PWD       		= $(shell pwd)
GID           		= $(or $(shell printenv GID), $(shell id -g))
UID           		= $(or $(shell printenv UID), $(shell id -u))
KUBECONFIG    		= $(or $(shell printenv KUBECONFIG), ~/.kube/config)


.PHONY: flux-cli
flux-cli: .dockerimage
	docker \
	  run \
	  --network host \
	  --rm \
	  -it \
	  -v ${KUBECONFIG}:/root/.kube/config:ro \
	  flux-sandbox:flux-cli bash

.dockerimage: Dockerfile
	docker build -t flux-sandbox:flux-cli .
	touch .dockerimage