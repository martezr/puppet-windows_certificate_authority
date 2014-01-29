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
# Class: windows_certificate_authority
#
# Example - Configure an Enterprise Root CA
#
#   class { 'windows_certificate_authority':
#     catype              => 'EnterpriseRootCA',
#     cacommonname        => 'Production-CASRV1',
#     cryptoprovider      => 'RSA#Microsoft Software Key Storage Provider',
#     hashalgorithm       => 'SHA1',
#     keylength           => 2048,
#     validityperiod      => 'years',
#     validityperiodunits => 5
#   }
#
class windows_certificate_authority (
    $cacommonname        = undef,
    $catype              = 'EnterpriseRootCa',
    $cryptoprovider      = 'RSA#Microsoft Software Key Storage Provider',
    $hashalgorithm       = 'SHA1',
    $kernel_ver          = $::kernelmajversion,
    $keylength           = 2048,
    $parentca            = undef,
    $validityperiod      = 'years',
    $validityperiodunits = 3,
) {
  # Check the catype variable for valid entries
  validate_re($catype,'^(EnterpriseRootCA|EnterpriseSubordinateCA|StandaloneRootCA|StandaloneSubordinateCA)$', 'The CA Type specified does not match a valid CA Type')
  # Check the validityperiod variable for valid entries
  validate_re($validityperiod,'^(hours|days|weeks|months|years)$', 'The validity period specified does not match a valid validity period')

  # Install the Certificate Authority Role Service
  windows_certificate_authority::install {'Install CA':} ->
  # Configure the Certificate Authority Role Service
  windows_certificate_authority::adcscertificationauthority {'Configure CA':}
}
