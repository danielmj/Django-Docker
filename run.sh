#!/bin/bash

# Lookup postgres endpoint
POSTGRES_HOST=postgres

# Lookup redis endpoint
REDIS_HOST=redis

# Export environment variables
export POSTGRES_HOST REDIS_HOST

# Setup database migrations
cd /opt/django
python manage.py makemigrations
python manage.py migrate

# Collect static files
python manage.py collectstatic -v0 --noinput

supervisord -n
