# --- Etapa de construcción ---
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# 1. Copiamos todo tu repositorio al contenedor
COPY . .

# 2. IMPORTANTE: Nos movemos a la subcarpeta que realmente tiene tu código y el gradlew
WORKDIR /app/calculadora

# 3. Damos permisos y compilamos el proyecto
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

# 4. Buscamos el archivo .jar generado y lo mandamos a la raíz
RUN find . -type f -name "*-SNAPSHOT.jar" ! -name "*-plain.jar" -exec cp {} /app.jar \;

# --- Etapa de ejecución ---
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# 5. Traemos ese "app.jar" listo para ejecutarse
COPY --from=build /app.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]