#!/bin/sh
cd $(dirname $0)
cd ../../
APP_NAME=$(basename $(pwd))

echo ">>>========= build docker image with latest source code"
DOCKER_IMAGE=`echo "local/$APP_NAME:latest" | tr "[:upper:]" "[:lower:]"`
docker build -t $DOCKER_IMAGE ./

mkdir -p build
docker run -i -e DOCKER_HOST_USERID="$(id -u):$(id -g)" -v jenkins-gradle-cache:/root/.gradle -v $(pwd)/build:/root/project/build --rm $DOCKER_IMAGE /bin/bash << "COMMANDS"
set -o errexit -o nounset \
\
&& echo ">>>========= run build in container" \
&& rm -rf build/* \
&& ./gradlew build \
\
&& echo ">>>========= changing artifacts owner" \
&& chown --recursive $DOCKER_HOST_USERID build
COMMANDS
