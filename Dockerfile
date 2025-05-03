FROM eclipse-temurin:17
LABEL maintainer="jilopez" 
COPY /target/*.jar /home/spring-petclinic.jar 
CMD ["java","-jar","/home/spring-petclinic.jar"]
