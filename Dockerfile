FROM webdevops/php-apache:alpine

# @env directus versions
ENV DIRECTUS_VERSION=6.4.9

# @run clone
RUN curl -L "https://github.com/directus/directus/archive/${DIRECTUS_VERSION}.zip" -o directus.zip
RUN rmdir /app && unzip directus.zip && rm directus.zip && mv directus-${DIRECTUS_VERSION} /app

# @run own directus
RUN chown -R application:www-data /app && chmod -R 755 /app

# @workdir go to directus
WORKDIR /app

# @user regular user for composer
USER application

# @run install composer
RUN composer install

# @user switch back to root
USER root