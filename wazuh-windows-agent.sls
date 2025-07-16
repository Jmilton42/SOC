install_wazuh_agent_windows:
  cmd.run:
    - name: Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.12.0-1.msi -OutFile $env:tmp\wazuh-agent.msi; msiexec.exe /i $env:tmp\wazuh-agent.msi /q WAZUH_MANAGER='192.168.2.16'
    - shell: powershell
    - creates: 'C:\Program Files(x86)\ossec-agent\ossec.conf'

start_wazuh_service:
  cmd.run:
    - name: NET START WazuhSvc
    - shell: cmd
    - require:
      - cmd: install_wazuh_agent_windows

enable_wazuh_service:
  cmd.run:
    - name: sc.exe config WazuhSvc start= auto
    - shell: cmd
    - require:
      - cmd: start_wazuh_service
