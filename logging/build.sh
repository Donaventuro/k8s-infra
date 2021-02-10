#!/bin/bash
BASEDIR=$(dirname $(realpath $0))
CHART="grafana"
SOURCE="cache/loki-stack/charts/grafana"
RELEASE="logging-grafana"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/$SOURCE \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
CHART="loki"
SOURCE="cache/loki-stack/charts/loki"
RELEASE="logging-loki"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/$SOURCE \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
CHART="promtail"
SOURCE="cache/loki-stack/charts/promtail"
RELEASE="logging-promtail"
DIST=$BASEDIR/helm/$CHART
rm -r $DIST/bundle
mkdir -p $DIST/bundle
helm template $RELEASE $BASEDIR/$SOURCE \
  --create-namespace \
  --namespace $(basename $BASEDIR) \
  --values $BASEDIR/helm/$CHART/values.yaml \
  --output-dir $DIST/bundle
