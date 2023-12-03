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


### Create a signed CA,for certificate to be installed on istio

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
  -subj '/O=boutiquestore Inc./CN=boutiquestore.com' \
  -keyout root.key -out root.crt

### CSR

openssl req -out server.csr -newkey rsa:2048 -nodes \
  -keyout server.key -subj "/CN=marketplace.boutiquestore.com/O=boutique store"

### sign

	openssl x509 -req -days 365 -CA root.crt -CAkey root.key \
    -set_serial 0 -in server.csr -out server.crt

### upload to istio

	 kubectl -n istio-system create secret tls online-boutique-tls-credential \
    --key server.key --cert=server.crt

### verify

	openssl s_client -showcerts -connect $INGRESS:443 -servername marketplace.boutiquestore.com -CAfile ./root.crt 

	curl -H "Host: marketplace.boutiquestore.com"   --cacert root.crt   --resolve "marketplace.boutiquestore.com:443:10.106.221.179"   "https://marketplace.boutiquestore.com:443/_healthz"

