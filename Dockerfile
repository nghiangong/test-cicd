# =========================
# 1. BUILD STAGE (Maven)
# =========================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy source code
COPY . .

# Build jar
RUN mvn clean package -DskipTests


# =========================
# 2. RUNTIME STAGE (Java)
# =========================
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy jar từ stage build
COPY --from=build /app/target/*.jar app.jar

# Port app chạy
EXPOSE 8081

# Run app
ENTRYPOINT ["java","-jar","app.jar"]