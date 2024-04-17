#!/usr/bin/env nu

use wm.nu

def main [] {}

export def "main restart" [...name: string] {
  main stop ...$name
  main start ...$name
}

def "main start" [...name: string] {
  list available | filter names $name | each { |w| start $w }
}

export def "main stop" [...name: string] {
  list running | filter names $name | each { |w| stop $w }
}

export def start [widget] {
  term widget $widget.name
}

export def stop [widget] {
  kill $widget.pid
}

export def "list running" [] {
  wm win ls --all 
  | where class starts-with "widget." 
  | insert name { |w| $w.class | str replace "widget." "" }
}

export def "list available" [] {
  # TODO: stop hardcoding the path here
  glob $"($env.HOME)/sys/scripts/widget-*.nu" 
  | wrap path
  | insert name { |w| $w.path | path basename }
  | str replace --all --regex "(widget-|\\.nu)" "" name
}

def "filter names" [names: list<string>] {
  filter { |w| 
    if ($names | is-empty) { 
      true 
    } else {
      $names | any { |n| $n == $w.name } 
    }
  }
}
