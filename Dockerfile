FROM openjdk:24-jdk
WORKDIR /app
COPY target/lab4-0.0.1-SNAPSHOT.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
