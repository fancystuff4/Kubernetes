
## Deployment
The deployment provides us with the capability to upgrade the underlying instances seamlessly using rolling updates, undo changes, and pause and resume changes as required.

**Creation of deployment in imperative**
```bash
kubectl create deployment <Deplyment-Name> --image=<Container-Image>
kubectl create deployment my-first-deployment --image=stacksimplify/kubenginx:1.0.0 

# Verify Deployment
kubectl get deployments
kubectl get deploy 

# Describe Deployment
kubectl describe deployment <deployment-name>
kubectl describe deployment my-first-deployment

# Verify ReplicaSet
kubectl get rs

# Verify Pod
kubectl get po

```

**Creation of deployment in imperative**

```bash
#deployment-demo.yml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  strategy:
    type: Recreate  #RollingUpdate
  replicas: 9
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      name: web-app
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app-container12
        image: richardchesterwood/k8s-fleetman-webapp-angular:release0

#kubectl apply -f  deployment-demo.yml
```


**Update Deployment**
- Observation: Please Check the container name in spec.container.name yaml output and make a note of it and replace in kubectl set image command
```bash
# Get Container Name from current deployment
kubectl get deployment my-first-deployment -o yaml

# Update Deployment - SHOULD WORK NOW
kubectl set image deployment/<Deployment-Name> <Container-Name>=<Container-Image> --record=true
kubectl set image deployment/my-first-deployment kubenginx=stacksimplify/kubenginx:2.0.0 --record=true
```


**Scaling a Deployment**
- Scale the deployment to increase the number of replicas (pods)
```bash
# Scale Up the Deployment
kubectl scale --replicas=20 deployment/<Deployment-Name>
kubectl scale --replicas=20 deployment/my-first-deployment 

# Verify Deployment
kubectl get deploy

# Verify ReplicaSet
kubectl get rs

# Verify Pods
kubectl get po

# Scale Down the Deployment
kubectl scale --replicas=10 deployment/my-first-deployment 
kubectl get deploy
```

**Verify Rollout Status**
- Observation: Rollout happens in a rolling update model, so no downtime.
```bash
# Verify Rollout Status 
kubectl rollout status deployment/my-first-deployment
```

**Check the Rollout History of a Deployment**
```bash
# List Deployment Rollout History
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment  
```

**Verify changes in each revision**
- Observation: Review the "Annotations" and "Image" tags for clear understanding about changes.
```bash
# List Deployment History with revision information
kubectl rollout history deployment/my-first-deployment --revision=1
kubectl rollout history deployment/my-first-deployment --revision=2
kubectl rollout history deployment/my-first-deployment --revision=3
```


**Rollback to previous version**
- Observation: If we rollback, it will go back to revision-2 and its number increases to revision-4
```bash
# Undo Deployment
kubectl rollout undo deployment/my-first-deployment

# List Deployment Rollout History
kubectl rollout history deployment/my-first-deployment  
```

**Rollback to specific revision**
- Check the Rollout History of a Deployment
```bash
# List Deployment Rollout History
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment 

# Rollback Deployment to Specific Revision
kubectl rollout undo deployment/my-first-deployment --to-revision=3
```


**Rolling Restarts of Application**
- Rolling restarts will kill the existing pods and recreate new pods in a rolling fashion.
```bash
# Rolling Restarts
kubectl rollout restart deployment/<Deployment-Name>
kubectl rollout restart deployment/my-first-deployment

# Get list of Pods
kubectl get po
```

**Pause Deployment and Two Changes**
```bash
# Pause the Deployment
kubectl rollout pause deployment/<Deployment-Name>
kubectl rollout pause deployment/my-first-deployment

# Update Deployment - Application Version from V3 to V4
kubectl set image deployment/my-first-deployment kubenginx=stacksimplify/kubenginx:4.0.0 --record=true

# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: No new rollout should start, we should see same number of versions as we check earlier with last version number matches which we have noted earlier.

# Get list of ReplicaSets
kubectl get rs
Observation: No new replicaSet created. We should have same number of replicaSets as earlier when we took note. 
```

**Resume Deployment**
```bash
# Resume the Deployment
kubectl rollout resume deployment/my-first-deployment

# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: You should see a new version got created

# Get list of ReplicaSets
kubectl get rs
Observation: You should see new ReplicaSet.
```


**Clean-Up**
```bash
# Delete Deployment
kubectl delete deployment my-first-deployment
kubectl delete deploy -f deployment.yaml

# Get all Objects from Kubernetes default namespace
kubectl get all
```