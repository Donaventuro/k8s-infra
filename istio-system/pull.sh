#!/bin/bash
VERSION="1.9.0"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
curl -L https://github.com/istio/istio/releases/download/$VERSION/istio-$VERSION-linux-amd64.tar.gz | tar -xzf - -C $BASEDIR
rm -r $BASEDIR/istio-$VERSION/bin
