FROM debian:latest

ENV JENKINS_PORT 8081

EXPOSE $JENKINS_PORT
WORKDIR /
COPY entrypoint.sh /

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
&& echo "${JENKINS_PORT} in dockerfile" \
&& chmod 777 entrypoint.sh \

ENTRYPOINT ["./entrypoint.sh"]
