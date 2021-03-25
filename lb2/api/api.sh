sudo chmod +x /home/vagrant/main.py
#creating api service
sudo cp /home/vagrant/api.service /lib/systemd/system/
sudo systemctl daemon-reload

#Updates
sudo apt-get update

#downloading python and installing dependencies
sudo apt install python3-pip -y
pip3 install flask_restful
pip3 install flask

#enabling the set Service
sudo systemctl enable api.service
sudo systemctl start api.service