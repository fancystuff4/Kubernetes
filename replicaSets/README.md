## Replica Controller
The replication controller ensures that the specified number of pods are running at all times, even if it's just one or 100. Another reason we need a replication controller is to create multiple parts to share the load across
them. For example, in this simple scenario, we have a single pod serving a set of users.
When the number of users increase, we deploy additional pod to balance the load across the two pods.
If the demand further increases and if we were to run out of resources on the first node, we could
deploy additional parts across the other nodes in the cluster.
As you can see, the replication controller spans across multiple nodes in the cluster.
It helps us balance the load across multiple parts on different nodes as well as scale our application
when the demand increases.

**Note**

It's important to note that there are two similar terms replication controller and replica set. Both have the same purpose, but they are not the same. Replication controller is the older technology that is being replaced by replica set. Replica set is the new recommended way to set up replication.



**Create ReplicaSet**
```bash
#replicaSet-demo.yml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: web-app-rs
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app-container
        image: richardchesterwood/k8s-fleetman-webapp-angular:release0
        
#kubectl apply -f  replicaSet-demo.yml
```

**List ReplicaSets**
- Get list of ReplicaSets

```bash
kubectl get replicaset
kubectl get rs
```
**Describe ReplicaSet**
- Describe the newly created ReplicaSet
```bash
kubectl describe replicaSet <replicaset-name>

kubectl describe rs/<replicaset-name>

kubectl describe rs <replicaset-name>
```

**Delete ReplicaSet**
```bash
# Delete ReplicaSet
kubectl delete rs <ReplicaSet-Name>

# Sample Commands
kubectl delete rs/my-helloworld-rs
[or]
kubectl delete rs my-helloworld-rs

# Verify if ReplicaSet got deleted
kubectl get rs
```