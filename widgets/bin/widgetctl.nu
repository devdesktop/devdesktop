#!/usr/bin/env nu

use widgetctl.nu
use wm.nu

def main [] {}

export def "main restart" [...name: string] {
  main stop ...$name
  main start ...$name
}

def "main start" [...name: string] {
  widgetctl list available | widgetctl filter names $name | each { |w| widgetctl start $w }
  null
}

export def "main stop" [...name: string] {
  widgetctl list running | widgetctl filter names $name | each { |w| widgetctl stop $w }
  null
}

export def "main toggle" [...name: string] {
  let running = (widgetctl list running | widgetctl filter names $name)

  if ($running | is-empty) {
    main start ...$name
  } else {
    main stop ...$name
  }
}