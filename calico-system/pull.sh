#!/bin/bash
VERSION="3.17"
BASEDIR=$(dirname $(realpath $0))/cache
rm -r $BASEDIR
mkdir -p $BASEDIR
curl https://docs.projectcalico.org/archive/v$VERSION/manifests/calico.yaml > $BASEDIR/calico.yaml
