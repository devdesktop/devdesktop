{ colors, inputs, pkgs, ... }: let
  work = (builtins.fromJSON (builtins.readFile ../private.json)).work;

  browse = "firefox";
  browseApp = url: "firefox ${url}";

  col = {
    active = "rgba(${builtins.substring 1 7 colors.light2}ff)";
    inactive = "rgba(${builtins.substring 1 7 colors.black}77)";
    shadow = "rgba(${builtins.substring 1 7 colors.black}bb)";
  };

  spacing = 16;

  cellHeight = 38;

  gap = {
    left = spacing * 38;
    right = spacing * 38;
  };

  widget = {
    x = spacing + 2;
    width = gap.left - (spacing * 2) - 4;
  };

  dateWidget = {
    inherit (widget) x width;

    y = spacing;
    height = cellHeight + 4;
  };

  sensorWidget = {
    inherit (widget) x width;

    y = dateWidget.y + dateWidget.height + spacing;
    height = cellHeight + 4;
  };

  desktopWidget = {
    inherit (widget) x width;

    y = sensorWidget.y + sensorWidget.height + spacing;
    height = cellHeight + 4;
  };

  projectWidget = {
    inherit (widget) x width;

    y = desktopWidget.y + desktopWidget.height + spacing;
    height = cellHeight + 4;
  };

  windowListWidget = {
    inherit (widget) x width;

    y = projectWidget.y + projectWidget.height + spacing;
    height = cellHeight * 9;
  };

  discord = browseApp "https://discord.com/channels/@me";
  music = browseApp "https://music.youtube.com";
  slack = browseApp work.slack.url;
  video = browseApp "https://youtube.com";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    settings = {
      "$touchpad_enabled" = true;

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 3, myBezier, popin 90%"
          "windowsOut, 1, 3, default, popin 90%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default, slide"
          "specialWorkspace, 1, 3, myBezier, slidevert"
        ];
      };

      "$c"    = "CONTROL";
      "$cas"  = "CONTROL ALT SHIFT";
      "$s"    = "SUPER";
      "$ss"   = "SUPER SHIFT";
      "$sc"   = "SUPER CONTROL";
      "$scas" = "SUPER CONTROL ALT SHIFT";
      "$scs"  = "SUPER CONTROL SHIFT";

      bind = [
        "$s, slash, exec, ws.nu search --new-window"
        "$s, semicolon, workspace, previous"

        "$s, 0, exec, notifyctl dismiss"

        "$s, c, workspace, name:chat"
        "$s, c, exec, wm run-if-empty ${slack}"
        "$s, c, layoutmsg, preselect d"
        "$s, c, exec, wm run-if-empty ${discord}"

        "$s, d, workspace, name:devapp"
        "$s, d, exec, wm run-if-empty ${browse} http://localhost:3000"

        "$s, e, exec, ws switch code"
        "$s, e, exec, wm run-if-empty ws term nvim"

        "$s, f, exec, ws term ws find file"

        "$s, g, exec, ws switch gitui"
        "$s, g, exec, wm run-if-empty ws term lazygit"

        "$s, h, movefocus, l"
        "$s, j, changegroupactive, f"
        "$s, k, changegroupactive, b"
        "$s, l, movefocus, r"

        "$s, m, workspace, name:meet"
        "$s, m, exec, wm run-if-empty ${browse} https://meet.google.com/landing?authuser=1"

        "$s, n, exec, ${browse}"
        "$s, p, exec, term nvim $HOME/sys/plan.md"
        "$s, s, exec, ws term"

        "$s, r, exec, ws switch services"
        "$s, r, exec, wm run-if-empty term ws services"

        "$s, u, workspace, name:music"
        "$s, u, exec, wm run-if-empty ${music}"

        "$s, v, workspace, name:video"
        "$s, v, exec, wm run-if-empty ${video}"

        "$s, w, workspace, name:web"
        "$s, w, exec, wm run-if-empty ${browse}"

        "$ss, f, togglefloating"
        "$ss, g, togglegroup"
        "$ss, h, movewindoworgroup, l"
        "$ss, j, movewindoworgroup, d"
        "$ss, k, movewindoworgroup, u"
        "$ss, l, movewindoworgroup, r"

        "$sc, g, workspace, name:game"
        "$sc, h, movefocus, l"
        "$sc, j, movefocus, d"
        "$sc, k, movefocus, u"
        "$sc, l, movefocus, r"
        "$sc, s, exec, ws term"

        ("$cas, h, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace -1"
        ])

        ("$cas, j, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace +100"
        ])

        ("$cas, k, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slidevert"
         "hyprctl dispatch workspace -100"
        ])

        ("$cas, l, exec, " + builtins.concatStringsSep " && " [
         "hyprctl keyword animation workspaces,1,3,default,slide"
         "hyprctl dispatch workspace +1"
        ])

        "$cas, a, workspace, 1"
        "$cas, q, killactive"
        "$cas, w, exec, widgetctl toggle"
        "$cas, y, workspace, 2"

        "$scas, e, exec, variety -t"
        "$scas, h, movetoworkspace, -1"
        "$scas, l, movetoworkspace, +1"
        "$scas, q, exit"

        "$scs, f, fakefullscreen"
        "$scs, h, movegroupwindow, b"
        "$scs, j, movewindoworgroup, d"
        "$scs, k, movewindoworgroup, u"
        "$scs, l, movegroupwindow, f"
        "$scs, s, exec, kitty"

        "  , XF86AudioRaiseVolume, exec, mediactl vol up"
        "  , XF86AudioLowerVolume, exec, mediactl vol down"
        "  , XF86AudioMute, exec, mediactl vol mute"
        "$c, XF86AudioMute, exec, mediactl mic mute"
        "  , XF86AudioNext, exec, mediactl track next"
        "  , XF86AudioPrev, exec, mediactl track prev"
        "  , XF86AudioPlay, exec, mediactl track play-pause"

        "  , XF86MonBrightnessUp, exec, mediactl brightness up"
        "  , XF86MonBrightnessDown, exec, mediactl brightness down"
      ];

      bindm = [
        "$s, mouse:272, movewindow"
        # "$s, mouse:273, resizewindow"
      ];

      decoration = {
        rounding = 4;

        blur = {
          enabled = false;
          size = 16;
          passes = 2;
        };

        dim_inactive = true;
        dim_special = 0;

        drop_shadow = true;
        shadow_range = 16;
        shadow_render_power = 2;

        "col.shadow" = col.shadow;
      };

      dwindle = {
        force_split = 1;
        permanent_direction_override = true;
        preserve_split = true;
        pseudotile = true;
      };

      exec-once = [
        "widgetctl start"
      ];

      general = {
        allow_tearing = false;

        border_size = 3;

        "col.active_border" = col.active;
        "col.inactive_border" = col.inactive;
        "col.nogroup_border" = col.inactive;
        "col.nogroup_border_active" = col.active;

        gaps_in = 8;
        gaps_out = "16,16,16,608";

        layout = "dwindle";
      };

      gestures = {
        workspace_swipe = false;
      };

      group = {
        groupbar.enabled = false;

        "col.border_active" = col.active;
        "col.border_inactive" = col.inactive;
      };

      input = {
        kb_layout = "us";
        kb_variant = "intl";

        follow_mouse = 1;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = false;
        };

        sensitivity = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      monitor = [
        "eDP-1, 2880x1800, 0x0, 1"
        "DP-1, 1920x1080, 0x1800, 1"
      ];

      windowrulev2 = [
        "float, class:^widget."
        "noborder, class:^widget\\."
        "nodim, class:^widget\\."
        "nofocus, class:^widget\\."
        "noshadow, class:^widget\\."
        "pin, class:^widget\\."

        "group override deny, class:menu"

        "nodim, class:search-current"

        "group override deny, workspace:name:chat"

        "group set always, class:(.)"
      ] ++ [
        # TODO: nix module?
        "size ${toString dateWidget.width} ${toString dateWidget.height}, class:^widget\\.date"
        "move ${toString dateWidget.x} ${toString dateWidget.y}, class:^widget\\.date"

        "size ${toString sensorWidget.width} ${toString sensorWidget.height}, class:^widget\\.sensors"
        "move ${toString sensorWidget.x} ${toString sensorWidget.y}, class:^widget\\.sensors"

        "size ${toString desktopWidget.width} ${toString desktopWidget.height}, class:^widget\\.desktop"
        "move ${toString desktopWidget.x} ${toString desktopWidget.y}, class:^widget\\.desktop"

        "size ${toString projectWidget.width} ${toString projectWidget.height}, class:^widget\\.project"
        "move ${toString projectWidget.x} ${toString projectWidget.y}, class:^widget\\.project"

        "size ${toString windowListWidget.width} ${toString windowListWidget.height}, class:^widget\\.window-list"
        "move ${toString windowListWidget.x} ${toString windowListWidget.y}, class:^widget\\.window-list"
      ];

      workspace = [
        "1, defaultName:code%%${work.projects.current.root}"
        "2, defaultName:code%%$HOME/sys"
      ];
    };
  };
}
