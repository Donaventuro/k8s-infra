#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
VERSION="1.9.0"
CHART="base"
RELEASE="istio-system"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/cache/istio-$VERSION/manifests/charts/istio-operator \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
rm -r $DIST/bundle/istio-operator/templates/namespace.yaml
CHART="crd"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
rm -r $DIST/source/resources
mkdir -p $DIST/source/resources
cp -r $BASEDIR/cache/istio-$VERSION/manifests/charts/base/crds/* $DIST/source/resources
kubectl kustomize $DIST/source > $DIST/bundle/bundle.yaml
