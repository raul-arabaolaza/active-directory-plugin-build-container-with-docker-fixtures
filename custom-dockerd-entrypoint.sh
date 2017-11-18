#!/bin/bash
set -ex -o pipefail
DOCKER_OPTS="--config-file=/etc/docker/daemon.json"
$(which dind) dockerd ${DOCKER_OPTS} >/dev/stdout 2>&1 &
sleep 1
git clone https://github.com/jenkinsci/docker-fixtures.git
git fetch origin pull/4/head:JENKINS-46673
git checkout JENKINS-46673
mvn clean install
cd ..
mvn -B -Djenkins.test.timeout=1200 "$@"
exit 0
