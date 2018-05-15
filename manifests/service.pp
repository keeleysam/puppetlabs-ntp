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


    # on macOS, use systemsetup to ensure that ntp will actually remain enabled.
    # this is required on 10.13+ due to the switch to timed, but also works on earlier releases.
    if $::osfamily == 'Darwin' {
      exec {'/usr/sbin/systemsetup -setusingnetworktime on':
        subscribe   => Service['ntp'],
        refreshonly => true
      }
    }
  }
}
