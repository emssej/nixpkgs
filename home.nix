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
		"cros-garcon.conf".source = ./config/garcon;
		"systemd/user/cros-garcon.service.d/override.conf".source = ./config/garcon-service;
		"weston.ini".source = ./config/weston;
	};
}
