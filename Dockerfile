FROM openjdk:8u222-slim

# https://gist.github.com/remarkablemark/aacf14c29b3f01d6900d13137b21db3a

RUN apt-get update && \
    apt-get install -yq --no-install-recommends wget  pwgen ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
apt-get install -y git build-essential curl  wget software-properties-common zip unzip && \
apt-get -y autoclean 

RUN mkdir /usr/local/nvm

 

ENV NVM_DIR /usr/local/nvm 
ENV NODE_VERSION 10.10
 
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# ENV NODE_TLS_REJECT_UNAUTHORIZED 0
# RUN npm install gulp -g


WORKDIR /opt
RUN wget http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
RUN tar -xvzf apache-maven-3.6.2-bin.tar.gz
ENV M2_HOME /opt/apache-maven-3.6.2
ENV PATH="/opt/apache-maven-3.6.2/bin:${PATH}"
