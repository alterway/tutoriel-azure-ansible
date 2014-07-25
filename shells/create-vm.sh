#!/bin/bash
E=""
cowsay `echo "$E[47;32;7mI will create 6 Vms$E[0m"`
sleep 2

image="b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-12_04_4-LTS-amd64-server-20140514-en-us-30GB"


for i in 1 2 3 4 5 6
do
azure vm create --affinity-group VOTRE-GROUPE-AFFINITE \
--vm-size small \
--no-ssh-password \
--ssh 22 \
--ssh-cert ../certs/VOTRE-CERTIFICAT.pem \
--virtual-network-name VOTRE-VIRTUAL-NETWORK \
--subnet-names VOTRE-SUBNET \
LA-RACINE-DU-NOM-DE-VOS-VM${i} ${image} devops VOTRE-MOT-DE-PASSE
status=$?
if test $status -eq 0
then
  cowsay `echo "$E[47;32;7mVM LA-RACINE-DU-NOM-DE-VOS-VM${i} created$E[0m"`
else
  cowsay `echo "$E[47;31;7mFailed to create vm LA-RACINE-DU-NOM-DE-VOS-VM${i}$E[0m"`
  exit $status
fi

sleep 30 

if [ "$i" = "5" ]; then
  cowsay `echo "$E[47;32;7mEndpoint 80 for varnish m5$E[0m"`
  azure vm endpoint create LA-RACINE-DU-NOM-DE-VOS-VM${i} -n "HTTP" 80 80
fi
if [ "$i" = "6" ]; then
  cowsay `echo "$E[47;32;7mEndpoint 80 for varnish m5$E[0m"`
  azure vm endpoint create LA-RACINE-DU-NOM-DE-VOS-VM${i} -n "HTTP" 80 80
fi

done
