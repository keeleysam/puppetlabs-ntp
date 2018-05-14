# ntp_info.rb
Facter.add(:ntp_info) do
    confine kernel: 'Darwin'
    setcode do
        out = {}
        out['network_time'] = false
        using_network_time = Facter::Util::Resolution.exec('/usr/sbin/systemsetup -getusingnetworktime')

        if using_network_time.gsub("Network Time: ","") == 'On'
            out['network_time'] = true
        end

        out['network_time_server'] = Facter::Util::Resolution.exec('/usr/sbin/systemsetup -getnetworktimeserver').gsub("Network Time Server: ", "")

        out
        
    end
  end