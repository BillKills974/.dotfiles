arch_packages_minimal:
	sudo pacman --noconfirm --needed -Syu 7zip base bluetui bluez bluez-utils bottom brightnessctl btrfs-progs compsize cpupower curl dos2unix dosfstools exfatprogs fastfetch fd fzf gdu i2c-tools imagemagick inxi libimobiledevice lynx man-db man-pages networkmanager nmap openbsd-netcat openssh pciutils power-profiles-daemon pv ripgrep rsync snapper snap-pac stow tcpdump tldr tree unzip usbmuxd usbutils vim wget zip zsh

arch_packages_dev:
	sudo pacman --noconfirm --needed -Syu base-devel clang cmake git gdb github-cli go jq julia lazygit linux-headers nasm neovim npm python-pip python-pynvim python-virtualenv rustup tree-sitter tree-sitter-cli vulkan-headers webkit2gtk-4.1

arch_packages_termtools:
	sudo pacman --noconfirm --needed -Syu asciinema asciiquarium btop catimg cava cmatrix cowsay figlet htop kmon lolcat nvtop perf sl turbostat zps

arch_packages_audio:
	sudo pacman --noconfirm --needed -Syu flac lib32-flac mpd playerctl pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse speech-dispatcher wireplumber

arch_packages_sddm:
	sudo pacman --noconfirm --needed -Syu gnu-free-fonts layer-shell-qt noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra qt5-wayland qt6-5compat qt6-svg qt6-virtualkeyboard qt6-wayland qt6ct sddm ttf-font-awesome ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family
	sudo sh scripts/sys_common.sh

arch_packages_guiapps:
	sudo pacman --noconfirm --needed -Syu blueman discord feh ffmpegthumbnailer firefox goverlay gvfs gvfs-afc gvfs-dnssd gvfs-mtp gvfs-nfs gvfs-smb helvum kitty kvantum kvantum-qt5 lact mesa-utils mission-center mpv network-manager-applet openrgb pavucontrol qalculate-qt thunar thunar-shares-plugin thunar-volman tumbler udiskie vlc vulkan-icd-loader vulkan-tools xdg-desktop-portal-gtk xdg-user-dirs xdg-utils

arch_packages_i3:
	sudo pacman --noconfirm --needed -Syu dunst i3-wm i3blocks i3lock i3status lxsession-gtk3 maim rofi-wayland xclip xorg-xrandr xorg-server xorg-xinit
	sudo sh scripts/sys_i3.sh

arch_packages_hyprland:
	sudo pacman --noconfirm --needed -Syu cliphist grim hypridle hyprland hyprland-qt-support hyprlock hyprpaper hyprpicker hyprpolkitagent rofi-wayland satty sddm slurp swaync uwsm waybar wl-clipboard xdg-desktop-portal-hyprland
	yay --noconfirm --needed -Syu wlogout
	sudo sh scripts/sys_hyprland.sh

arch_steam:
	sudo pacman --noconfirm --needed -Syu gamemode gstreamer-vaapi gst-libav gst-plugins-bad gst-plugins-good gst-plugins-ugly lib32-gstreamer lib32-gst-plugins-base lib32-gst-plugins-base-libs lib32-gst-plugins-good lib32-libva lib32-gamemode lib32-mangohud libva-utils mangohud steam

arch_nvidia:
	sudo pacman --noconfirm --needed -Syu libvdpau-va-gl lib32-libvdpau lib32-opencl-nvidia lib32-nvidia-utils libva-nvidia-driver nvidia-dkms nvidia-settings nvidia-utils opencl-nvidia vdpauinfo

clear_config:
	rm -Rf $$HOME/.config/backgrounds
	rm -Rf $$HOME/.config/bottom
	rm -Rf $$HOME/.config/btop
	rm -Rf $$HOME/.config/cava
	rm -Rf $$HOME/.config/dunst
	rm -Rf $$HOME/.config/gtk-*
	rm -Rf $$HOME/.config/hypr
	rm -Rf $$HOME/.config/i3
	rm -Rf $$HOME/.config/kitty
	rm -Rf $$HOME/.config/MangoHud
	rm -Rf $$HOME/.config/nvim
	rm -Rf $$HOME/.config/OpenRGB
	rm -Rf $$HOME/.config/qt?ct
	rm -Rf $$HOME/.config/rofi
	rm -Rf $$HOME/.config/swaync
	rm -Rf $$HOME/.config/uwsm
	rm -Rf $$HOME/.config/waybar
	rm -Rf $$HOME/.config/wlogout
	rm -f $$HOME/.config/gamemode.ini
	rm -f $$HOME/.zshrc $$HOME/.zprofile $$HOME/.zshenv $$HOME/.p10k.zsh
	mkdir -p $$HOME/.config/backgrounds
	mkdir -p $$HOME/.config/gtk-3.0
	mkdir -p $$HOME/.config/gtk-4.0
	mkdir -p $$HOME/.config/qt5ct
	mkdir -p $$HOME/.config/qt6ct
	mkdir -p $$HOME/.config/xfce4

	
zsh_install:
	rm -Rf $${ZSH_CUSTOM:-~/.oh-my-zsh}
	chsh -s $$(which zsh)
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

fonts:
	mkdir -p $$HOME/.fonts
	curl -fsSL -X GET https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip -o /tmp/Symbols.zip
	unzip -o -d $$HOME/.fonts/ /tmp/Symbols.zip
	fc-cache -r -f -v

yay_install:
	sh scripts/yay_install.sh

rust_install:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

nvim_clear_local:
	rm -Rf $$HOME/.local/share/nvim
	rm -Rf $$HOME/.local/state/nvim

dotfiles: clear_config
	mkdir -p $$HOME/.local/share/applications
	stow --dir=stow --target=$$HOME --restow $$(echo stow/* | sed -e "s:stow/::g")

delete:
	stow --dir=stow --target=$$HOME --delete $$(echo stow/* | sed -e "s:stow/::g")

all_arch: arch_packages_minimal arch_packages_dev yay_install arch_packages_audio arch_packages_termtools arch_packages_sddm arch_packages_i3 arch_packages_hyprland arch_packages_guiapps zsh_install dotfiles

arch_hyprland_only: arch_packages_minimal arch_packages_dev yay_install arch_packages_audio arch_packages_termtools arch_packages_sddm arch_packages_i3 arch_packages_hyprland arch_packages_guiapps zsh_install dotfiles

arch_i3_only: arch_packages_minimal arch_packages_dev yay_install arch_packages_audio arch_packages_termtools arch_packages_sddm arch_packages_i3 arch_packages_hyprland arch_packages_guiapps zsh_install dotfiles
