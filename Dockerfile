FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY target/*.war /usr/local/tomcat/webapps/java-web-app-docker.war
EXPOSE 7070 8080
