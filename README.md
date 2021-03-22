# Cyber-Security---Projects

MH Cyber Security Projects - reference notes, revision for security certifications and Time capsule (covering all computer & networking technologies up to mid 2021).

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ELK Stack Network Diagram](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/diagrams/Automated_Azure_ELK_Stack_Network_Diagram.png "ELK Stack Network Diagram was drawn in draw.io package")

[Azure RedTeam Network Topology](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/diagrams/Azure_Generated_RedTeam_Network_Topology_Screenshot.png "Azure Generated RedTeam Network Topology Screenshot .png")

[Azure RedTeam ELK Network Topology](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/diagrams/Azure_Generated_RedTeam_ELK_Network_Topology_Screenshot.png "Azure Generated RedTeam ELK Network Topology Screenshot  .png ")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either;

- Recreate the entire deployment (as shown in the above Azure Generated Elk Stack Network diagram). The Azure generated diagrams are the actual diagram's, generated Azure.
- Select portions of the yml files, to install certain components, such as Filebeat.

The four ansible-playbooks listed below, are required to create/build the dvwa servers, Elk Server and install the logging (Filebeat) and system statistical (metricbeat) software.

- pentest.yml (downloads, installs & builds a docker dvwa-webserver container where ELK server can collect data from. [pentest.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/pentest.yml "pentest.yml script file")

- install-elk.yml (downloads, installs & builds a docker ELK container). [install-elk.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/install-elk.yml "install-elk.yml script file")

- filebeat-playbook.yml (installs Filebeat software to capture log data).  [filebeat-playbook.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/filebeat-playbook.yml "filebeat-playbook.yml script file")

- metricbeat-playbook.yml (installs Metricbeat software to capture OS & services data, from each server, for statistical purposes). [metricbeat-playbook.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/metricbeat-playbook.yml "metricbeat-playbook script file")

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

- Load Balancers provide Availability (1 of 3 security components of the CIA triad), by adding/increasing the availability of the resource/s.

Incorporation of a JumpBox into the network topology

- A JumpBox is a network segmented and hardened secured and monitored device (computer), connected in a network a network and used to access and manage devices across separate security zones, providing a controlled means of secure access across the overall IT topology and zones.
- The JumpBox (aka control node) becomes the SAW (Secure Administration Workstation).
- The JumpBox provides an organisation;
  
  1. the ability to monitor & control;
      1. Connectivity to the JumpBox - Remote only; as the JumpBox is isolated (via a secure gateway policy) from the local corporate infrastructure.
      2. All administrative functions, performed on the JumpBox.
  2. Administrative logon access, to the corporate IT infrastructure to perform administrative duties and tasks (on IT devices and the networks), within the corporate topology.
  3. In the event an issue arises or an administrative change has occurred within the corporate IT infrastructure, all commands, logs and data can be capture from the JumpBox and analysed. Providing a quick and easy way to investigate and isolate what/when and if something was administratively changed from the JumpBox. If not  then further (urgent) investigation will be required on devices, inside the corporate IT infrastructure, to investigate possible security breaches.

- The JumpBox provides Integrity & Confidentiality (the other 2 of 3 security components of the CIA triad).

Integrating an ELK server allows users to easily monitor and capture, from the vulnerable dvwa VMs, any changes to the VM's logs and system traffic.

- Filebeat's function - 
  A logging agent, running on the dvwa webserver/s, monitoring and recording _log files_ for specific changes & events (specified by a administrator) and send them to the ELK stack (ELK-1 server) for indexing.

- Metricbeat function -
 A logging agent, running on the dvwa webserver/s, periodically collecting _metrics and statistical data from the operating system/s and services_ and sending the data to the ELK stack (ELK-1 server) for analysis.

The configuration details of each machine may be found below.
_Note: The [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) was used to add/remove values from the table_.

| Name                 | Function                                            | Local IP Address | Public IP Address   | Azure Virtual HDW                        | Operating System   | Docker Container | Ansible | Location            |
|----------------------|-----------------------------------------------------|------------------|---------------------|------------------------------------------|--------------------|------------------|---------|---------------------|
| Jump-Box-Provisioner | Remote Gateway & Ansible configurator               | 10.1.0.4         | 40.115.65.102       | (Standard B1s (1 vcpus, 1 GiB memory)    | Linux Ubuntu 18.04 | V19.03.06        | V2.9.2  | Australia Southeast |
| Web-1                | Docker-dvwa                                         | 10.1.0.5         | refer load balancer | (Standard B1s (1 vcpus, 1 GiB memory)    | Linux Ubuntu 18.04 | V19.03.06        | V2.9.2  | Australia Southeast |
| Web-2                | Docker-dvwa                                         | 10.1.0.6         | refer load balancer | (Standard B1s (1 vcpus, 1 GiB memory)    | Linux Ubuntu 18.04 | V19.03.06        | V2.9.2  | Australia Southeast |
| Web-3                | Docker-dvwa                                         | 10.1.0.7         | refer load balancer | (Standard B1s (1 vcpus, 1 GiB memory)    | Linux Ubuntu 18.04 | V19.03.06        | V2.9.2  | Australia Southeast |
| ELK-1                | ELK stack - Elasticsearch, Logstash, and Kibana     | 10.2.0.4         | 52.146.9.65         | (Standard D2s v3 (2 vcpus, 8 GiB memory) | Linux Ubuntu 18.04 | V19.03.06        | V2.9.2  | East US             |
|                      |                                                     |                  |                     |                                          |                    |                  |         |                     |
| Load Balancer        | Load balances, dvwa servers; Web-1, Web-2 and Web-3 |                  | 40.115.66.139       |                                          |                    |                  |         |                     |

### Access Policies

Machines on the internal network IP are not exposed to the public Internet.

Only the Jump-Box-Provisioner machine can accept a connection from the Internet. Access to this machine is only allowed from the following public IP address:

- 101.188.134.120 via SSH (TCP 22)

- _Note:_ For the purpose of this project, the Load Balancer and ELK server can accept a connection from the Internet. In a normal environment, they would not be Internet facing. Access to these machines is only allowed from the same public IP address, 101.188.134.120.

  1. Load Balancer via HTTP (TCP 80)
  2. ELK via TCP 5601

- All three devices will respond to ICMP's from 101.188.134.120 for device and network connectivity testing purposes.

Machines within the internal network, can only be accessed via the Jump-Box-Provisioner, using SSH. (ICMP is also allowed, for device and network connectivity testing purposes).

- Using Private IP host address 10.1.0.4, the jump-Box-Provisioner can access;
  1. the ELK VM (Elk-1) via the internal Private IP range 10.2.0.0/24
  2. each Web VM's (Web-1, Web-2 & Web-3) via internal Private IP range 10.1.0.0/24
- _Note_ There is a Virtual network Peering link, providing connectivity between Private IP ranges 10.1.0.0/24 and 10.2.0.0/24 so the dvwa servers can ship data to the ELK server.

The LoadBalancer (load balancing dvwa - Webserver VM's (Web-1, Web-2 & Web-3)) can be accessed from the remote device (IP 101.188.134.120) via TCP Port 80 HTTP so the dvwa application can be used.

The ELK VM (ELK-1) can be accessed from the remote device (101.188.134.120) via a web browser and TCP Port 5601 so Filebeat and Metricbeat data can be displayed.

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses                      | Note                                                           |
|----------------------|---------------------|-------------------------------------------|----------------------------------------------------------------|
| Jump-Box-Provisioner | Yes                 | Public IP Host address 101.188.134.120    | Allow SSH & ICMP (from Remote/Home device), else Deny all      |
| ELK-1                | Yes                 | Public IP Host address 101.188.134.120    | Allow TCP 5601 & ICMP (from Remote/Home device), else Deny all |
| Load Balancer        | Yes                 | Public IP Host address 101.188.134.120    | Allow TCP 80 & ICMP (from Remote/Home device), else Deny all   |
| ELK-1                | No                  | Internal Private IP Host address 10.1.0.4 | Allow SSH & ICMP (from Jump-Box-Provisioner), else Deny all    |
| Web-1                | No                  | Internal Private IP Host address 10.1.0.4 | Allow SSH & ICMP (from Jump-Box-Provisioner), else Deny all    |
| Web-2                | No                  | Internal Private IP Host address 10.1.0.4 | Allow SSH & ICMP (from Jump-Box-Provisioner), else Deny all    |
| Web-3                | No                  | Internal Private IP Host address 10.1.0.4 | Allow SSH & ICMP (from Jump-Box-Provisioner), else Deny all    |                |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...

- Ansible is an open-source software provisioning, configuration management and application-deployment tool enabling infrastructure as code (running on many Unix-like systems) which can configure both Unix-like systems as well as Microsoft Windows.
- Ansible is easy to understand and learn, making any server  deployment, easy and scalable. No need for an individual or a team of people, to connect and configure each server individually.
- Servers can be configured and deployed by one set of scripts, running from a single device (eg, JumpBox) and a Script/s can be easy changed, to suit deployment of similar devices.
- The Scripts are able to deploy all aspects of a device. eg OS version, network settings, download and install applications, etc.

This playbook implements the following tasks:

- Gets & installs both; docker.io and Python3-pip (Current version at time of downloading),
- Increases the virtual memory, to run the docker container,
- Downloads and launches a docker - elk container. (image:sebp/elk:761),
  - Publishes TCP ports that ELK will use  (refer - [install-elk.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/install-elk.yml) file),
- Enables the docker (Kibana) service on boot.

The following screenshot [docker list -a output](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/docker_list_-a_output.png "docker screenshot output") displays the result of running _command_ `sudo docker container list -a` or `sudo docker ps` after successfully configuring the ELK instance.

### Target Machines & Beats

The ELK server is configured to monitor the following machines:

1. Web-1 - 10.1.0.5
2. Web-2 - 10.1.0.6
3. Web-3 - 10.1.0.7

We have installed the following Beats on the above three machines:

1. filebeat-7.4.0-amd64.deb
2. metricbeat-7.4.0-amd64.deb

The filebeat-playbook implements the following tasks (on the Webservers):

- Gets, uncompresses & installs filebeat (filebeat-7.4.0-amd64.deb)
- Enables, sets up & starts filebeat
- Enables filebeat on boot

The metricbeat-playbook implements the following tasks (on the Webservers):

- Gets, uncompressess & installs metricbeat (metricbeat-7.4.0-amd64.deb)
- Enables, sets up & starts metricbeat
- Enables metricbeat on boot

These Beats allow us to collect the following information from each machine:

- Filebeat  - is a lightweight shipper for forwarding and centralizing log data from a server/s. As an agent running on server/s, Filebeat monitors log files or locations (user specified), collecting log events and shipping them to the ELK stack indexing. [FileBeat Web Page](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/FileBeat-Screenshot.png "FileBeat Web Page Screehshot")

- Metricbeat - is a lightweight shipper, installed on a server/s to periodically collect metrics about the/that server/s operating system and services. Metricbeat ships the specified collected metrics and statistics to an Elk server for analyses. [MetricBeat Web Page](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/MetricBeat-Screenshot.png "MetricBeat Web Page Screanshot")

### Using the Playbook

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:

1. Open file [ansible.cfg](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/ansible.cfg 'editable ansible.cfg file') and edit Line 107 'remote_user_name = (enter your choice)' to select the ansible user login name that ansible will use to login to (each sever) and configure/build. ie

          # (/usr/bin/ansible will use current user as default)
          remote_user = enter your choice

2. Open file [hosts](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/hosts 'editable ansible hosts file') and edit from Line 18 adding '[a server description]' followed by the name private IP address and include 'ansible_python_interpreter=/usr/bin/python3' next to each private IP address. ie

         [webservers]
         10.1.0.5 ansible_python_interpreter=/usr/bin/python3
         10.1.0.6 ansible_python_interpreter=/usr/bin/python3
         10.1.0.7 ansible_python_interpreter=/usr/bin/python3
         
         [elk]
         10.2.0.4 ansible_python_interpreter=/usr/bin/python3

    _Note:_ The playbook file has a line item (hosts: ........) identifying which server/s the Jumpbox will access and perform the playbook tasks on. ie

         name: installing and launching filebeat
         hosts: webservers
         become: true

3. Copy the filebeat-config.yml file to the '/etc/ansible/roles/files/' directory. [filebeat-config.yml location]( [https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/filebeat-config.yml_location_Screenshot.png "filebeat-config.yml location Screenshot")

4. Open file _/etc/ansible/roles/files/filebeat-config.yml_ and

    1. edit line 1105 with the ELK private IP address and the TCP port elastic will use.
    eg

           # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
           hosts: ["10.2.0.4:9200"]

    2. edit line 1805 with the ELK private IP address and the TCP port kibana will use.
    eg

           # This requires a Kibana endpoint configuration.
           setup.kibana:
             host: "10.2.0.4:5601" # TODO: Change this to the IP address of your ELK server

5. The playbook file is [filebeat-playbook.yml](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/ansible/roles/filebeat-playbook.yml "filebeat-playbook.yml file") and it is located in the folder '/etc/ansible' of your JumpBox Docker container.
This playbook runs from your JumpBox container with ansible on it, performing the tasks on the sever/s you specified in the hosts file ;
    1. downloads the filebeat software from a web repository to each webserver,
    2. copies the _filebeat-config.yml_ file from the JumpBox _/etc/ansible/roles/files to each webserver,
    3. builds and starts the filebeat container on each webserver.

6. Run the playbook, navigate to the ELK server and check that the installation worked as expected. [ELK-1 Ansible Screenshot](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/ELK-1_Ansible_Screenshot.png "ELK-1 Ansible Screenshot")

7. To confirm the Elk server is set up and running correctly, surf to the public IP of the ELK webserver 52.146.65.65 using TCP 5601.  i.e. 52.146.9.65:5601. [ELK Website Home Screenshot](https://github.com/Martin6402/Cyber-Security---Projects/blob/main/images/ELK_Website_Home_Screenshot.png "ELK Website Home Screenshot")

Below is a list of the specific commands, you will need to run to download the playbook, update the files, etc._

| Device                             | Command                                       | Description                                                                                                               |
|------------------------------------|-----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| Vagrant, jumpbox/container/ansible | ssh-keygen                                    | Required to set various public keys for SSH access and running of ansible playlists                                       |
| Jumpbox/container/ansible          | sudo cat .ssh/id_rsa.pub                      | Required to view, cut and paste various Public Keys                                                                       |
| Vagrant - Remote Device            | ssh username@40.115.65.102                    | ssh to jump-box from home                                                                                                 |
| Jumpbox                            | sudo docker container list -a                 | lists all docker container                                                                                                |
| Jumpbox                            | sudo docker start pensive_babbage             | start docker container pensive_babbage                                                                                    |
| Jumpbox                            | sudo docker ps                                | list docker containers that are running                                                                                   |
| Jumpbox                            | sudo docker exec -i -t pensive_babbage bash   | attaches you to the pensive_babbage container                                                                             |
| Jumpbox                            | cd /etc/ansible                               | Change directory to the Ansible directory                                                                                 |
| Jumpbox                            | ls -laA                                       | List all file in directory (including hidden)                                                                             |
| Jumpbox                            | nano hosts                                    | add webservers and elf machines                                                                                           |
| Jumpbox                            | nano ansible.cfg                              | add user name to remote user                                                                                              |
| Jumpbox                            | nano pentest.yml                              | write YAMl file to install docker and dvwa on webservers                                                                  |
| Jumpbox                            | ansible-playbook /etc/ansible/pentest.yml     | run playbook to install docker and dvwa container on webservers                                                           |
| Jumpbox                            | sudo lsof /var/lib/dpkg/lock-frontend         | unlocking a locked file                                                                                                   |
| Jumpbox                            | ssh username@10.1.0.5                         | ssh to Web-1 (and test Public key)                                                                                        |
| usename@Web-1                      | sudo docker ps                                | check to make sure the container is installed and running                                                                 |
| usename@Web-1                      | exit                                          | exit out of Web-1 back to Jump-box                                                                                        |
| Jumpbox                            | nano install-elk.yml                          | write YAML file to install docker and ELK stack on ELK VM                                                                 |
| Jumpbox                            | ansible-playbook /etc/ansible/install-elk.yml | run playbook to install docker and ELK stack on ELK VM                                                                    |
| Jumpbox                            | ssh username@10.2.0.4                         | ssh to ELK VM (and test Public key)                                                                                       |
| usename@ELK-1                      | sudo docker ps                                | check that the ELK container is installed and running                                                                     |
| usename@ELK-1                      | sudo docker container list -a                 | lists all docker container                                                                                                |
| usename@ELK-1                      | exit                                          | exit ELK VM back to Jump-Box                                                                                              |
| Jumpbox                            | ansible webservers -m ping                    | Ping ansible webservers                                                                                                   |
| Jumpbox                            | ansible all -m ping                           | Ping all ansible servers (webservers & ELK server)                                                                        |
| Jumpbox                            | nano filebeat-config.yml                      | create and edit filebeat config file                                                                                      |
| Jumpbox                            | nano filebeat-playbook.yml                    | write YAML file to install filebeat on webservers                                                                         |
| Jumpbox                            | ansible-playbook filebeat-playbook.yml        | run playbook to install filebeat on webservers                                                                            |
| Jumpbox                            | ssh username@10.2.0.4                         | ssh to ELK VM (and test Public key)                                                                                       |
| usename@Web-2                      | sudo docker exec -i -t dvwa bash              | attaches you to the dvwa container                                                                                        |
| usename@Web-2                      | exit                                          | exit Web-2 VM back to Jump-Box                                                                                            |
| Remote device Web page             | http://52.146.9.65:5601/                      | Open web browser and navigate to logs/ add log data/ system logs click on check data. click on system logs dashboard.     |
| Jumpbox                            | nano metricbeat-config.yml                    | create metricbeat config file and edit it                                                                                 |
| Jumpbox                            | nano metricbeat-playbook.yml                  | write YAML file to install metricbeat on webservers                                                                       |
| Jumpbox                            | ansible-playbook metricbeat-playbook.yml      | run playbook to install metricbeat on webservers                                                                          |
| Remote device Web page             | http://52.146.9.65:5601/                      | Open web browser and navigate to metric data / docker metrics / click on the check data, click on Docker Metric dashboard |
| Various devices                    | ping 10.1.0.4                                  | ICMP various IP Hosts to to test their connectivity to the network                                                                                                      |

---
