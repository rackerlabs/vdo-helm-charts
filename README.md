# vdo-helm-charts
Helm Charts for the VDO team

## Deploy
```
helm install ./vdojava --name testing --set image.repository=665846930766.dkr.ecr.us-east-1.amazonaws.com/zamboni-bridge --set image.tag=latest 
```

## Update repo
You must bump the version field in vdojava/Chart.yaml each time you update the helm charts
```
export VDOJAVA_VERSION=$(grep version vdojava/Chart.yaml | awk '{print $2}')
helm package vdojava
rm -f vdojava-latest.tgz; cp -p vdojava-$VDOJAVA_VERSION.tgz vdojava-latest.tgz
helm repo index . --url https://rackerlabs.github.io/vdo-helm-charts
```
