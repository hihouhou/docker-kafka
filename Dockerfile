#
# Kafka server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV KAFKA_VERSION=4.0.0
ENV SCALA_VERSION=2.13

#Install openJDK and basic user
RUN apt-get update && apt-get install -y wget openjdk-11-jdk-headless && \
    useradd --system --home-dir /var/lib/kafka kafka && \
    mkdir -p /var/lib/kafka

#Get Kafka
RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /var/lib/kafka && \
    chown -R kafka:kafka /var/lib/kafka

ENV PATH=$PATH:/var/lib/kafka/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin

WORKDIR /var/lib/kafka

COPY server.properties config/

CMD ["kafka-server-start.sh", "config/server.properties"]
