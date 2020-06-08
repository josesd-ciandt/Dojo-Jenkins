FROM jenkins:alpine

ENV JAVA_VERSION="8.0.252-open"
ENV MAVEN_VERSION="3.6.3"

# Defining default non-root user UID, GID, and name
ENV SDKMAN_DIR=/root/.sdkman

USER root

RUN apk --update add zip
RUN apk --update add curl

RUN apk --update add openjdk8-jre openssh git && \
    rm -rf /var/cache/apk/*

# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config

RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install maven $MAVEN_VERSION"

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && mv docker/* /usr/bin/ && chmod 755 /usr/bin/docker && rm -f /tmp/docker-latest.tgz

RUN delgroup ping


RUN adduser -D maven_user -s /bin/sh -G jenkins && \ 
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
