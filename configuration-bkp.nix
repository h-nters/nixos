{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
	networking.hostName = "nixos";
  networking.networkmanager.enable = true;
	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.printing.enable = true; # cups
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.johns = {
    isNormalUser = true;
    description = "John Sanchez";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      firefox
    ];
  };

  nixpkgs.config.allowUnfree = true;

	programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		gamescopeSession.enable = true;
	};

  # ENABLE NVIDIA DRIVERS STABLE
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.
	hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

  environment.systemPackages = with pkgs; [ 
	vim 
	git 
	wget 
	curl 
	thunderbird
	firefox
	gnome.gnome-terminal 
	mpv-unwrapped 
	qbittorrent 
	virt-manager 
	qemu 
	vscode-fhs 
	python3 
	obs-studio 
	discord
	betterdiscordctl
	steam 
	gamescope 
	protonup-qt 
	mangohud 
	libvirt
	qemu_kvm
	OVMF		
	file
	autoconf
	automake
	binutils
	bison
	debugedit
	fakeroot
	findutils
	flex
	gawk	
	gcc
	gettext
	groff
	gzip	
	libtool
	m4
	patch
	pkgconf
	texinfo
	which
	xorg.libX11
	xorg.libXft
	xorg.libXinerama
	freetype
  ];

	# do not touch this
  system.stateVersion = "23.11";
	# virtualization
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;

}
