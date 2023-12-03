### Create namespaces

	kubectl create namespace online-boutique

### Enable automatic sidecar

	kubectl label namespace online-boutique istio-injection=enabled

### Installing

	kubectl apply -n online-boutique -f online-boutique-manifests.yaml

### Call services inside the cluster

	 kubectl run -it --rm --restart=Never busybox --image=gcr.io/google-containers/busybox sh
	
	then use wget http://<service-name>:<port>

### Creaate echo-server
	
	kubectl create deployment hello-minikube-server --image=kicbase/echo-server:1.0 --port=8080 --replicas=2
	kubectl expose deployment hello-minikube-server --type=NodePort --port=8080

