# Configure a Standalone Subordinate CA
class windows_certificate_authority::standalonesubca (
    $catype              = $windows_certificate_authority::catype,
    $keylength           = $windows_certificate_authority::keylength,
    $validityperiod      = $windows_certificate_authority::validityperiod,
    $validityperiodunits = $windows_certificate_authority::validityperiodunits
) {
  exec { 'Deploy Standalone Subordinate CA ADCS_CA':
    command  => "Install-AdcsCertificationAuthority -Force -CAType $catype -KeyLength $keylength -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits",
    provider => powershell,
    unless   => "((Get-CATemplate).Name).Contains('EFS')",
  }
}
