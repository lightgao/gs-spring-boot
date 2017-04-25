#!/bin/sh
cd $(dirname $0)
cd ../../

CURRENT_USERID="$(id -u):$(id -g)"
if [ $CURRENT_USERID != "1000:1000" ]
then
echo "There are permission issues if you run gradle container from a user id != 1000."
echo "Use ./scripts/jenkins/run.sh"
exit 255
fi

DOCKER_IMAGE="gradle:3.5-jdk8"
docker run -it -v $(pwd):/project -w /project -v dev-gradle-cache:/home/gradle/.gradle -p 8080:8080 --rm $DOCKER_IMAGE gradle bootRun
