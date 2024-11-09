FROM maven:3.9-eclipse-temurin-22 AS build

WORKDIR /app

COPY . .

COPY .env .

RUN mvn package -DskipTests

FROM openjdk:22-bullseye

WORKDIR /app

COPY --from=build /app/.env .
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "--enable-preview", "-jar", "app.jar"]
