#!/bin/sh
cd $(dirname $0)

cd ../../

DOCKER_IMAGE="local/myapp:latest"

echo ">>>========= build docker image with latest source code"
docker build -t $DOCKER_IMAGE ./

echo ">>>========= run application in docker container"
docker run -it -v gradle-cache:/root/.gradle -p 8080:8080 --rm --name=myapp_run $DOCKER_IMAGE ./gradlew bootrun
