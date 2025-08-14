FROM Maven:3.9.11-eclipse-temurin-17-alpine AS build
RUN git clone https://github.com/saketh0211/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package



FROM openjdk:25-ea-17-jdk AS run
RUN adduser -D -h /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR usr/share/demo
COPY --from=build /target/*.jar .
EXPOSE 8080/tcp
CMD ["jav","-jar","*.jar"]





