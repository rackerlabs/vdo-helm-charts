#!/bin/bash

# Get current vdojava helm chart version
export version=$(grep version vdojava/Chart.yaml | awk '{print $2}')

# increment patch value in semver string
patch=true

# Build array from version string.
a=( ${version//./ } )

# Increment version numbers as requested.
if [ ! -z $major ]
then
  ((a[0]++))
  a[1]=0
  a[2]=0
fi

if [ ! -z $minor ]
then
  ((a[1]++))
  a[2]=0
fi

if [ ! -z $patch ]
then
  ((a[2]++))
fi

# Set new version
export VDOJAVA_VERSION="${a[0]}.${a[1]}.${a[2]}"

# Change version in vdojava/Chart.yaml
sed -i "s/version: ${version}/version: ${VDOJAVA_VERSION}/g" vdojava/Chart.yaml

# Generate new helm package
helm package vdojava
rm -f vdojava-latest.tgz; cp -p vdojava-$VDOJAVA_VERSION.tgz vdojava-latest.tgz
helm repo index . --url https://rackerlabs.github.io/vdo-helm-charts
