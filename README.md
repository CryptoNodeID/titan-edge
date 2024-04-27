### Prerequisite :
#### Ensure 'git' already installed
    apt-get update -y && apt-get install git -y
### Steps
#### Clone this repository :
    git clone https://github.com/CryptoNodeID/titan-edge.git
#### run setup command : 
    cd titan-edge && chmod ug+x *.sh && ./setup.sh
#### follow the instruction and then run below command to start the node :
    ./start_titan.sh && ./bind_identity.sh
### Available helper tools :
    ./start_titan.sh
    ./stop_titan.sh
    ./bind_identity.sh