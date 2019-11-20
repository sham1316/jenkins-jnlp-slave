FROM jenkinsci/jnlp-slave
MAINTAINER Alexey Pishchulin <sham1316@gmail.com>

ENV DOCKER_COMPOSE_VERSION=1.20.1 NODE_VERSION=10.16.3 NVM_VERSION=v0.35.1 K8SVERSION=v1.11.5 
ENV NVM_DIR /usr/local/nvm

USER root

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
	&& sh get-docker.sh \
	&& rm get-docker.sh
	
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8SVERSION}/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl \
	&& mv ./kubectl /usr/bin/kubectl

RUN apt-get update \
	&& apt-get install -y make gcc g++ \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN mkdir ${NVM_DIR} \
    && curl https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install yarn pkg lerna -g
