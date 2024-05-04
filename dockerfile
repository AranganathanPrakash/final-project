FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar  spring-petclinic.jar
Expose 8080
CMD ["java", "-jar", "spring-petclinic.jar"]
