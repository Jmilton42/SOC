ensure_agent_dir:
  file.directory:
    - name: C:\Elastic\Agent
    - makedirs: True

install_package:
  cmd.run:
    - name: Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-9.0.2-windows-x86_64.zip -OutFile elastic-agent-9.0.2-windows-x86_64.zip 
    - cwd: C:\Elastic\Agent
    - shell: powershell
    - require:
      - file: ensure_agent_dir

unzip_package:
  cmd.run:
    - name: Expand-Archive C:\Elastic\Agent\elastic-agent-9.0.2-windows-x86_64.zip -DestinationPath .
    - cwd: C:\Elastic\Agent
    - shell: Powershell
    - require:
      - cmd: install_package

install_agent:
  cmd.run:
    - name: C:\Elastic\Agent\elastic-agent-9.0.2-windows-x86_64\elastic-agent.exe install --url=https://192.168.1.16:8220 --enrollment-token=VVQxQlpaY0J1ZnZHZnFBSkZGZUg6Nk9XV0VJSnZ6U29nNjBPaFk1dEZtQQ== --insecure -f
    - cwd: C:\Elastic\Agent\elastic-agent-9.0.2-windows-x86_64
    - shell: powershell
    - unless: reg query "HKLM\Software\Elastic\Agent"
    - require:
      - cmd: unzip_package
