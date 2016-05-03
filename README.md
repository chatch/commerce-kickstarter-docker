# commerce-kickstarter-docker
Docker container for Commerce Kickstarter using the same apache php setup as the drupal official Dockerfile.

Installs drush to /usr/local/bin.

## Get started
* create a MySql database and user (example: [init.sql](https://github.com/chatch/commerce-kickstarter-docker/blob/master/init.sql))
* docker build --tag=kickstarter .
* docker run -d --name=kickstarter kickstarter
