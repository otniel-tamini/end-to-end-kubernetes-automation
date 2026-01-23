# Étape de construction
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# 1. Installation de la librairie partagée (chemin relatif à la racine)
COPY shared-token-validation-lib /libs/shared-token-validation-lib
RUN mvn install -f /libs/shared-token-validation-lib/pom.xml

# 2. Construction du service (chemins relatifs à la racine)
COPY user-service/pom.xml .
COPY user-service/src ./src
RUN mvn clean package -DskipTests

# Étape d'exécution
FROM eclipse-temurin:17-jre-focal
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]