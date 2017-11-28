#!/bin/bash
set -ex -o pipefail
DOCKER_OPTS="--config-file=/etc/docker/daemon.json"
$(which dind) dockerd ${DOCKER_OPTS} >/dev/stdout 2>&1 &
sleep 1
java -version
rm -rf docker-fixtures
git clone https://github.com/jenkinsci/docker-fixtures.git
cd docker-fixtures
git fetch origin pull/4/head:JENKINS-46673
git checkout JENKINS-46673
mvn -Dmaven.test.skip=true -Dmaven.compiler.executable=1.7 -Dmaven.compiler.target=1.7 clean deploy
cd ..
export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/
mvn --version
mvn -B -Djenkins.test.timeout=1200 "$@"
exit 0
