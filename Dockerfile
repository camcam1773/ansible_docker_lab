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
COPY master_key .
RUN chmod 600 master_key
