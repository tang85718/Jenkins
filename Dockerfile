FROM debian:latest

ENV JENKINS_PORT 8080

EXPOSE $JENKINS_PORT
COPY entrypoint.sh /entrypoint.sh 

RUN apt-get update \ 
&& apt-get install -y wget \
&& apt-get install -y curl \
&& apt-get install -y gnupg \
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install -y nodejs \
&& wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - \
&& echo deb http://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list \
&& apt-get update \
&& apt-get install -y jenkins \
&& export JENKINS_PORT=$JENKINS_PORT \
&& echo "${JENKINS_PORT} in dockerfile"

ENTRYPOINT ["entrypoint.sh"]

#CMD ["java", "-Dfile.encoding=UTF-8", "-Dmail.smtp.starttls.enable=true", "-jar", "/usr/share/jenkins/jenkins.war", "--httpPort=$HTTPPORT"]
