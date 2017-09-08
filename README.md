# Jenkins

## volume
/data

## 环境变量 
- JENKINS_PORT: 8081
- JENKINS_HOME: /data/jenkins/home

```shell
docker run -d -p 8081:8081 -v ~/docker/jenkins:/data dauglastang/jenkins
```
