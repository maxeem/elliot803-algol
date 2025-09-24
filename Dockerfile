FROM openjdk:17-slim

WORKDIR /elliott803

COPY sources/elliot/elliott803-1.2.0.jar /elliott803/

# Expose a volume for working files
VOLUME ["/work"]

ENTRYPOINT ["java", "-jar", "/elliott803/elliott803.jar"]
