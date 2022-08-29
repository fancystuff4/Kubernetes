## Namespace

Namespaces are a way to organize clusters into virtual sub-clusters — they can be helpful when different teams or projects share a Kubernetes cluster. Any number of namespaces are supported within a cluster, each logically separated from others but with the ability to communicate with each other.

**Creation of namespace in declarative**

 ```bash
apiVersion: v1
kind: Namespace
metadata:
  name: test-ns
    
kubectl apply -f namespace.yaml 
```

**Creation of namespace in imperative**

 ```bash
kubectl create ns banking-function

kubectl create ns stock-markating-function    
```

**Getting into namespace**

```bash
kubectl config set-context $(kubectl config current-context) --namespace=banking-function
```

**Mentioning namespace while declaring yaml**
```bash
apiVersion: v1
kind: Pod
metadata:
 name: webapp
 namespace: banking-function
spec:
   containers:
   - name: webapp
     image: nginx
```

**Create in declarative way**
```bash
kubectl run --image=nginx nginx --namespace=banking-function
``` 

**Commands**
```bash
#get all namespaces
kubectl get namespaces
kubectl get ns

#getting pod from other namespace
kubectl get po --namespace=default
kubectl get po -n default

```

**Allocating fixed space to namespace, If it exceeds that all the resources in that namespace will be created**
```bash
apiVersion: v1
kind: ResourceQuota
metadata:
  name: test-ns-quota
  namespace: test-ns
spec:
  hard:
   pods: "10"
   requests.cpu: "4"
   requests.memory: 5Gi
   limits.cpu: "10"
   limits.memory: 10Gi

```

