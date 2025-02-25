arch_packages_minimal:
	sudo pacman --noconfirm --needed -Sy base base-devel bottom btrfs-progs clang cmake compsize curl dos2unix dosfstools exfatprogs fastfetch fd fzf gdb gdu git github-cli go gvfs imagemagick inxi jq julia lazygit libimobiledevice lynx man-db man-pages nasm networkmanager nmap npm openbsd-netcat openssh pciutils pv python-pip python-virtualenv ripgrep rsync stow tcpdump tldr tree tree-sitter tree-sitter-cli ttf-font-awesome ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono vulkan-headers vulkan-icd-loader unzip usbmuxd usbutils vim wget zip zsh

arch_packages_audio:
	sudo pacman --noconfirm --needed -Sy cava mpd pavucontrol playerctl

arch_packages_bt:
	sudo pacman --noconfirm --needed -Sy bluez bluez-utils
	
arch_packages_guiapps:
	sudo pacman --noconfirm --needed -Sy blueman dunst ffmpegthumbnailer firefox kitty kvantum mpv network-manager-applet playerctl qt5ct qt6ct qt6-svg thunar thunar-volman tumbler udiskie xdg-user-dirs xdg-utils

arch_packages_i3:
	sudo pacman --noconfirm --needed -Sy i3-wm i3blocks i3lock i3status lightdm lightdm-gtk-greeter lxsession-gtk3 rofi xclip xdg-desktop-portal-gtk xorg-xrandr xorg-server xorg-xinit

arch_packages_hypr:
	sudo pacman --noconfirm --needed -Sy cliphist grim hypridle hyprland hyprland-qt-support hyprlock hyprpaper hyprpicker hyprpolkitagent rofi-wayland satty sddm slurp swww waybar wl-clipboard xdg-desktop-portal-hyprland

arch_packages: arch_packages_minimal arch_packages_i3

clear_config:
	rm -Rf $$HOME/.config/nvim/lua/user
	rm -Rf $$HOME/.config/bottom
	rm -Rf $$HOME/.config/dunst
	rm -Rf $$HOME/.config/gtk-3.0
	rm -Rf $$HOME/.config/i3
	rm -Rf $$HOME/.config/kitty
	rm -Rf $$HOME/.config/rofi
	rm -Rf $$HOME/.config/Code/User
	rm -Rf $$HOME/.config/hypr
	rm -Rf $$HOME/.config/waybar
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

arch_nvim_install:
	sudo pacman --noconfirm --needed -Sy neovim python-pynvim
	rm -Rf $$HOME/.config/nvim
	stow --target=$$HOME --restow nvim

nvim_clear_local:
	rm -Rf $$HOME/.local/share/nvim
	rm -Rf $$HOME/.local/state/nvim

arch_vscode_install:
	sh code_install.sh
	mkdir -p $$HOME/.config/Code/User
	stow --target=$$HOME --restow Code
	cat Code/.config/Code/User/extensions.list | sed -e "s/^/--install-extension /g" | xargs code

dotfiles: clear_config
	mkdir -p $$HOME/.local/share/applications
	mkdir -p $$HOME/.config/Code/User
	stow --target=$$HOME --restow */

delete:
	stow --target=$$HOME --delete */

all_arch_nvim: arch_packages zsh_install rust_install nvim_clear_local arch_nvim_install dotfiles

all_arch_vscode: arch_packages yay_install zsh_install rust_install arch_vscode_install dotfiles

all_arch: arch_packages yay_install zsh_install rust_install nvim_clear_local arch_nvim_install arch_vscode_install dotfiles

