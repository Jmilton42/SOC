download_wazuh_script:
  file.managed:
    - name: /tmp/wazuh-install.sh
    - source: https://packages.wazuh.com/4.12/wazuh-install.sh
    - mode: '0755'
    - skip_verify: True

run_wazuh_installer:
  cmd.run:
    - name: bash /tmp/wazuh-install.sh -a
    - cwd: /tmp
    - creates: /var/ossec/etc/ossec.conf
    - require:
      - file: download_wazuh_script
    - timeout: 600

