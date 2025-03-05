arch_packages_minimal:
	sudo pacman --noconfirm --needed -Sy 7zip base bluez bluez-utils bottom brightnessctl btrfs-progs compsize cpupower curl dos2unix dosfstools exfatprogs fastfetch fd fzf gdu i2c-tools imagemagick inxi libimobiledevice lynx man-db man-pages networkmanager nmap openbsd-netcat openssh pciutils power-profiles-daemon pv ripgrep rsync stow tcpdump tldr tree unzip usbmuxd usbutils vim wget zip zsh

arch_packages_termtools:
	sudo pacman --noconfirm --needed -Sy asciinema asciiquarium btop catimg cmatrix cowsay figlet htop kmon lolcat nvtop perf sc sl turbostat zps
	yay --noconfirm --needed -Sy cava

arch_packages_dev:
	sudo pacman --noconfirm --needed -Sy base-devel clang cmake git gdb github-cli jq julia lazygit linux-headers nasm neovim npm python-pip python-pynvim python-virtualenv tree-sitter tree-sitter-cli vulkan-headers

arch_packages_audio:
	sudo pacman --noconfirm --needed -Sy mpd playerctl pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse wireplumber

arch_packages_sddm:
	sudo pacman --noconfirm --needed -Sy layer-shell-qt qt5-declarative qt5-virtualkeyboard qt5ct qt6-5compat qt6-svg qt6-virtualkeyboard qt6ct sddm ttf-font-awesome ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono  
	sudo sh scripts/sys_common.sh

arch_packages_guiapps:
	sudo pacman --noconfirm --needed -Sy blueman feh ffmpegthumbnailer firefox gamemode goverlay gvfs gvfs-afc gvfs-dnssd gvfs-mtp gvfs-nfs gvfs-smb helvum kitty kvantum kvantum-qt5 lact mangohud mesa-utils mission-center mpv network-manager-applet openrgb pavucontrol qalculate-qt thunar thunar-shares-plugin thunar-volman tumbler udiskie vlc vulkan-icd-loader vulkan-tools xdg-desktop-portal-gtk xdg-user-dirs xdg-utils

arch_packages_i3:
	sudo pacman --noconfirm --needed -Sy dunst i3-wm i3blocks i3lock i3status lxsession-gtk3 maim rofi-wayland xclip xorg-xrandr xorg-server xorg-xinit
	sudo sh scripts/sys_i3.sh

arch_packages_hyprland:
	sudo pacman --noconfirm --needed -Sy cliphist grim hypridle hyprland hyprland-qt-support hyprlock hyprpaper hyprpicker hyprpolkitagent rofi-wayland satty sddm slurp swaync uwsm waybar wl-clipboard xdg-desktop-portal-hyprland
	yay --noconfirm --needed -Sy wlogout
	sudo sh scripts/sys_hyprland.sh

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
	sh yay_install.sh

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

all_arch: arch_packages_minimal arch_packages_dev yay_install arch_packages_termtools arch_packages_audio arch_packages_sddm arch_packages_i3 arch_packages_hyprland arch_packages_guiapps zsh_install rust_install dotfiles

