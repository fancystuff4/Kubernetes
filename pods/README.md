## Pod
Kubernetes does not deploy containers directly on the worker nodes.The containers are encapsulated into a Kubernetes object known as pods. A pod is a single instance of an application. A pod is the smallest object that you can create in Kubernetes.

**Creation of pod**
- Creating pod using imperative way.

```bash
# Template
kubectl run <desired-pod-name> --image <Container-Image>

# Replace Pod Name, Container Image
kubectl run my-first-pod --image nginx
```
- Creating of pod using declerative way.

```bash
#Yaml file
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: webapp
    image: nginx
```

```bash
kubectl apply -f <file name>
kubectl apply -f pod.yaml
```

**List Pods**

```bash
#command
kubectl get pods 

#List Pods with wide option
kubectl get pods -o wide

```
**Describe Pod**
 - Describe the POD, primarily required during troubleshooting.
 - Events shown will be of a great help during troubleshooting.

```bash
# To get list of pod names
kubectl get pods

# Describe the Pod
kubectl describe pod <Pod-Name>
kubectl describe pod my-first-pod 

```

**Verify Pod Logs**
```bash
# Get Pod Name
kubectl get po

# Dump Pod logs
kubectl logs <pod-name>
kubectl logs my-first-pod

# Stream pod logs with -f option and access application to see logs
kubectl logs -f <pod-name>
kubectl logs -f my-first-pod
```
**Connect to Container in a POD**
- Connect to a Container in POD and execute commands
```bash
# Connect to Nginx Container in a POD
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it my-first-pod -- /bin/bash

# Execute some commands in Nginx container
ls
cd /usr/share/nginx/html
cat index.html
exit
```

- Running individual commands in a Container

```bash
kubectl exec -it <pod-name> env

# Sample Commands
kubectl exec -it my-first-pod env
kubectl exec -it my-first-pod ls
kubectl exec -it my-first-pod cat /usr/share/nginx/html/index.html
```

**Delete Pod**
```bash
# To get list of pod names
kubectl get pods

# Delete Pod
kubectl delete pod <Pod-Name>
kubectl delete pod my-first-pod

```

