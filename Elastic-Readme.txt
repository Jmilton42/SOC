###########################################
# Author: Joey Milton                     #
# Date: 6/12/2015                         #
# Purpose: To install ElasticSearch       #
###########################################

Also increase the cores and ram for the manager

If you need to reset the password for the elastic account do the following
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic


1. Use the salt state to install elasticsearch and kibana

The following steps will be by hand

2. Get the elatic token 
   /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token --scope kibana

3. Copy and paste that at localhost:5601 or the manager-ip:5601

4. It will ask you a pin for kibana do the following for that
   /usr/share/kibana/bin/kibnana-verification-code

5. Edit the /etc/logstash/conf.d/logstash-sample.conf to include logstash_system as the username and password you will want to change the password under management/users. Include after password
   ssl-certificate_verification => false

   Restart the logstash: systemctl restart logstash

6. Go to the management table and go to the fleet it will ask for a name and link for it
   name I did hostname like manager-01
   link I did https://192.168.1.16:8220

7. Get the enrollment token by pressing add agent and the version edit the Linux and Windows agent salt state so it can work

8. Run the salt states

9. Config Eastic

10. Add xpack.encryptedSavedObjects.encryptionKey: 'token' in /etc/kibana/kibana.yml
    Too get the token do /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
