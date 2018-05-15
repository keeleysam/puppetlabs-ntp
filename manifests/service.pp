#
class ntp::service inherits ntp {

  if ! ($ntp::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $ntp::service_manage == true {
    service { 'ntp':
      ensure     => $ntp::service_ensure,
      enable     => $ntp::service_enable,
      name       => $ntp::service_name,
      provider   => $ntp::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }

    if $ntp::service_ensure == 'running' and $osfamily == 'Darwin' {
      if $facts['ntp_info']['network_time'] == false {
        exec {'/usr/sbin/systemsetup -setusingnetworktime on': }
      }
    }
  }

}
