apt-get -y update
apt-get -y install nginx
service nginx start


sudo unlink /etc/nginx/sites-enabled/default
cp /home/vagrant/server_configuration /etc/nginx/sites-available/

sudo ln -s /etc/nginx/sites-available/server_configuration /etc/nginx/sites-enabled/


sudo service nginx configtest
sudo service nginx restart
