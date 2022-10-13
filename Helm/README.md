
## Helm

**Command to install helm**
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

DESIRED_VERSION=v3.8.2 bash get_helm.sh

cp -Rrp /usr/loval/bin/helm* /bin/

```

**Command to install prometheus chart**
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm install [RELEASE_NAME] prometheus-community/prometheus
```


Referance:
https://artifacthub.io/
https://helm.sh/docs/