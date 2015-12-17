# Django, uWSGI and Nginx in a container

This project is an extension to [Dockerfiles django-uwsgi-nginx](https://github.com/dockerfiles/django-uwsgi-nginx) repo. This projects differences:

1. All files are stored in /opt/django/ folder rather than the home directory.
2. The django project is also stored in that directory.
3. A run.sh script is utilized to sync the db and collect static prior to running.

### Create your project

Navigate to this directory and type:

* django-admin startproject website

### Build and run

* docker build -t <image-name> .
* docker run -d <image-name>

---

### Pull postgres

* docker pull postgres
* docker run -d --name postgres -p 5432:5432 postgres

### Pull redis

* docker pull dockerfile/redis
* docker run -d --name redis -p 6379:6379 dockerfile/redis

### Run - Link postgres & redis

Modify your django project settings to include the settings for the postgres & redis server. 

Then run the server:

* docker run -d -p 8000:80 --link postgres:postgres --link redis:redis --name <container-name> <image-name> supervisord -n

---

### Test

Get the IP for the server:

* docker inspect <container_id> | grep IPAddress | cut -d '"' -f 4

Navigate the browser to this IP.



