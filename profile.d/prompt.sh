#! /bin/bash

export HISTCONTROL=ignoredups

if [ -f "${KUBECONFIG}" ]; then
  chmod 600 "${KUBECONFIG}"
fi

eval "$(oh-my-posh init bash --config ~/.ohmy.theme.omp.json)"

source <(kubectl completion bash)
source <(helm completion bash)
source /usr/local/bin/az.completion.sh
source /usr/local/bin/istioctl.bash

alias k=kubectl
complete -F __start_kubectl k

alias ic=istioctl
complete -F __start_istioctl ic

alias tf=terraform

title () {
  local CLUSTER NAMESPACE
  CLUSTER=$(kubectl config view --minify --output 'jsonpath={..current-context}' | sed -r -e 's/([A-Z]+-[A-Z]+).*/\1/')
  NAMESPACE=$(kubectl config view --minify --output 'jsonpath={..namespace}')
  echo -ne "\e]0;"
  echo -n "${NAMESPACE} ${CLUSTER} DevOps CLI"
  echo -ne "\a"
}

export -f title
