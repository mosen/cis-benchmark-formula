# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cis-benchmark/map.jinja" import cis_benchmark with context %}

# 1.2.2
{% if cis_benchmark.gpgcheck is True %}
/etc/yum.conf:
  file.line:
    - content: 'gpgcheck=1'
    - match: /^gpgcheck=0$/
    - mode: Replace
{% endif %}

# 1.2.3
{% if cis_benchmark.yum_update is True %}
{% endif %}

# 1.3.1
{% if cis_benchmark.install_aide is True %}
aide:
  pkg.installed
  
init_aide:
  cmd.run:
    - name: "/usr/sbin/aide --init -B 'database_out=file:/var/lib/aide/aide.db.gz'"
    - creates: /var/lib/aide/aide.db.gz
    - require:
      - pkg: aide
      
# 1.3.2
/usr/sbin/aide --check:
  cron.present:
    - user: root
    - special: @daily
{% endif %}

# 1.4.1
enforcing:
  selinux.mode
  

# 1.5.1 - 1.5.2
/boot/grub2/grub.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    

# 1.6.2
kernel.randomize_va_space:
  sysctl.present:
    - value: 2
    
{% for pkg in cis_benchmark.remove_pkgs %}
{{ pkg }}:
  pkg.absent
{% endfor %}
  
# 2.1.12
chargen-dgram:
  service.dead:
    - enable: False
    
# 4.1.1
net.ipv4.ip_forward:
  sysctl.present:
    - value: 0
    
# 4.1.2
net.ipv4.conf.all.send_redirects:
  sysctl.present:
    - value: 0
    
net.ipv4.conf.default.send_redirects:
  sysctl.present:
    - value: 0
  
# 4.2.1
net.ipv4.conf.all.accept_source_route:
  sysctl.present:
    - value: 0
    
net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
    
# 4.2.2
net.ipv4.conf.all.accept_redirects:
  sysctl.present:
    - value: 0
    
net.ipv4.conf.default.accept_redirects:
  sysctl.present:
    - value: 0
    
# 4.2.3
net.ipv4.conf.all.secure_redirects:
  sysctl.present:
    - value: 0
 
net.ipv4.conf.default.secure_redirects:
  sysctl.present:
    - value: 0   
    
# 4.2.4
net.ipv4.conf.all.log_martians:
  sysctl.present:
    - value: 1
    
net.ipv4.conf.default.log_martians:
  sysctl.present:
    - value: 1
    
# 4.2.5
net.ipv4.icmp_echo_ignore_broadcasts:
  sysctl.present:
    - value: 1
    
# 4.2.6
net.ipv4.icmp_ignore_bogus_error_responses:
  sysctl.present:
    - value: 1
    

