FROM debian:latest

ENV HTTPPORT 8080

RUN apt-get update \ 
&& apt-get install -y wget \
&& apt-get install -y curl \
&& apt-get install -y gnupg \
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install -y nodejs \
&& wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - \
&& echo deb http://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list \
&& apt-get update \
&& apt-get install -y jenkins

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war", "--httpPort=$HTTPPORT"]
