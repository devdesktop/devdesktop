#!/usr/bin/env nu

use wm.nu

const SEP = "%%"

export def main [] {}

export def "main gitui" [] {
  wm run-or-focus --with-class gitui { term --class gitui --title gitui ws run lazygit }
}

export def "main grep" [] {
  run fz grep
}

export def "main shell" [] {
  wm run-or-focus --with-class shell { ws term --class shell }
}

export def "main switch" [name: string] {
  let root = (wm ws | meta | get --ignore-errors root)

  if $root != null {
    wm ws switch --name $"({ root: $root, name: $name } | into wm-name)"
  }
}

export def --wrapped "main run" [...command] {
  run ...$command
}

export def "main services" [] {
  wm run-or-focus --with-class services {
    term --class services --title services ws run direnv exec . services
  }
}

export def --wrapped "main term" [--class: string, ...command] {
  if ($command | is-empty) {
    term ...(if $class != null { [--class $class] } else { [] }) ws run nu
  } else {
    term ...(if $class != null { [--class $class] } else { [] }) ws run ...$command
  }
}

export def meta [] {
  let ws = $in

  $ws | get name | split column $SEP name root | first
}

export def --wrapped run [...command] {
  let root = (wm ws | meta | get --ignore-errors root)

  if $root != null { cd $root }

  direnv exec . ...$command 
}

def "into wm-name" [] {
  let meta = $in

  $"($meta.name)($SEP)($meta.root)"
}
