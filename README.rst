=====================
cis-benchmark-formula
=====================

A saltstack formula which enforces the guidelines recommended in the CIS benchmark.
NOTE: disk partitioning operations are not included.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``cis-benchmark``
------------

Enforces the CIS Benchmark for the current platform.

You will need to check the services and packages that are recommended for removal,
especially if you intend to use the target host as a dhcp, dns, or openldap server.
