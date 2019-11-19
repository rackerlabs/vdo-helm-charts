# vdo-helm-charts
Helm Charts for the VDO team

## Deploy
```
helm install ./vdojava --name testing --set image.repository=665846930766.dkr.ecr.us-east-1.amazonaws.com/zamboni-bridge --set image.tag=latest 
```

## Update repo
Simply update the version field in Chart.yaml and submit a pull request.
CircleCI now handles repo updates automagically.
