#!/bin/bash -e

source /root/.restic-env

# Hot backup
cd /mnt/backups/pictrs
rsync -avzpogltr /mnt/discuss_online_backend_docker_volumes/pictrs/* ./

# Cold backup
cd /opt/docker
docker-compose stop pictrs
cd /mnt/backups/pictrs
rsync -avzpogltr /mnt/discuss_online_backend_docker_volumes/pictrs/* ./
cd /opt/docker
docker-compose start pictrs

# Offsite backup
docker-compose run backup backup /mnt/backups

