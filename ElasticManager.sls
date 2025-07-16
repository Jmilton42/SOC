install_GPG:
  cmd.run:
    - name: wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
    - creates: /usr/share/keyrings/elasticsearch-keyring.gpg

install_transport:
  cmd.run:
    - name: apt-get install apt-transport-https

repository_def:
  cmd.run:
    - name: echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list
    - require:
      - cmd: install_GPG

install_elastic:
  cmd.run:
    - name: apt-get update && apt-get install elasticsearch

start_elastic:
  cmd.run:
    - name: systemctl daemon-reload && systemctl enable elasticsearch && systemctl start elasticsearch
    - require:
      - cmd: install_elastic

install_kibana:
  cmd.run:
    - name: apt-get install kibana
    - require:
      - cmd: start_elastic

start_kibana:
  cmd.run:
    - name: systemctl daemon-reload && systemctl enable kibana && systemctl start kibana
    - require:
      - cmd: install_kibana

install_logstash:
  cmd.run:
    - name: apt-get install logstash && systemctl enable logstash
    - require:
      - cmd: start_kibana

setup_logstash:
   cmd.run:
     - name: cp /etc/logstash/logstash-sample.conf /etc/logstash/conf.d/
     - require:
       - cmd: install_logstash
