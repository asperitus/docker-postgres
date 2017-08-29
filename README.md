# docker-postgres

Running PostgresSQL on Predix/Cloud Foundry

cf push $app_bame --docker-image asperitus/postgres --health-check-type process -i 1 -m 512M -k 2G 