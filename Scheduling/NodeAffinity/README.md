**Node Affinity**

Schudeling a pod spcefic to a node using node affinity

- Labeling nodes
```bash

kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label node ip-192-168-33-180.us-east-2.compute.internal size=large

``` 
- Mentioning nodeAffinity in pod manifest 

```bash
apiVersion: v1
kind: Pod
metadata: 
 name: webapp-pod-2
 labels:
  layer: ui
spec:
 containers:
 - name: webapp-container
   image: mrsam1234/node-js:v1
 affinity:
  nodeAffinity:
   requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key : size 
        operator: In
        values:
        - large

```