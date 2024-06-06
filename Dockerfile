FROM ubuntu:22.04

RUN apt update && apt install  openssh-server sudo -y

RUN useradd -rm -s /bin/bash -g root -G sudo -u 1000 node

RUN  echo 'node:node1234' | chpasswd

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
