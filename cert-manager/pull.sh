#!/bin/bash
VERSION="1.1.0"
CHART="cert-manager"
REPO="https://charts.jetstack.io"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
helm pull $CHART --untar --destination cache --version $VERSION --repo $REPO
rm -r $BASEDIR/*.tgz
