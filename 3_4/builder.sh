#!/bin/sh
if [ "$#" -ne 2 ]; then
  echo "Usage: builder.sh <github-repo> <docker-image>"
  exit 1
fi

set -e

GITHUB_REPO="$1"
DOCKER_IMAGE="$2"

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "DOCKER_USER and DOCKER_PWD must be set"
  exit 1
fi

echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

git clone "https://github.com/${GITHUB_REPO}.git" "$WORKDIR/repo"
docker build -t "$DOCKER_IMAGE" "$WORKDIR/repo"
docker push "$DOCKER_IMAGE"
