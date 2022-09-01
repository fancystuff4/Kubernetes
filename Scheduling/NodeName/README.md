**Mannually Scheduling pod**
**Node Name**
- Mentioning in po on which node it schedules
```bash
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: <nodename>
  containers:
  -  image: nginx
     name: nginx
```

```bash
apiVersion: v1
kind: Pod
metadata:
 name: webapp-pod-1
 labels:
  layer: ui
spec:
 nodeName: ip-192-168-33-180.us-east-2.compute.internal
 containers:
 - name: webapp
   image: mrsam1234/node-js:v1
```