#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
CHART="base"
SOURCE="cache/nfs-client-provisioner"
RELEASE="csi-nfs-hdd"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/$SOURCE \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
