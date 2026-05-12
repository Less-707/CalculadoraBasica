# --- Etapa de construcción ---
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# 1. Copiamos TODAS las carpetas y archivos tal cual los tienes en tu computadora
COPY . .

# 2. Damos permisos y compilamos el proyecto
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

# 3. Buscamos el archivo .jar generado (sin importar en qué subcarpeta lo haya guardado Gradle)
# y lo movemos a la raíz del contenedor llamándolo "app.jar"
RUN find . -type f -name "*-SNAPSHOT.jar" ! -name "*-plain.jar" -exec cp {} /app.jar \;

# --- Etapa de ejecución ---
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# 4. Traemos ese "app.jar" listo para ejecutarse
COPY --from=build /app.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]