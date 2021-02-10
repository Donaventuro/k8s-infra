#!/bin/bash
VERSION="1.2.11"
CHART="nfs-client-provisioner"
REPO="https://charts.helm.sh/stable"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
helm pull $CHART --untar --destination cache --version $VERSION --repo $REPO
rm -r $BASEDIR/*.tgz
