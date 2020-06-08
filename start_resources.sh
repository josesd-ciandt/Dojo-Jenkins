#bin/bash
echo "-----------------------"
echo "| PARANDO CONTAINERES |"
echo "-----------------------"
docker-compose down
docker rm $(docker ps -qa)

echo "-------------------------"
echo "| REMOVENDO CONTAINERES |"
echo "-------------------------"
docker rm $(docker ps -qa)

echo "---------------------"
echo "| REMOVENDO IMAGENS |"
echo "---------------------"
docker rmi jenkins-nodesj:latest jenkins-maven:latest jenkins-gradle:latest


echo "----------------------------------"
echo "| FAZENDO BUILD SLAVE COM NODEJS |"
echo "----------------------------------"
docker build -t jenkins-nodejs ./nodejs-slave/


echo "---------------------------------"
echo "| FAZENDO BUILD SLAVE COM MAVEN |"
echo "---------------------------------"
docker build -t jenkins-maven ./maven-slave/

echo "----------------------------------"
echo "| FAZENDO BUILD SLAVE COM GRADLE |"
echo "----------------------------------"
docker build -t jenkins-gradle ./gradle-slave/

echo "------------------------"
echo "| INICIANDO APLICAÇÔES |"
echo "------------------------"
docker-compose up
