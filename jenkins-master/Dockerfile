FROM jenkins:alpine

ENV VERSION "0.0.1"

USER root

RUN mkdir -p "${JENKINS_HOME}/jobs" "${ITEM_ROOTDIR}/builds"

USER jenkins

RUN echo "lts" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo "lts" > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
# Para configuracoes de Seguranca


# Plugins Install
COPY --chown="jenkins:jenkins" plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
