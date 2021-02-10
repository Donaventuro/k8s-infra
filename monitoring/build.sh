#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
VERSION="0.7.0"
PATH=$BASEDIR/cache/kube-prometheus-$VERSION/tmp/bin:$PATH
make -C $BASEDIR/cache/kube-prometheus-$VERSION vendor
CHART="base"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
jsonnet -J $BASEDIR/cache/kube-prometheus-$VERSION/vendor -m . $DIST/source/$CHART.jsonnet | \
  xargs -I{} sh -c "cat {} | gojsontoyaml > {}.yaml" -- {}
find $DIST/bundle -type f ! -name '*.yaml' -delete
CHART="crd"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
jsonnet -J $BASEDIR/cache/kube-prometheus-$VERSION/vendor -m . $DIST/source/$CHART.jsonnet | \
  xargs -I{} sh -c "cat {} | gojsontoyaml > {}.yaml" -- {}
find $DIST/bundle -type f ! -name '*.yaml' -delete
