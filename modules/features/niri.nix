{ self, inputs, ... }: {

     flake.nixosModules.niri = { pkgs, lib, ... }: {
        programs.niri = {
	  enable = true;
	  package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
	  };
	};

	perSystem = { pkgs, lib, self', ... }: {

	  packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
               inherit pkgs;
            settings = {
              spawn-at-startup = [
                (lib.getExe self'.packages.myNoctalia)
              ];

              xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

              input.keyboard.xkb.layout = "br";

              layout.gaps = 5;

              binds = {
		"Mod+Shift+E".quit = _: {};
  		"Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
                "Mod+Q".close-window = _: {};
                "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
                "Mod+Left".focus-column-left = _: {};
                "Mod+Right".focus-column-right = _: {};
                "Mod+Up".focus-window-up = _: {};
                "Mod+Down".focus-window-down = _: {};
                "Mod+Shift+H".move-column-left = _: {};
                "Mod+Shift+L".move-column-right = _: {};
                "Mod+Shift+K".move-window-up = _: {};
                "Mod+Shift+J".move-window-down = _: {};
		"Mod+Shift+Slash".show-hotkey-overlay = _: {};
		"Mod+F".fullscreen-window = _: {};

                "Mod+Page_Up".focus-workspace-up = _: {};
		"Mod+Page_Down".focus-workspace-down = _: {};
		"Mod+Shift+Page_Up".move-window-to-workspace-up = _: {};
		"Mod+Shift+Page_Down".move-window-to-workspace-down = _: {};

		"XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
                "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
                "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

		"Mod+Ctrl+H".set-column-width = "-5%";
                "Mod+Ctrl+L".set-column-width = "+5%";
                "Mod+Ctrl+J".set-window-height = "-5%";
                "Mod+Ctrl+K".set-window-height = "+5%";
 
               "Mod+WheelScrollDown".focus-column-left = _: {};
               "Mod+WheelScrollUp".focus-column-right = _: {};
               "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: {};
               "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: {};

	        };
            };
          };
	};
      }
