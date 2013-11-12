class windows_certificate_authority::standalonesubca (
  $kernel_ver      = $windows_certificate_authority::kernel_ver,
  $catype              = $windows_certificate_authority::catype, #
  $keylength           = $windows_certificate_authority::keylength, #
  $validityperiod      = $windows_certificate_authority::validityperiod, #
  $validityperiodunits = $windows_certificate_authority::validityperiodunits, #
)
{
   # Deploy Server 2012 Active Directory Certificate Services Cerficate Authority
   exec {'Deploy Standalone Subordinate CA ADCS_CA':
      command   => ' Install-AdcsCertificationAuthority -Force -CAType $catype -KeyLength $keylength -ValidityPeriod $validityperiod -ValidityPeriodUnits $validityperiodunits ',
      provider  => powershell,
      unless    => "((Get-CATemplate).Name).Contains('EFS')",
       }
       
       }