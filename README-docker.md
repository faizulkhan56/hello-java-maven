# 📦 Dockerized Hello Java Maven HTTP Server

This guide explains how to build and run your `hello-java-maven` project inside a Docker container using multi-stage builds.

---

## 🧱 Project Structure

```
hello-java-maven/
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── example/
│                   └── App.java
├── pom.xml
├── Dockerfile
```

---

## 🐳 Dockerfile

Place this `Dockerfile` in the root of your project:

```dockerfile
# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run with JRE only
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/hello-java-maven-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

## 🔨 Build Docker Image

From your project directory:

```bash
docker build -t hello-java-maven .
```

---

## 🚀 Run the Container

```bash
docker run -d -p 8080:8080 --name hello-maven-app hello-java-maven
```

---

## 🌐 Access the Application

Visit in your browser or curl:

```
http://localhost:8080/
```

Expected output:

```
Hello from Java HTTP Server!
```

---

## 🧹 Cleanup

To stop and remove the container:

```bash
docker stop hello-maven-app
docker rm hello-maven-app
```

To remove the image:

```bash
docker rmi hello-java-maven
```

---

## 📄 License

MIT or for personal learning use.

