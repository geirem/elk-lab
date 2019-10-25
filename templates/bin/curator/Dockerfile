FROM centos:7

COPY curator.repo /etc/yum.repos.d/
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
RUN yum install -y elasticsearch-curator
ENV LC_ALL=en_US.UTF-8
