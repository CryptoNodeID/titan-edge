#!/bin/bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove -qy $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -qy docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker

sudo docker pull nezha123/titan-edge
mkdir ~/.titanedge
while [[ -z "$identity" ]]
do
  echo "go to this link to get identity key hash: https://titannet.gitbook.io/titan-network-en/huygens-testnet/installation-and-earnings/bind-the-identity-code"
  read -p "Please enter identity key hash: " identity
done

tee start_titan.sh > /dev/null <<EOF
sudo docker run --name titan-edge -d -v ~/.titanedge:/root/.titanedge nezha123/titan-edge
EOF
chmod ug+x start_titan.sh
tee stop_titan.sh > /dev/null <<EOF
  sudo docker stop titan-edge
EOF
chmod ug+x stop_titan.sh
tee bind_identity.sh > /dev/null <<EOF
  sudo docker exec -it titan-edge /bin/bash -c "titan-edge bind --hash=${identity} https://api-test1.container1.titannet.io/api/v2/device/binding"
EOF
chmod ug+x bind_identity.sh