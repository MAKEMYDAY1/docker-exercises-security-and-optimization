#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <github-repo> <docker-image>"
  exit 1
fi

set -e

GITHUB_REPO="$1"
DOCKER_IMAGE="$2"

# Temporary working directory for the clone
WORKDIR="$(mktemp -d)"

cleanup() {
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

echo "Cloning https://github.com/${GITHUB_REPO}.git"
git clone "https://github.com/${GITHUB_REPO}.git" "$WORKDIR/repo"

echo "Building image ${DOCKER_IMAGE} from ${WORKDIR}/repo/Dockerfile"
docker build -t "$DOCKER_IMAGE" "$WORKDIR/repo"

echo "Pushing ${DOCKER_IMAGE} to Docker Hub"
docker push "$DOCKER_IMAGE"

echo "Done: ${DOCKER_IMAGE} published"
