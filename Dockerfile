FROM ubuntu:18.04

RUN apt update && apt install software-properties-common -y && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt install ansible iputils-ping -y \
    && rm -rf /var/lib/apt/lists/*
RUN useradd --create-home --shell /bin/bash agent
RUN mkdir /var/run/sshd
RUN mkdir /root/.ssh
WORKDIR /root/
COPY inventory.yaml .
COPY inventory.txt .
COPY playbooks .
RUN ssh-keygen -t rsa -C ansible_master -f ~/.ssh/id_rsa
RUN mkdir /keyshare
RUN cp ~/.ssh/id_rsa.pub /keyshare/master.pub
