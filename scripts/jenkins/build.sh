#!/bin/sh
cd $(dirname $0)

cd ../../

DOCKER_IMAGE = "local/myapp:latest"

docker build -t $DOCKER_IMAGE ./

mkdir -p build
docker run -i -e DOCKER_HOST_USERID="$(id -u):$(id -g)" -v gradle-cache:/root/.gradle -v $(pwd)/build:/root/project/build --rm --name=myapp_build $DOCKER_IMAGE /bin/bash << "COMMANDS"
set -o errexit -o nounset \
\
&& echo ">>>========= run build" \
&& rm -rf build/* \
&& ./gradlew build \
\
&& echo ">>>========= changing owner" \
&& chown --recursive $DOCKER_HOST_USERID build
COMMANDS
