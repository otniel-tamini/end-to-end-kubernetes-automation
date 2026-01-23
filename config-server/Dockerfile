FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

COPY config-server/pom.xml .
COPY config-server/src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-focal
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 1000
ENTRYPOINT ["java", "-jar", "app.jar"]