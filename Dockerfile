FROM maven:3.6.3-jdk-16 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:16-jdk
VOLUME /tmp
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
