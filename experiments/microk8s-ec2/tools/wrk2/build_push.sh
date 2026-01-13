#!/usr/bin/env bash
set -euo pipefail

NS="${DOCKER_NS:-marekko}"
ROOT="$(git rev-parse --show-toplevel)"
SHA="$(git rev-parse --short HEAD)"
TAG="${WRK2_TAG:-dsb-wrk2-socket-${SHA}}"
IMG="${NS}/wrk2:${TAG}"

docker build --pull -t "${IMG}" -f "${ROOT}/wrk2/Dockerfile" "${ROOT}/wrk2"
docker push "${IMG}"

echo "${IMG}"
