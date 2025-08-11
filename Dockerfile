FROM Maven:3.9.11-eclipse-temurin-11-alpine as build
RUN git clone https://github.com/spring-projects/spring-petclinic.git && \
     cd spring-petclinic && \
     mvn package
FROM openjdk:25-ea-17-jdk as run
RUN adduser -D -h /usr/share/demo -s /bin/bash user1
USER user1
WORKDIR /usr/share/demo 
COPY --from=build /target/*.jar .
EXPOSE 8080
CMD ["java","-jar",".jar"] 