=====================
cis-benchmark-formula
=====================

A saltstack formula which enforces some of the guidelines recommended in the CIS benchmark.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``cis-benchmark``
------------

Enforces the CIS Benchmark for the current platform (Currently only CentOS 7 Supported).

You will need to check the services and packages that are recommended for removal,
especially if you intend to use the target host as a dhcp, dns, or openldap server.

-------------------------------
Recommendations not implemented
-------------------------------

Not all recommendations are currently implemented. This section contains a list for my
own reference.

* 1.1 Filesystem Configuration: I don't intend on supporting destructive disk operations.
* 1.2.1: Verifying GPG key


3.6 NTP - Recommend configure via ntp formula for now.
4.3 WiFi
4.6 disabled protocols
5 Logging - Setting up remote logging is entirely up to you.
5.1.* Logging configuration
5.2 Auditing (I'll return to this)
5.3 Logrotate - Recommend using logrotate-formula for the moment.
5.2 Configure SSH - Recommend using openssh-formula to set these options.
6.3 Passwords - TODO

