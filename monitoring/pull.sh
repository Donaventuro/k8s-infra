#!/bin/bash
VERSION="0.7.0"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
curl -L https://github.com/prometheus-operator/kube-prometheus/archive/v$VERSION.tar.gz | tar -xzf - -C $BASEDIR
