#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
CHART="base"
SOURCE="cache/kubernetes-dashboard"
RELEASE="kubernetes-dashboard"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/$SOURCE \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
