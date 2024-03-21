FROM maven:3.8.4-openjdk-8-slim AS builder

WORKDIR /app

COPY . .


RUN  --mount=type=cache,target=/root/.m2 \ 
        mvn clean verify -DskipTests








FROM openjdk:8-jre-alpine


WORKDIR /app

ENV DB_DIALECT ""
ENV DB_URL jdbc:""
ENV DB_USER sa
ENV DB_PASS ""
ENV SPRING_PROFILE ""


COPY --from=builder /app/target/lavagna-jetty-console.war .
COPY --from=builder /app/entrypoint.sh .

RUN apk add --no-cache netcat-openbsd && chmod +x entrypoint.sh


EXPOSE 8080


ENTRYPOINT ["./entrypoint.sh"]
