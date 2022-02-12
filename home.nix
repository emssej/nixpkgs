{ config, pkgs, ... }:

{
	home = {
		homeDirectory = "/home/emssej";
		keyboard.layout = "pl";
		stateVersion = "22.05";
		username = "emssej";
	
		file = {
			".sommelierrc".text = ''
# https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/
'';
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

		bash = {
			enable = true;
			historyFile = null;
			historyFileSize = 0;
			historySize = 10000;
			
			bashrcExtra = ''
unset HISTFILE

if [ -z "''${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=''$(cat /etc/debian_chroot)
fi

case "''$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
	PS1="''${debian_chroot:+(''$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\''$ "
else
	PS1="''${debian_chroot:+(''$debian_chroot)}\u@\h:\w\''$ "
fi

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "''$(dircolors -b ~/.dircolors)" || eval "''$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
				
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
'';

			profileExtra = ''
if [ -e /home/emssej/.nix-profile/etc/profile.d/nix.sh ]; then . /home/emssej/.nix-profile/etc/profile.d/nix.sh; fi
'';
		};
	};

	xdg.configFile = {
		"cros-garcon.conf".text = ''
# https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/garcon/README.md

DisableAutomaticCrosPackageUpdates=false
DisableAutomaticSecurityUpdates=false
'';

		"systemd/user/cros-garcon.service.d/override.conf".text = ''
[Service]
Environment="PATH=%h/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games:/usr/sbin:/usr/bin:/usr/games:/sbin:/bin"
Environment="XDG_DATA_DIRS=%h/.nix-profile/share:%h/.local/share:/usr/local/share:/usr/share"
'';

		"weston.ini".text = ''
[core]
modules=xwayland.so
'';
	};
}
