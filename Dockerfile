FROM mysql:5.7 as db

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=dvwa
ENV MYSQL_USER=dvwa
ENV MYSQL_PASSWORD=p@ssw0rd

# Install Apache + PHP in another container
FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Download DVWA
RUN git clone https://github.com/digininja/DVWA.git /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Enable Apache Rewrite Module
RUN a2enmod rewrite

EXPOSE 80
