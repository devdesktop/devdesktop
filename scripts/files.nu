#!/usr/bin/env nu

use fz.nu
use term.nu
use wm.nu

export def main [file?: path, ...rest] {
  let choice = (
    if $file == null {
      wm win open --above { list | term fz }
    } else {
      $file
    }
  )

  if ($choice | str trim | is-not-empty)  {
    term --class nvim nvim $choice ...$rest
  }
}

def list [--json] {
  fd --type f .
}
