class windows_certificate_authority::install {
  # Install Active Directory Certificate Services Certification Authority Role
  # windowsfeature { 'ADCS-Cert-Authority -IncludeManagementTools': }
  exec { 'Install ADCS':
    command  => 'Add-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools', # Install the ADCS-Cert-Authority role
    provider => powershell,
    unless   => '(Get-WindowsFeature -name adcs-cert-authority).Installed'        # Check if the ADCS-Cert-Authority role has already been installed
  }
}
