download_and_install_agent:
  cmd.run:
    - name: wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.12.0-1_amd64.deb -O /tmp/wazuh-agent.deb && WAZUH_MANAGER='192.168.2.16' WAZUH_AGENT_GROUP='default' dpkg -i /tmp/wazuh-agent.deb
    - create: /var/ossec/etc/ossec.conf

wazuh_agent_service:
  service.running:
    - name: wazuh-agent
    - enable: True
    - require: 
      - cmd: download_and_install_agent
