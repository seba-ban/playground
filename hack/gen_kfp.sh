#!/bin/bash

set -e

source ./hack/base.sh

kfp_tag=2.0.3
target_file=$1

playground.assert_cmd_exists git
playground.assert_cmd_exists kustomize

if [ -z "$target_file" ]; then
    echo "Usage: $0 <target_file>"
    exit 1
fi

target_file=$(realpath "$target_file")
curr_dir=$(pwd)
tmp_dir=$(mktemp -d)

playground.log_header "Generating $target_file from kfp $kfp_tag"

playground.log "Cloning kfp $kfp_tag to $tmp_dir"
cd "$tmp_dir"
git clone https://github.com/kubeflow/pipelines.git
cd pipelines/manifests/kustomize
git checkout $kfp_tag

playground.log "Creating kustomization.yaml"
cat <<EOF > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

bases:
    - ./cluster-scoped-resources
    - ./env/platform-agnostic-emissary

EOF

playground.log "Generating manifests"
manifests=$(kustomize build .) 
printf "# generated on %s from kfp repo tag %s\n" "$(date)" "$kfp_tag" > "$target_file"
echo "$manifests" >> "$target_file"

cd "$curr_dir"

playground.log "Removing $tmp_dir"
rm -rf "$tmp_dir"