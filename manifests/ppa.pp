define apt::ppa($key, $ppa="ppa", $ensure = present) {
  apt::key { $key:
    ensure => $ensure,
  }

  $ppa_name = inline_template("<%=
    if ppa.is_a?(Array)
      ppa.join('-')
    else
      ppa
    end %>")

  apt::sources_list {"${name}-${ppa_name}-${lsbdistcodename}":
    ensure => $ensure,
    content => template("apt/ppa-list.erb"),
  }
}
