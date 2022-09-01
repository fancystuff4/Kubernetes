**NodeSelector**

Schudeling a pod spcefic to a node using label and selector

- Labeling nodes
```bash

kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label node ip-192-168-33-180.us-east-2.compute.internal size=medium

``` 
- Mentioning nodeSelector label in pod 

```bash
apiVersion: 
kind: Pod
metadata:
 name: myapp-pod
spec:
 containers:
  - name: data-processor
    image: data-processor
 nodeSelector:
  size: Large

```

```bash
apiVersion: v1
kind: Pod
metadata:
 name: webapp-pod-2
 labels:
  layer: ui
spec:
 nodeSelector:
  size: medium
 containers:
 - name: webapp
   image: mrsam1234/node-js:v1