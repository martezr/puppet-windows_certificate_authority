# windows_certificate_authority #

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
    * [What [Modulename] affects](#what-[modulename]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [Modulename]](#beginning-with-[Modulename])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

Windows Active Directory Certificate Authority

##Module Description

This module is used to automate the installation and configuration of the windows active directory certificate services role

##Setup

###What windows_domain_controller affects

The module installs the ADCS-Cert-Authority role along with the management tools and configures the certificate authority role service.

###Setup Requirements
 
Depends on the following modules:

[puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)

[opentable/windows_feature](https://forge.puppetlabs.com/opentable/windows_feature)

[joshcooper/powershell](https://forge.puppetlabs.com/joshcooper/powershell)

##Usage

Class: windows_certificate_authority

Example - Configure an Enterprise Root CA

  class {'windows_certificate_authority':
   catype        => 'EnterpriseRootCA',     #REQUIRED#
   cacommonname    => 'Production-CASRV1',  #REQUIRED#
   cryptoprovider   => 'RSA#Microsoft Software Key Storage Provider',
   hashalgorithm   => 'SHA1',
   keylength		=> 2048,
   validityperiod   => 'years',
   validityperiodunits => 5,
   }

Parameters:
    $cacommonname         # Specifies the certification authority common name
    $catype               # Certification Authority Type {EnterpriseRootCA | EnterpriseSubordinateCA | StandaloneRootCA | StandaloneSubordinateCA}
    $cryptoprovider       # The name of the cryptographic service provider (CSP) or key storage provider (KSP) that is used to generate or store the private key for the CA
    $hashalgorithm        # Specifies the signature hash algorithm used by the certification authority
    $keylength            # Private Key Length
    $parentca             # Parent Certification Authority of a Subordinate CA
    $validityperiod       # Specifies the validity period of the certification authority (CA) certificate {hours | days | weeks | months | years}
    $validityperiodunits  # Validity period of the certification authority (CA) certificate

##Reference

##Limitations

The module only supports configuring an Enterprise Root CA

Supported only on Windows Server Server 2012

##Development

##Release Notes/Contributors/Etc

Contributors:

        Martez Reed <martez.reed@greenreedtech.com>
