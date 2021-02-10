#!/bin/bash
CHART=$1
BASEDIR=$(dirname $(realpath $0))
CLUSTER=$(basename $(dirname $BASEDIR))
NAMESPACE=$(basename $BASEDIR)
RELEASE=$CLUSTER.$NAMESPACE.$CHART
if [[ ! -f $BASEDIR/helm/$CHART/Chart.yaml ]]
then
  echo "PLEASE ENTER VALID CHART NAME"
  ls $BASEDIR/helm
  exit
fi
echo "CONTEXT: $(kubectl config current-context)"
echo "NAMESPACE: $NAMESPACE"
echo "RELEASE: $RELEASE"
read -p "PRESS ENTER TO CONTINUE"
helm upgrade $RELEASE $BASEDIR/helm/$CHART \
  --install \
  --create-namespace \
  --namespace $NAMESPACE
