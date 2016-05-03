CREATE DATABASE kickstart;
CREATE USER 'kickstart'@'%' IDENTIFIED BY 'kickstart';
GRANT ALL PRIVILEGES ON kickstart.* TO 'kickstart'@'%' IDENTIFIED BY 'kickstart';
