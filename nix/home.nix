{ config, pkgs, ... }: {
  imports = [
    ./gnome.nix
    ./kitty.nix
    ./nvim.nix
  ];

  home.file."${config.xdg.dataHome}/fonts".source = ../fonts;

  home.packages = with pkgs; [
    discord
    fd
    grc
    ripgrep
    slack
    wl-clipboard
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.stateVersion = "23.11";

  programs.bash.enable = true;

  programs.btop.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set --global hydro_multiline true

      fish_vi_key_bindings
    '';

    plugins = with pkgs.fishPlugins; [
      { name = "done" ; src = done.src; }
      { name = "fzf-fish" ; src = fzf-fish.src; }
      { name = "grc" ; src = grc.src; }
      { name = "hydro" ; src = hydro.src; }
    ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;

    delta = {
      enable = true;

      options = {
        hyperlinks = true;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
        true-color = "always";
      };
    };

    extraConfig = {
      diff = {
        colorMoved = true;
      };

      init = {
        defaultBranch = "trunk";
      };

      merge = {
        conflictstyle = "diff3";
      };
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs.lazygit = {
    enable = true;

    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };

      gui.sidePanelWidth = 0.20;
    };
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;

    settings = {
      icons.separator = "  ";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
  };
}
