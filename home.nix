{ config, pkgs, ... }:

{
    home = {
	homeDirectory = "/home/emssej";
	keyboard.layout = "pl";
	stateVersion = "22.05";
	username = "emssej";
	
	file = {
	    ".bashrc".source = ./config/bash;
	    ".cache/hm-current-home.nix".source = ./.;
	    ".profile".source = ./config/profile;
	    ".somellierrc".source = ./config/sommelier;
	};

	packages = with pkgs; [
	    audacity
	    gimp
	    inkscape
	];
    };

    programs = {
	home-manager.enable = true;

	git = {
	    enable = true;
	    package = pkgs.gitMinimal;
	    userEmail = "emssej@gmail.com";
	    userName = "Emil Kosz";
	};
    };

    services = {
	emacs = {
	    client.enable = true;
	    defaultEditor = true;
	    enable = true;

	    package = (pkgs.emacs.override {
		withGTK3 = false;
		withCsrc = false;
		withImageMagick = true;
	    });	    
	};
    };

    xdg.configFile = {
	"audacity/audacity.cfg".source = ./config/audacity;
	"cros-garcon.conf".source = ./config/garcon;
	"emacs/init.el".source = ./config/init.el;
	"inkscape/preferences.xml".source = ./config/inkscape;
	"systemd/user/cros-garcon.service.d/override.conf".source = ./config/garcon-service;
	"weston.ini".source = ./config/weston;
    };
}
