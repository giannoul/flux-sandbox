PWD      					= $(shell pwd)
K3D_CLUSTER_NAME 			= $(or $(shell printenv K3D_CLUSTER_NAME), flux-sandbox)
UID = $(shell id -u $(USER))
GID = $(shell id -g $(USER))

# k3d cluster operations
.PHONY: k3d-provision
k3d-provision: 
	k3d registry create flux-registry.localhost --port 5555
	k3d cluster create $(K3D_CLUSTER_NAME)  --api-port 6550 --config $(PWD)/k3d/cluster-config.yaml
	kubectl config set-context $(K3D_CLUSTER_NAME) 

.PHONY: k3d-delete-local-registry
k3d-delete-local-registry:
	k3d registry delete flux-registry.localhost

.PHONY: k3d-deprovision
k3d-deprovision: k3d-delete-local-registry
	k3d cluster delete $(K3D_CLUSTER_NAME)

# flux container
.PHONY: flux-cli
flux-cli:
	make -C flux-image flux-cli

# manifests
.PHONY: manifests-build
manifests-build:
	docker run --rm -ti -v $(PWD)/manifests:/manifests --workdir /manifests nekottyo/kustomize-kubeval kustomize build /manifests > $(PWD)/manifests/dist/generated.yaml

.PHONY: manifests-apply
manifests-apply:
	kubectl apply -f $(PWD)/manifests/dist