FROM maven:3.8-openjdk-8 AS build
RUN pwd
WORKDIR /app
COPY . .
#RUN ["mvn","clean","install","-DskipTests"]
RUN mvn clean install

#FROM tomcat:8.5.35-jre10
#FROM tomcat:9.0.70-jdk8-corretto
#EXPOSE 8080
#WORKDIR /usr/local/tomcat/webapps
#COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.war ./petclinic.war
#CMD chmod +x /usr/local/tomcat/bin/catalina.sh
#CMD ["catalina.sh", "run"]

RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.70/bin/apache-tomcat-9.0.70.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat*/* /opt/tomcat/.


WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war
RUN cp /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.war /opt/tomcat/webapps/petclinic.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]