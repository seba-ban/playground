CONTEXT := playground
MINIKUBE_CPUS := 4
MINIKUBE_MEMORY := 12g

.PHONY: cluster
cluster:
	minikube start -p $(CONTEXT) --cpus $(MINIKUBE_CPUS) --memory $(MINIKUBE_MEMORY)

.PHONY: teardown
teardown:
	minikube delete -p $(CONTEXT)

.PHONY: gen-kfp
gen-kfp:
	./hack/gen_kfp.sh services/kfp/manifests.yaml

# TODO: split into separate targets
.PHONY: install-serving-prerequisites
install-serving-prerequisites:
	echo "Installing cert-manager"
	kubectl --context $(CONTEXT) apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml
	kubectl --context $(CONTEXT) wait --for=condition=ready --timeout=5m pods -n cert-manager --all=true
	
	echo "Installing mutating webhook for no resource limits"
	kubectl --context $(CONTEXT) apply -f https://raw.githubusercontent.com/seba-ban/dev-limits-k8s-webhook/main/webhook.yaml
	kubectl --context $(CONTEXT) wait --for=condition=ready --timeout=5m pods --all=true
	
	echo "Installing istio"
	istioctl --context $(CONTEXT) \
		install --set meshConfig.enableTracing=true \
		--set profile=demo \
		--skip-confirmation
