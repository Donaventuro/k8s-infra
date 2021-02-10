#!/usr/bin/env bash

function common::run_hook() {
  if [[ $1 == "--config" ]]
  then
    hook::config
  else
    hook::trigger
  fi
}

function kubectl::replace_or_create() {
  object=$(cat)
  if ! kubectl get -f - <<< "$object" > /dev/null 2> /dev/null
  then
    kubectl create -f - <<< "$object" > /dev/null
  else
    kubectl replace --force -f - <<< "$object" > /dev/null
  fi
}

hook::config() {
cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: secret
  executeHookOnEvent:
  - Modified
  nameSelector:
    matchNames:
    - dockerconfigjson
  namespace:
    nameSelector:
      matchNames:
      - shell-operator
EOF
}

hook::trigger() {
  type=$(jq -r ".[0].type" $BINDING_CONTEXT_PATH)
  if [[ $type == "Synchronization" ]]
  then
    echo Got Synchronization event
    exit 0
  fi
  for namespace in $(kubectl get secret -A --field-selector metadata.name=dockerconfigjson,metadata.namespace!=shell-operator -o json | jq -r ".items[].metadata.namespace")
  do
    kubectl -n shell-operator get secret dockerconfigjson -o json | \
      jq -r ".metadata.namespace=\"$namespace\" | .metadata |= with_entries(select([.key] | inside([\"name\", \"namespace\"])))" | \
      kubectl::replace_or_create
    kubectl -n $namespace patch serviceaccount default -p "{\"imagePullSecrets\": [{\"name\": \"dockerconfigjson\"}]}"
  done
}

common::run_hook "$@"
