#!/bin/sh

echo "JENKINS_PORT=${HTTPPORT}"

java -Dfile.encoding=UTF-8 \
-Dmail.smtp.starttls.enable=true \
-jar \
/usr/share/jenkins/jenkins.war \
--httpPort=$HTTPPORT
