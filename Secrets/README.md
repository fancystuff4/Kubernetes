**Secret**
A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in a container image. Using a Secret means that you don't need to include confidential data in your application code.

Three way to declare Secret in manifeast
 - Environment variables
 - Single environment variable
 - Volume

**Encoding**
``bash
#encoding
echo  "<value>" | base64

#decoding
echo  "<encoded>" | base64 -d
```

**Creating Secret using command**
```bash
kubectl create secret generic webapp-secret --from-literal=passwd=UEBTU1cwcmQxCg==
```

**Passing secret as ENV**
Creating secret

```bash
#secret.yaml

apiVersion: v1
kind: Secret
metadata:
  name: database-secret
data:
    database-password: "UEBTU1cwcmQxCg=="
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
         value: dbadmin

       - name: DATABASE_URL
         value: httpd:mysql.db.url

       - name: DATABASE_PASSWORD       
         valueFrom:
           secretKeyRef:
              name: database-secret     #DATABASED_PASSWORD: "P@SSW0rd1"
              key: database-password    
```



**Passing secret as envFrom**
Creating secret

```bash
#secret.yaml

apiVersion: v1
kind: Secret
metadata:
  name: database-secret
data:
   DATABASE_PASSWORD: "UEBTU1cwcmQxCg=="

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
         value: dbadmin

       - name: DATABASE_URL
         value: httpd:mysql.db.url

      envFrom:
      - secretRef:
         name: database-secret
         
```

**Passing configMap as  Volume**
Creating configMap

```bash
#secret.yaml

apiVersion: v1
kind: Secret
metadata:
  name: database-secret
type: Opaque
data:
  database.properties: |
    REFUQUJBU0VfUEFTU1dPUkQ6IHBhc3N3b3JkMTIzCg==

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
         value: dbadmin

       - name: DATABASE_URL
         value: httpd:mysql.db.url

      volumeMounts:
        - name: database-file
          mountPath: /etc/any/directory/file
         
    volumes:
     - name: database-file
       secret:
         secretName: database-secret  
```


