FROM debian:latest

VOLUME /data

ENV JENKINS_PORT 8081
ENV JENKINS_HOME /data/jenkins/home

EXPOSE $JENKINS_PORT

WORKDIR /
COPY entrypoint.sh /

RUN apt-get update \ 
&& apt-get install -y wget \
&& apt-get install -y curl \
&& apt-get install -y gnupg \
&& apt-get install -y git-all \
&& apt-get install -y build-essential libsqlite3-dev zlib1g-dev libncurses5-dev libgdbm-dev libbz2-dev libreadline-gplv2-dev libssl-dev libdb-dev tk-dev \
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs \
&& pushd /opt && wget http://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz \
&& tar -xzf Python-2.7.13.tgz && cd Python-2.7.13 && ./configure --prefix=/usr --enable-shared \
&& make && make install && cd .. \
&& update-alternatives --install /usr/bin/python python /usr/bin/python2.6 20 \
&& update-alternatives --install /usr/bin/python python /usr/bin/python2.7 10 \
&& update-alternatives --set python /usr/bin/python2.6 \
&& wget http://peak.telecommunity.com/dist/ez_setup.py \
&& python2.7 ez_setup.py \ 
&& easy_install-2.7 virtualenv && popd \
&& wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - \
&& echo deb http://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list \
&& apt-get update \
&& apt-get install -y jenkins \
&& export JENKINS_PORT=$JENKINS_PORT \
&& echo "${JENKINS_PORT} in dockerfile" \
&& cd / && chmod -x entrypoint.sh && ls 

ENTRYPOINT ["./entrypoint.sh"]
