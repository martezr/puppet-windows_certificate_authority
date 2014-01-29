# Configure an Enterprise Subordinate CA
class windows_certificate_authority::enterprisesubca (
    $catype   = $windows_certificate_authority::catype,
    $parentca = $windows_certificate_authority::parentca
) {
  exec { 'Deploy Enterprise Subordinate ADCS_CA':
    command  => "Install-AdcsCertificationAuthority -Force -CAType $catype -ParentCA $parentca",
    provider => powershell,
    unless   => "((Get-CATemplate).Name).Contains('EFS')"
  }
}
