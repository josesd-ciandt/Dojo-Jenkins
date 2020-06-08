FROM jenkins:alpine

ENV JAVA_VERSION="8.0.252-open"
ENV GRADLE_VERSION="4.10"
ENV SDKMAN_DIR=/root/.sdkman

USER root

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && mv docker/* /usr/bin/ && chmod 755 /usr/bin/docker && rm -f /tmp/docker-latest.tgz

RUN apk --update add zip
RUN apk --update add curl
RUN apk --update add openjdk8-jre openssh git && \
    rm -rf /var/cache/apk/*

RUN delgroup ping

RUN adduser -D gradle_user -s /bin/sh -G jenkins && \
    chown -R gradle_user:jenkins /home/gradle_user && \
    echo "gradle_user:jenkins" | chpasswd && \
    addgroup -g 999 $USER docker && \
    sed -ri 's/(docker:x:999:)/\1gradle_user/' /etc/group

# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config

RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install gradle $GRADLE_VERSION"

RUN ssh-keygen -A

RUN set -x && \
    echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "AllowGroups jenkins" >> /etc/ssh/sshd_config

RUN apk --update add sudo && \
    rm -rf /var/cache/apk/* && \
    echo "gradle_user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
RUN touch ~/.sudo_as_admin_successful
WORKDIR /home/gradle_user

USER root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
