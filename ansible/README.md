
Sources pour le tutoriel IAAS Azure piloté par Ansible et Azure Cli

Le projet est détaillé dans le wiki du repo : http://blog.alterway.fr/wp-content/uploads/2014/07/Untitled.png


Faites un grep -r 10.2.0 * pour trouver toutes les adresses IP utilisées

Changez les avec celles que vous utilisez dans vos subnets

chez moi : 

10.2.0.4 : vm1 front web
10.2.0.5 : vm2 front web
10.2.0.6 : vm3 master bdd
10.2.0.7 : vm4 slave bdd
10.2.0.8 : vm5 varnish
10.2.0.9 : vm6 kibana
  

ansible-cluster
===============

An example configuration for a web app using several servers

I arbitrarily assume that your `ansible_host` file is located in the same directory and is named `ansible_host`. Feel free to adjust to your settings

# ATTENTION
I have included sample ssh keys. These are **not** intended to be used in real. Delete them and the setup.sh will automatically generate new unique keys for you.

## First init phase
`ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook site.yml -i ansible_host -t init --ask-pass`

This step will setup your vms in a way that you can directly ssh into them because this is the basic requirement for ansible to work.

`SSH encountered an unknown error during the connection`
maybe wrong fingerprint in known_hosts

## Start
`ansible-playbook site.yml -i ansible_host --skip-tags=init --forks=1`

## Available Tags
* init
* setup_db
* setup_db_cluster
* setup_web
* setup_load_balancer
* install_app
* update_app

# Before start
* add the public key of the machine from where you run ansible to `group_vars/all`

## Known issues
* add `-f 1` when running multiple (vagrant) machines on one host. Otherwise apt-get often exits with an error during update or install
