FROM docker:stable-dind
LABEL maintainer="fbelzunc@gmail.com"

RUN apk add --no-cache maven openjdk8 bash tini bind-tools
RUN apk add -U --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing aufs-util

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/
#ENV DOCKER_STORAGE_DRIVER=overlay2
ENV DOCKER_HOST=unix:///var/tmp/docker.sock

COPY daemon.json /etc/docker/daemon.json
COPY custom-dockerd-entrypoint.sh /usr/local/bin/custom-dockerd-entrypoint.sh

WORKDIR /project

ENTRYPOINT ["/sbin/tini","-g","--","bash","/usr/local/bin/custom-dockerd-entrypoint.sh"]

CMD ["clean","install"]
