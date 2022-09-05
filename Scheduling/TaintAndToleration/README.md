**Taint and Toleraion**

Schudeling a pod spcefic to a node using taint and toleraion.

 Mentioning taint on nodes  
- 
```bash

kubectl taint nodes <node-name> <label-key>=<label-value>:NoSchedule

kubectl taint nodes ip-192-168-14-119.us-east-2.compute.internal color=blue:NoSchedule

``` 
- Mentioning toleration in pod manifest 

```bash
apiVersion: v1 
kind: Pod 
metadata: 
 name: webapp-pod-1
 labels: 
  layer: ui 
spec: 
  tolerations:
  - key: "color"
    operator: "Equal"
    value: blue
    effect: NoSchedule
   
  containers: 
  - name: webapp
    image: mrsam1234/node-js:v1

```