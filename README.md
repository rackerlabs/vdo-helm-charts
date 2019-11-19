# vdo-helm-charts
Helm Charts for the VDO team

## Update repo
Simply update the version field in Chart.yaml and submit a pull request.

CircleCI now handles repo updates automagically.

# Install repo
```
helm repo add vdo-helm-charts https://rackerlabs.github.io/vdo-helm-charts
```

# Install chart
Example helm install command, refer to values.yaml to determine which variables to override in your deployment
```
helm install vdojava --name <release_name> --set "image.repository=<repo_url>,image.tag=<image_tag>,livenessProbe.initialDelaySeconds=30,readinessProbe.initialDelaySeconds=60"
