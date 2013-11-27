# Class: windows_certificate_authority
#
# This module is used to install and configure the Active Directory Certificate Services role
#
# Parameters: 
#    $cacommonname         # Specifies the certification authority common name
#    $catype               # Certification Authority Type {EnterpriseRootCA | EnterpriseSubordinateCA | StandaloneRootCA | StandaloneSubordinateCA}
#    $cryptoprovider       # The name of the cryptographic service provider (CSP) or key storage provider (KSP) that is used to generate or store the private key for the CA
#    $hashalgorithm        # Specifies the signature hash algorithm used by the certification authority
#    $keylength            # Private Key Length
#    $parentca             # Parent Certification Authority of a Subordinate CA
#    $validityperiod       # Specifies the validity period of the certification authority (CA) certificate {hours | days | weeks | months | years}
#    $validityperiodunits  # Validity period of the certification authority (CA) certificate
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# 
#  Class: windows_certificate_authority
#
#  Example - Configure an Enterprise Root CA
#
#   class {'windows_certificate_authority':
#    catype        => 'EnterpriseRootCA',     #REQUIRED#
#    cacommonname    => 'Production-CASRV1',  #REQUIRED#
#    cryptoprovider   => 'RSA#Microsoft Software Key Storage Provider',
#    hashalgorithm   => 'SHA1',
#    keylength    => 2048,
#    validityperiod   => 'years',
#    validityperiodunits => 5,
#          }

class windows_certificate_authority (
    $cacommonname        = undef,                                         # Specifies the certification authority common name
    $catype              = 'EnterpriseRootCa',                            # Certification Authority Type {EnterpriseRootCA | EnterpriseSubordinateCA | StandaloneRootCA | StandaloneSubordinateCA}
    $cryptoprovider      = 'RSA#Microsoft Software Key Storage Provider', # The name of the cryptographic service provider (CSP) or key storage provider (KSP) that is used to generate or store the private key for the CA
    $hashalgorithm       = 'SHA1',                                         # Specifies the signature hash algorithm used by the certification authority
    $kernel_ver          = $::kernelmajversion,                           # Windows Kernel Version (Used to determine the platform)
    $keylength           = 2048,                                          # Private Key Length
    $parentca            = undef,                                         # Parent Certification Authority of a Subordinate CA
    $validityperiod      = 'years',                                       # Specifies the validity period of the certification authority (CA) certificate {hours | days | weeks | months | years}
    $validityperiodunits = 3,                                             # Validity period of the certification authority (CA) certificate
    
)
{
  # Check the catype variable for valid entries
  #validate_re($catype,'^(EnterpriseRootCA|EnterpriseSubordinateCA|StandaloneRootCA|StandaloneSubordinateCA)$', 'The CA Type specified does not match a valid CA Type')
  
  # Check the validityperiod variable for valid entries
  #validate_re($validityperiod,'^(hours|days|weeks|months|years)$', 'The validity period specified does not match a valid validity period')
  
  # Install the Certificate Authority Role Service  
    windows_certificate_authority::install {'Install CA':}
  ->
  # Configure the Certificate Authority Role Service  
    windows_certificate_authority::adcscertificationauthority {'Configure CA':}
}
