## hbase standalone
FROM ubuntu:14.04
MAINTAINER nuno@tradingeconomics.com

# install requirements
ENV DEBIAN_FRONTEND noninteractive
RUN \
  apt-get update && \
  apt-get install -y g++ curl git htop man unzip make wget libssl-dev pkg-config npm && \
  rm -rf /var/lib/apt/lists/* 

RUN apt-get install -y python-pip python-dev build-essential && \
 pip install --upgrade pip  && \
 pip install --upgrade virtualenv  && \
 pip install supervisor --pre


# Set environment variables.
#ENV HOME /root

# Install Node.js
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/v0.10.29/node-v0.10.29-linux-x64.tar.gz && \
  tar xvzf node-v0.10.29-linux-x64.tar.gz && \
  rm -f node-v0.10.29-linux-x64.tar.gz

# Install ZMQ
RUN \
  wget http://download.zeromq.org/zeromq-3.2.4.tar.gz && \
  tar xzf zeromq-3.2.4.tar.gz && \
  cd /zeromq-3.2.4  && \
  ./configure && make && make install && \
  ldconfig

# Add Node & npm to PATH
ENV PATH /tmp/node-v0.10.29-linux-x64/bin:$PATH

CMD ["/bin/bash"]