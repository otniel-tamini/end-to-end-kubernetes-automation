# Étape de construction
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# 1. Installation de la librairie partagée
COPY shared-token-validation-lib /libs/shared-token-validation-lib
RUN mvn install -f /libs/shared-token-validation-lib/pom.xml

# 2. Construction du service (Chemins spécifiques au dossier order-service)
COPY order-service/pom.xml .
COPY order-service/src ./src
RUN mvn clean package -DskipTests

# Étape d'exécution
FROM eclipse-temurin:17-jre-focal
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 7003
ENTRYPOINT ["java", "-jar", "app.jar"]