{ config, pkgs, ... }:

{
	home = {
		homeDirectory = "/home/emssej";
		keyboard.layout = "pl";
		stateVersion = "22.05";
		username = "emssej";
	
		file = {
			".bashrc".source = ./config/bash;
			".profile".source = ./config/profile;
			".somellierrc".source = ./config/sommelier;
		};

		packages = with pkgs; [
			audacity
			gimp
			inkscape
			nano
		];
	};

	programs = {
		home-manager.enable = true;
	};

	xdg.configFile = {
		"audacity/audacity.cfg".source = ./config/audacity;
		"cros-garcon.conf".source = ./config/garcon;
		"inkscape/preferences.xml".source = ./config/inkscape;
		"systemd/user/cros-garcon.service.d/override.conf".source = ./config/garcon-service;
		"weston.ini".source = ./config/weston;
	};
}
