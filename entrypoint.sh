#!/bin/sh
wait_until_port() {
    host="${1}"
    port="${2}"

    while ! nc -z "${host}" "${port}"; do
        echo "Port not reachable, waiting for 10 seconds..."
        sleep 10
    done
}
wait_until_port "db" "3306"


java -Xms64m -Xmx128m -Ddatasource.dialect="${DB_DIALECT}" \
-Ddatasource.url="${DB_URL}" \
-Ddatasource.username="${DB_USER}" \
-Ddatasource.password="${DB_PASS}" \
-Dspring.profiles.active="${SPRING_PROFILE}" \
-jar /app/lavagna-jetty-console.war --headless


