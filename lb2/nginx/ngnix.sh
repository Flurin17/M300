
#Updates
apt-get -y update

#downloading and starting nginx
apt-get -y install nginx
service nginx start

#changing default nginx configuration
sudo unlink /etc/nginx/sites-enabled/default
cp /home/vagrant/server_configuration /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/server_configuration /etc/nginx/sites-enabled/

#testing config and restarting
sudo service nginx configtest
sudo service nginx restart
