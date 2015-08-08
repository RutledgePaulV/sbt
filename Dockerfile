FROM ubuntu:trusty
MAINTAINER paul.v.rutledge@gmail.com

RUN apt-get -y install software-properties-common
RUN apt-add-repository ppa:webupd8team/java
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list

RUN apt-get update
RUN apt-get -y install oracle-java8-installer \
                       oracle-java8-set-default

ENV SCALA_VERSION 2.11.7
ENV SCALA_HOME /usr/local/share/scala
RUN export PATH=$PATH:${SCALA_HOME}/bin

RUN wget http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    tar xvzf scala-${SCALA_VERSION}.tgz && \
    mv scala-${SCALA_VERSION} ${SCALA_HOME} && \
    rm -f scala-${SCALA_VERSION}.tgz

RUN apt-get -y --force-yes install sbt

# compile a non-existent project to pre-download sbt dependencies
RUN sbt compile

CMD ["sbt"]