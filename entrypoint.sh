#!/bin/sh

echo "JENKINS_PORT=${JENKINS_PORT} in entrypoint.sh"

java -Dfile.encoding=UTF-8 \
-Dmail.smtp.starttls.enable=true \
-jar \
/usr/share/jenkins/jenkins.war \
--httpPort=${JENKINS_PORT}
