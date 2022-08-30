**ConfigMap**
Many applications rely on configuration which is used during either application initialization or runtime. Most of the times there is a requirement to adjust values assigned to configuration parameters. ConfigMaps are the Kubernetes way to inject application pods with configuration data. ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable. This page provides a series of usage examples demonstrating how to create ConfigMaps and configure Pods using data stored in ConfigMaps.


Three way to declare configMaps in manifeast
 - Environment variables
 - Single environment variable
 - Volume

**Creating ConfigMap using command**
```bash
kubectl create configmap webapp-config-map --from-literal=APP_COLOR=darkblue
```

**Passing configMap as ENV**
Creating configMap

```bash
#configMap.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: database-config
data:
    database_url: "http://mysqldbserver/"
    database_password: "P@SSW0rd123"

```
Mention in manifest
```bash
# deploy.yaml
 
apiVersion: apps/v1
kind: Deployment
metadata:
 name: position-simulator
spec:
 replicas: 1
 selector:
  matchLabels:
   app: position-simulator
 template:
  metadata:
   labels:
    app: position-simulator
  spec:
    containers:
    - name: position-simulator
      image: mrsam1234/ttfa-webapp:v2
      env:

       - name: DATABASE_USERNAME
         value: dbAdmin  

       - name: DATABASE_URL
         valueFrom:
           configMapKeyRef:                       #DATABASED_URL: "http://mysqldbserver/"
              name: database-config
              key: database_url


       - name: DATABASED_PASSWORD        #passing env througt confiMap
         valueFrom:
           configMapKeyRef:
              name: database-config        #DATABASED_PASSWORD: "P@SSW0rd1"
              key: database_password       

```

**Passing configMap as FromEnv**
Creating configMap

```bash
#configMap.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: database-config
data:
    DATABASE_URL: "http://mysqldbserver/"
    DATABASE_PASSWORD: "PASSWORD123"

```
Mention in manifest
```bash
# deploy.yaml
 
apiVersion: apps/v1
kind: Deployment
metadata:
 name: webapp
spec:
 replicas: 1
 selector:
  matchLabels:
   app: webapp
 template:
  metadata:
   labels:
    app: webapp
  spec:
    containers:
    - name: webapp
      image: mrsam1234/ttfa-webapp:v2
      env:
      - name: DATABASE_USERNAME
        value: dbAdmin12
      envFrom:
         - configMapRef:                   
            name: database-config
         
```

**Passing configMap as  Volume**
Creating configMap

```bash
#configMap.yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: database-config
data:
  database.properties: |
    DATABASE_USERNAME=dbadmin
    DATABASE_URL= http://db.mysql.connected
    DATABASE_PASSWORD= password123

```
Mention in manifest
```bash
# deploy.yaml
 
apiVersion: apps/v1
kind: Deployment
metadata:
 name: webapp
spec:
 replicas: 1
 selector:
  matchLabels:
   app: webapp
 template:
  metadata:
   labels:
    app: webapp
  spec:
    containers:
    - name: webapp
      image: mrsam1234/ttfa-webapp:v2
      volumeMounts:
       - name: db-file
         mountPath: /etc/any/directory/file
         
    volumes:
     - name: db-file
       configMap:
         name: database-config    
```








