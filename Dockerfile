FROM maven:3.9.11-eclipse-temurin-11-alpine AS build
RUN apk add --no-cache git
RUN git clone https://github.com/spring-projects/spring-petclinic.git && \
     cd spring-petclinic && \
     mvn package -DskipTests
FROM openjdk:25-ea-17-jdk AS run
RUN adduser -D -h /usr/share/demo -s /bin/bash user1
USER user1
WORKDIR /usr/share/demo 
COPY --from=build /target/*.jar app.jar
EXPOSE 8080
CMD ["java","-jar","app.jar"] 