#!/bin/bash

# Get current vdojava helm chart version
export VDOJAVA_VERSION=$(helm inspect chart vdojava | grep version | awk '{print $2}')
export CHART_ARCHIVE="vdojava-${VDOJAVA_VERSION}.tgz"
export HELM_REPO_URL="https://rackerlabs.github.io/vdo-helm-charts"

curl --output /dev/null --silent --head --fail $HELM_REPO_URL/vdojava-$VDOJAVA_VERSION.tgz

if [ $? -eq 0 ]; then
  echo "${CHART_ARCHIVE} already exists, skipping helm package and publish..."
  echo "Did you forget to increment the version field in Chart.yaml?"
  exit 0
fi

# Generate new helm package
git checkout -b gh-pages remotes/origin/gh-pages
git pull origin master --rebase
helm package vdojava
rm -f vdojava-latest.tgz
cp -p vdojava-$VDOJAVA_VERSION.tgz vdojava-latest.tgz
helm repo index . --url $HELM_REPO_URL
git add index.yaml
git add *.tgz
git add */Chart.yaml
git commit -am "Uprev helm charts done by ${LOGNAME}"
git push origin gh-pages
