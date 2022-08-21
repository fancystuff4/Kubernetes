# Service

Services enable communication between various components within and outside of the application. Kubernetes services helps us connect applications together with other applications or users. For example our application has groups of pods running various sections such as a group for serving front end load to users and other group for running back end processes and a third group connecting to an external data source. It is services that enable connectivity between these groups of pods services enable the front end application to be made available to end users it helps communication between back end and front end

**Three type of services**
- 1. NodePort
- 2. ClusterIP
- 3. LoadBalancer

**NodePort** :


One of its use case is to listen to a port on the Node and forward requests to a port on the POD running the web application. This type of service is known as a NodePortservice because the service listens to a port on the Node and forwards requests to PODs. NodePort are the service makes an internal POD accessible on a Port of the Node.

- **Creating using command**
```bash
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 
```
- **Creating in declarative**
```bash
apiVersion: v1
kind: Service
metadata:
 name: nodePort-Service

spec:
 selector:
  layer: ui
 ports:
 - name: http
   targetPort: 8888
   port: 8161
   nodePort: 30010

 type: NodePort

```


**ClusterIP** :

In this case the service creates a virtual IP inside the cluster to enable communication between different services such as a set of front end servers to a set of back end servers.

```bash
apiVersion: v1
kind: Service
metadata:
 name: service-queue

spec:
 selector:
  app: service-queue
 ports:
 - name: endpoint
   targetPort: 80 #container port
   port: 61616 #service port

 type: ClusterIP
```


**LoadBalancer**:

The third type is a LoadBalancer, were it provisions a load balancer for our service in supported cloud providers. A good example of that would be to distribute load across the different web servers in your front end tier.

```bash
apiVersion: v1
kind: Service
metadata:
 name: service-webapp
spec:
 selector:
  app: webapp
 ports:
 - name: http
   port: 8080 #LoadBalancer Port better to use 80
   targetPort: 80  #container Port
 type: LoadBalancer
```