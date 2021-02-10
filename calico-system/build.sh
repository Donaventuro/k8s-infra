#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
CHART="base"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
rm -r $DIST/source/resources
mkdir -p $DIST/source/resources
cp -r $BASEDIR/cache/calico.yaml $DIST/source/resources/calico.yaml
kubectl kustomize $DIST/source > $DIST/bundle/bundle.yaml
