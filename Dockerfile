FROM liammartens/php

# @env directus versions
ENV DIRECTUS_VERSION=6.4.9

# @user root for build
USER root

# @run clone
RUN curl -L "https://github.com/directus/directus/archive/${DIRECTUS_VERSION}.zip" -o directus.zip
RUN unzip directus.zip && rm directus.zip && mv directus-${DIRECTUS_VERSION} /directus

# @run own directus
RUN chown -R ${USER}:${USER} /directus && chmod -R 750 /directus

# @workdir go to directus
WORKDIR /directus

# @user back to regular user
USER ${USER}

# @run install composer
RUN composer install