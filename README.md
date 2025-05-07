# Hello Java Maven HTTP Server

This project is a simple Java HTTP server built using Maven. It uses Java's built-in `HttpServer` class to serve a "Hello World" message over port `8080`.

---

## 🧰 System Setup (Ubuntu 22.04)

### 1. Install Java & Maven

```bash
sudo apt update
sudo apt install openjdk-17-jdk maven -y
```

Verify installations:

```bash
java -version
mvn -v
```

---
## 📁 mvn Project scaffolding
```
mvn archetype:generate -DgroupId=com.example \
    -DartifactId=hello-java-maven \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false

cd hello-java-maven
```

## 📁 Project Structure

```
hello-java-maven/
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── example/
│                   └── App.java
├── pom.xml
```

---

## 📦 Build Instructions

### Step-by-Step

```bash
cd hello-java-maven
mvn clean package
```

This creates a runnable JAR at:

```
target/hello-java-maven-1.0-SNAPSHOT.jar
```

---

## 🚀 Run Locally

```bash
java -jar target/hello-java-maven-1.0-SNAPSHOT.jar
```

You should see:

```
Server started on port 8080
```

Then go to:

```
http://<your-server-ip>:8080/
```

---

## 🖥️ Deploy as a Background Service with systemd

### Step 1: Create systemd service

```bash
sudo nano /etc/systemd/system/helloapp.service
```

Paste:

```ini
[Unit]
Description=Hello Java HTTP Server
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/hello-java-maven
ExecStart=/usr/bin/java -jar /home/ubuntu/hello-java-maven/target/hello-java-maven-1.0-SNAPSHOT.jar
SuccessExitStatus=143
StandardOutput=journal
StandardError=journal
Restart=always

[Install]
WantedBy=multi-user.target
```

### Step 2: Enable and Start the Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable helloapp
sudo systemctl start helloapp
```

### Step 3: Monitor Logs

```bash
journalctl -u helloapp -f
```

---

## 🌐 Allow Port 8080

```bash
sudo ufw allow 8080
```

Now access the app:

```
http://<your-server-ip>:8080/
```

---

## 🔍 Verify

```bash
curl http://localhost:8080/
```

Expected output:

```
Hello from Java HTTP Server!
```

---

## 📄 License

MIT or personal use

