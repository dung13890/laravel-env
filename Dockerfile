FROM ubuntu:16.04

MAINTAINER Dao Anh Dung <dung13890@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install packages

ADD provision.sh /provision.sh

RUN chmod +x /*.sh

RUN ./provision.sh

WORKDIR /var/www/apps
