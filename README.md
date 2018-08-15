# docker-service-cakephp

this is a simple Dockerfile/Docker-Compose-File Combination for local testing of a CakePHP App.

## Version
CakePHP 3.X

## Usage
1. run docker-compose up
2. check http://localhost:4000

## Additional Packages
If you want to install additional Composer-Packages Add them to Dockerfile near
    # Install Additional Composer packages

## E-Mail issues
There is no sendmail support built in container. Configure your App to use a smtp connection.

## Cron Jobs
This image comes with cron jobs. You can add a 15minutely scheduled cron by defining it in config_docker/cron (see the example in there)
