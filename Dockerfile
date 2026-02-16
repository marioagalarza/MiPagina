# Etapa 1: Build con Maven
FROM maven:3.9-eclipse-temurin-17 AS build
COPY . .
# Usamos el perfil de PROD para compilar
RUN mvn clean package -Pprod -DskipTests

# Etapa 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /target/*.jar app.jar

# Variables de entorno por defecto (se pueden sobrescribir en GCP)
ENV SPRING_PROFILES_ACTIVE=prod

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
