FROM openjdk:8-jdk

ENV PROJECT_PATH=/root/project
COPY build.gradle gradlew $PROJECT_PATH/
COPY src $PROJECT_PATH/src/
COPY gradle $PROJECT_PATH/gradle/

WORKDIR $PROJECT_PATH
