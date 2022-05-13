FROM openjdk:17-jdk-alpine
VOLUME /tmp
EXPOSE 8080
RUN mkdir -p /app/
RUN mkdir -p /app/logs/
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$RELEASE-linux.zip -O /opt/sonarscanner.zip && \
     cd /opt && \
     unzip sonarscanner.zip && \
     rm sonarscanner.zip && \
     rm sonar-scanner-$RELEASE-linux/jre -rf
ENV SONAR_RUNNER_HOME=/opt/sonar-scanner-$RELEASE-linux
ENV PATH $PATH:/opt/sonar-scanner-$RELEASE-linux/bin
ADD target/api-client-0.0.1-SNAPSHOT.jar /app/api-client-0.0.1-SNAPSHOT.jar
CMD [ "sonar-scanner", "-Dsonar.projectBaseDir=./" ]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container", "-jar", "/app/api-client-0.0.1-SNAPSHOT.jar"]


