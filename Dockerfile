# Use Maven image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy pom and source code
COPY pom.xml .
COPY src ./src

# Build the JAR
RUN mvn clean package -DskipTests

# ------------------------

# Use lightweight JRE image for running
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy built JAR from the previous stage
COPY --from=build /app/target/hello-java-maven-1.0-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]

