FROM openjdk:8u222-slim

RUN apt-get update && \
    apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
apt-get install -y git build-essential curl wget software-properties-common zip unzip

WORKDIR /opt
RUN wget http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
RUN tar -xvzf apache-maven-3.6.2-bin.tar.gz
ENV M2_HOME /opt/apache-maven-3.6.2
ENV PATH="/opt/apache-maven-3.6.2/bin:${PATH}"
