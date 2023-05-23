# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-11-slim AS builder

# Set the working directory
WORKDIR /app

# Clone the OpenMRS Core repository
RUN git clone https://github.com/GitPracticeRepositorys/openmrs-core.git

# Change to the cloned repository directory
WORKDIR /app/openmrs-core

# Build the project using Maven
RUN mvn clean install -DskipTests

# Use a new base image with Java installed
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built artifacts from the builder image
COPY --from=builder /app/openmrs-core/webapp/target/openmrs.war /app/openmrs.war

# Expose the default port for OpenMRS
EXPOSE 8080

# Set the entry point command to run OpenMRS
CMD ["java", "-jar", "openmrs.war"]
