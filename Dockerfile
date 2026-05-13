FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -Dmaven.test.skip=true
FROM eclipse-temurin:25-jdk

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
ENV SPRING_PROFILES_ACTIVE=pro
ENTRYPOINT ["java","-jar","app.jar"]