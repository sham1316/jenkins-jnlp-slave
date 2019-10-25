FROM jenkinsci/jnlp-slave
MAINTAINER Alexey Pishchulin <sham1316@gmail.com>

ENV DOCKER_COMPOSE_VERSION=1.20.1

USER root

RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

