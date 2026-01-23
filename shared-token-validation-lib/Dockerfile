# =========================
# Stage 1: Build
# =========================
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copier uniquement les fichiers Maven pour le cache
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copier le code source
COPY src ./src

# Build du jar
RUN mvn clean package -DskipTests

# =========================
# Stage 2: Runtime
# =========================
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Sécurité : utilisateur non-root
RUN useradd -r -u 1001 spring
USER spring

# Copier le jar depuis le stage build
COPY --from=build /app/target/*.jar app.jar

#EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
