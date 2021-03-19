sudo apt-get update
sudo apt install python3-pip -y

pip3 install flask_restful
pip3 install flask

sudo chmod +x /home/vagrant/main.py
sudo nohup /home/vagrant/main.py &
