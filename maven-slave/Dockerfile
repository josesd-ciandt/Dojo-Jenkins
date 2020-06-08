FROM jenkins:alpine

ENV JAVA_VERSION="8.0.252-open"
ENV MAVEN_VERSION="3.6.3"

# Defining default non-root user UID, GID, and name
ENV SDKMAN_DIR=/root/.sdkman

USER root

RUN apk --update add zip
RUN apk --update add curl

# Downloading SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config

RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install maven $MAVEN_VERSION"

# ENTRYPOINT bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && $0 $@" 

ENV MAVEN_HOME="/home/jenkins/.sdkman/candidates/maven/current" 
ENV JAVA_HOME="/home/jenkins/.sdkman/candidates/java/current" 
ENV PATH="$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"
