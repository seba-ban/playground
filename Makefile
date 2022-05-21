CONTEXT := playground

.PHONY: cluster
cluster:
	minikube start -p $(CONTEXT) --cpus 4

.PHONY: teardown
teardown:
	minikube delete -p $(CONTEXT)