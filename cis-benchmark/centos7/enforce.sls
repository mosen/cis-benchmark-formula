# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cis-benchmark/map.jinja" import cis_benchmark with context %}

# Services disabled (from all benchmark sections)
{% for service in cis_benchmark.disable_services %}
{{ service }}:
  service.dead:
    - enable: False
{% endfor %}

# Packages removed (from all benchmark sections)
{% for pkg in cis_benchmark.remove_pkgs %}
{{ pkg }}:
  pkg.removed
{% endfor %}


# Sysctl variables enabled (value = 1)
{% for sysctlv in cis_benchmark.sysctl_enable %}
{{ sysctlv }}:
  sysctl.present:
    - value: 1
{% endfor %}

# Sysctl variables disabled (value = 0)
{% for sysctlv in cis_benchmark.sysctl_disable %}
{{ sysctlv }}:
  sysctl.present:
    - value: 0
{% endfor %}

# Not Included: 1.1 Filesystem Configuration


# 1.2.2
{% if cis_benchmark.gpgcheck %}
/etc/yum.conf:
  file.line:
    - content: 'gpgcheck=1'
    - match: /^gpgcheck=0$/
    - mode: Replace
{% endif %}

# 1.2.3
{% if cis_benchmark.update %}
/usr/bin/yum update:
  cmd.run:
    - unless:
      - /usr/bin/yum check-update
{% endif %}

# 1.3.1
{% if cis_benchmark.aide %}
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
    - special: '@daily'
{% endif %}

# 1.4.1
{% if cis_benchmark.selinux %}
enforcing:
  selinux.mode
{% endif %}
  

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
    
# 4.5.1
{% if cis_benchmark.tcpwrappers %}
tcp_wrappers:
  pkg.installed
  
# Incomplete: need to generate hosts.allow
{% endif %}

# 5.1
{% if cis_benchmark.rsyslog %}
rsyslog_pkg:
  pkg.installed:
    - name: rsyslog
  
rsyslog_service:
  service.running:
    - name: rsyslog
    - enable: True
    - require:
      - pkg: rsyslog
      
# Omitted: 5.1.3, 5.1.4, 5.1.5
{% endif %}

# 6.1.4
/etc/crontab:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    
# 6.1.5
/etc/cron.hourly:
  file.directory:
    - user: root
    - group: root
    - mode: 700
 
# 6.1.6
/etc/cron.daily:
  file.directory:
    - user: root
    - group: root
    - mode: 700

# 6.1.7
/etc/cron.weekly:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    
# 6.1.8
/etc/cron.monthly:
  file.directory:
    - user: root
    - group: root
    - mode: 700

# 6.1.9
/etc/cron.d:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    
# 6.1.10
/etc/at.deny:
  file.absent

/etc/at.allow:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    
# Omitted: 6.1.11


