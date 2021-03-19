sudo chmod +x /home/vagrant/main.py
sudo cp /home/vagrant/api.service /lib/systemd/system/
sudo systemctl daemon-reload

sudo apt-get update
sudo apt install python3-pip -y

pip3 install flask_restful
pip3 install flask

sudo systemctl enable api.service
sudo systemctl start api.service