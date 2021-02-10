#!/bin/bash
VERSION="2.3.1"
CHART="loki-stack"
REPO="https://grafana.github.io/helm-charts"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
helm pull $CHART --untar --destination cache --version $VERSION --repo $REPO
rm -r $BASEDIR/*.tgz
