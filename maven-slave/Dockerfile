FROM maven:alpine

USER root

RUN apk --update add zip
RUN apk --update add curl

RUN apk --update add openjdk8-jre openssh git && \
    rm -rf /var/cache/apk/*

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && mv docker/* /usr/bin/ && chmod 755 /usr/bin/docker && rm -f /tmp/docker-latest.tgz

RUN delgroup ping


RUN addgroup jenkins && \
    adduser -D maven_user -s /bin/sh -G jenkins && \ 
    chown -R maven_user:jenkins /home/maven_user && \
    echo "maven_user:maven_user" | chpasswd && \
    addgroup -g 999 $USER docker && \
    sed -ri 's/(docker:x:999:)/\1maven_user/' /etc/group

RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
    echo "maven_user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER maven_user
RUN touch ~/.sudo_as_admin_successful
WORKDIR /home/maven_user

USER root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
