# gyant-challenge
gyant-challenge-app



AWS KEY Pair: 
aws ec2 create-key-pair --key-name deployer --query "deployer" --output text > deployer.pem

Create Keys Pairs (Private & Public Key)
$ ssh-keygen -t rsa



AWS Commands: 

$aws configure


-> Clone the Node app files from GIT to Server:
$git clone https://github.com/GYANTINC/gyant-challenge-app.git

-> Run node.js app on server: 
    $npm install
    $node index.js

- Keep App running using PM2
    $sudo npm install pm2 -g
    $sudo pm2 start index.js
    
    $pm2 status









-> User Access APP


{
  "name": "Tiago Pimenta",
  "email": "tpimenta@doctor.com",
  "password": "teste"
}