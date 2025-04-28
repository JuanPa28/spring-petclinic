# Usa la imagen de OpenJDK 17
FROM openjdk:17-jdk-slim

# Copia el archivo JAR compilado desde el directorio target al contenedor
COPY target/spring-petclinic*.jar app.jar

# Establece el comando para ejecutar el JAR al iniciar el contenedor
ENTRYPOINT ["java", "-jar", "/app.jar"]
