#!/bin/bash
VERSION="4.0.0"
CHART="kubernetes-dashboard"
REPO="https://kubernetes.github.io/dashboard"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
helm pull $CHART --untar --destination cache --version $VERSION --repo $REPO
rm -r $BASEDIR/*.tgz
