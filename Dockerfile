from ubuntu:precise

maintainer dj

run apt-get update
run apt-get install -y build-essential git
run apt-get install -y python python-dev python-setuptools
run apt-get install -y nginx supervisor
run easy_install pip

# install uwsgi now because it takes a little while
run pip install uwsgi

# install nginx
run apt-get install -y python-software-properties
run apt-get update
RUN add-apt-repository -y ppa:nginx/stable
run apt-get install -y sqlite3

# install our code
add . /opt/django/

# setup all the configfiles
run echo "daemon off;" >> /etc/nginx/nginx.conf
run rm /etc/nginx/sites-enabled/default
run ln -s /opt/django/nginx-app.conf /etc/nginx/sites-enabled/
run ln -s /opt/django/supervisor-app.conf /etc/supervisor/conf.d/

# run pip install
run pip install -r /opt/django/requirements.txt

# install django, normally you would remove this step because your project would already
# be installed in the code/app/ directory
run django-admin.py startproject website /opt/django/ 

expose 80
# cmd ["supervisord", "-n"]
CMD ["/opt/django/run.sh"]
