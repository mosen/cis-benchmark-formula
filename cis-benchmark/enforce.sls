# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cis-benchmark/map.jinja" import cis_benchmark with context %}

{% if salt['grains.item']('os') == 'CentOS' %}

# CentOS
{% if salt['grains.item']('osmajorrelease') == '7' %}
include:
  - cis-benchmark.centos7.enforce
{% endif %}

{% endif %}
