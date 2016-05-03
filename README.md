# commerce-kickstarter-docker
Docker container for Commerce Kickstarter using the same apache php setup as the drupal official Dockerfile.

Installs drush to /usr/local/bin.

## Build and run image
* create a MySql database and user (example: [init.sql](https://github.com/chatch/commerce-kickstarter-docker/blob/master/init.sql))
* docker build --tag=kickstarter .
* docker run -d --name=kickstarter kickstarter

## Configure kickstart
Use the web browser or drush for this step.

### Browser
Navigate to kickstart on port 80 of the docker container (eg. http://172.17.0.2) and follow the steps.

To get the container ip address use this command:
```
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container id or name>
```

### Drush
Run the site install command. For example:
```
drush -y si commerce_kickstart --db-url=mysql://kick:kick@mysql.host/kick \
                --db-prefix="kick_" \
                --account-name=ksadmin --account-pass=ksadmin --account-mail=ksadmin@commerce.com \
                --site-name=kicktest --site-mail=ksadmin@commerce.com \
                --sites-subdir=kicktest
```
