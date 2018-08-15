# docker-service-cakephp

this is a simple Dockerfile/Docker-Compose-File Combination for local testing of a CakePHP App.

## Version
CakePHP 3.X

## Usage
1. run docker-compose up
2. check http://localhost:4000

## Additional Packages
If you want to install additional Composer-Packages got into your container and use "composer install package_name"

## Cron Jobs
This image comes with cron jobs. You can add a 15minutely scheduled cron by defining it in config_docker/cron (see the example in there)
