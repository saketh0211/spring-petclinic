FROM maven:3.9.11-eclipse-temurin-17-alpine AS build
RUN apk add --no-cache git
RUN git clone https://github.com/saketh0211/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package



FROM openjdk:25-ea-17-jdk AS run
RUN adduser -D -h /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
COPY --from=build /spring-petclinic/target/*.jar .
EXPOSE 8080/tcp
CMD ["java","-jar","spring-petclinic-3.5.0-SNAPSHOT.jar"]





