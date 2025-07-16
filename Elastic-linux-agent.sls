
install_package:
  cmd.run:
    - name: curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-9.0.2-linux-x86_64.tar.gz 

unzip_package:
  cmd.run:
    - name: tar xzvf elastic-agent-9.0.2-linux-x86_64.tar.gz
    - require:
      - cmd: install_package

install_agent:
  cmd.run:
    - name: elastic-agent-9.0.2-linux-x86_64/elastic-agent install --url=https://192.168.1.16:8220 --enrollment-token=VVQxQlpaY0J1ZnZHZnFBSkZGZUg6Nk9XV0VJSnZ6U29nNjBPaFk1dEZtQQ== --insecure -f
    - require:
      - cmd: unzip_package

