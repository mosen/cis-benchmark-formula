# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cis-benchmark/map.jinja" import cis_benchmark with context %}

{% if grains['os'] == 'CentOS' %}

# CentOS
{% if grains['osmajorrelease']|int == 7 %}
include:
  - cis-benchmark.centos7.enforce
{% endif %}

{% endif %}
