# Configure an Enterprise Root CA
class windows_certificate_authority::enterpriserootca (
  $cacommonname        = $windows_certificate_authority::cacommonname, #
  $catype              = $windows_certificate_authority::catype, #
  $cryptoprovider      = $windows_certificate_authority::cryptoprovider, #
  $hashalgorithm       = $windows_certificate_authority::hashalgorithm, #
  $keylength           = $windows_certificate_authority::keylength, #
  $validityperiod      = $windows_certificate_authority::validityperiod, #
  $validityperiodunits = $windows_certificate_authority::validityperiodunits, #
)
{
   # Deploy Server 2012 Active Directory Certificate Services Enterprise Root CA
   exec {'Deploy Enterprise Root ADCS_CA':
      command   => " Install-AdcsCertificationAuthority -Force -CAType $catype -CACommonName $cacommonname -CryptoProviderName '$cryptoprovider' -KeyLength $keylength -HashAlgorithmName $hashalgorithm -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits ",
      provider  => powershell,
      unless    => "((Get-CATemplate).Name).Contains('EFS')", # Check if CA templates exist to determine if an existing configuration exist
       }
       
       }