
AGENT_VERSION=2.202.1
CHROME_DRIVER_VERSION=101.0.4951.41

# Install agant
mkdir ~/myagent
wget -P ~/myagent https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz
tar zxvf ~/myagent/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz --directory ~/myagent

# Install Docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  
sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install Chromium
sudo apt update
sudo apt install chromium-browser

# set the CHROME_BIN environment variable to the agent
echo "CHROME_BIN=/snap/bin/chromium" >> ~/myagent/env.sh


# Install node
sudo apt -y install nodejs


# Fix permission problem with docker.sock
sudo chmod 666 /var/run/docker.sock


# Install Helm
curl -fsSL -o /tmp/get_helm.sh  https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 /tmp/get_helm.sh
/tmp/get_helm.sh


# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client



# Install Azure CLI
sudo apt remove azure-cli -y && sudo apt autoremove -y
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az --version


# Install tools
sudo apt -y install unzip
sudo  snap install yq
sudo apt -y install jq

# Download maven 3.6.3
wget https://www.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
 
# Untar downloaded file to /opt
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
 
# Install the alternative version for the mvn in your system
sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.6.3/bin/mvn 363
 
# Check if your configuration is ok. You may use your current or the 3.6.3 whenever you wish, running the command below.
sudo update-alternatives --config mvn


# Setup environment for Selenium

sudo apt update
sudo apt install -y unzip xvfb libxi6 libgconf-2-4


# Install OpenJDK
sudo apt -y install default-jdk

# Install Google Chrome
sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo bash -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list"
sudo apt -y update
sudo apt -y install google-chrome-stable


# Installing ChromeDriver
wget https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip 
sudo mv chromedriver /usr/bin/chromedriver 
sudo chown root:root /usr/bin/chromedriver 
sudo chmod +x /usr/bin/chromedriver 

