arch_packages_common:
	sudo pacman --noconfirm --needed -Sy base base-devel bottom btrfs-progs clang cmake compsize curl docker dos2unix dosfstools exfatprogs fastfetch fd firefox fzf gdb gdu git gvfs julia kitty lazygit libimobiledevice lynx man-db man-pages nasm networkmanager network-manager-applet nmap npm openbsd-netcat openssh pciutils pv python-pip python-virtualenv ripgrep stow tcpdump thunar thunar-volman tldr tree tree-sitter tree-sitter-cli ttf-font-awesome unzip usbmuxd usbutils vim wget zip zsh

arch_packages_i3:
	sudo pacman --noconfirm --needed -Sy dmenu dunst i3-wm i3blocks i3lock i3status lightdm lightdm-gtk-greeter rofi xclip xorg-xrandr xorg-server xorg-xinit

arch_packages: arch_packages_common yay_install arch_packages_i3

clear_config:
	rm -Rf $$HOME/.config/nvim/lua/user
	rm -Rf $$HOME/.config/bottom
	rm -Rf $$HOME/.config/gtk-3.0
	rm -Rf $$HOME/.config/i3
	rm -Rf $$HOME/.config/kitty
	rm -Rf $$HOME/.config/rofi
	rm -Rf $$HOME/.config/Code/User
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
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim $$HOME/.config/nvim
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

all_arch_nvim: arch_packages fonts zsh_install rust_install nvim_clear_local arch_nvim_install dotfiles

all_arch_vscode: arch_packages fonts zsh_install rust_install arch_vscode_install dotfiles

all_arch: arch_packages fonts zsh_install rust_install nvim_clear_local arch_nvim_install arch_vscode_install dotfiles

