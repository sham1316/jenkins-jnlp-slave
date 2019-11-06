FROM jenkinsci/jnlp-slave
MAINTAINER Alexey Pishchulin <sham1316@gmail.com>

ENV DOCKER_COMPOSE_VERSION=1.20.1 NODE_VERSION=10 K8SVERSION=v1.11.5

USER root

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
	&& sh get-docker.sh \
	&& rm get-docker.sh

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
	&& apt-get update \
	&& apt-get install -y nodejs \
	&& apt-get install -y make gcc g++ \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8SVERSION}/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/bin/kubectl

RUN npm install yarn -g	
