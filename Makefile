arch_packages:
	sudo pacman --noconfirm -Sy base base-devel bottom btop btrfs-progs clang cmake compsize dmenu docker dos2unix dosfstools exfatprogs fd firefox fzf gdb gdu git i3 kitty lazygit libimobiledevice lightdm lightdm-gtk-greeter lynx man-db man-pages nasm neofetch neovim nmap npm openbsd-netcat openssh pciutils pv python-pip python-virtualenv ripgrep rofi stow tcpdump tldr tree ttf-font-awesome unzip usbmuxd usbutils vim xclip xdg-utils xorg-xrandr xorg-server xorg-xinit zip zsh curl wget

gits:
	rm -Rf $$HOME/.config/nvim
	rm -Rf $$HOME/.config/btop
	rm -Rf $$HOME/.config/bottom
	rm -Rf $$HOME/.config/gtk-3.0
	rm -Rf $$HOME/.config/i3
	rm -Rf $$HOME/.config/kitty
	rm -Rf $$HOME/.config/rofi
	rm -Rf $${ZSH_CUSTOM:-~/.oh-my-zsh}
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim $$HOME/.config/nvim
	rm -f $$HOME/.zshrc $$HOME/.zprofile $$HOME/.zshenv $$HOME/.p10k.zsh
	mkdir -p $$HOME/.fonts
	curl -fsSL -X GET https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip -o /tmp/Symbols.zip
	unzip -d $$HOME/.fonts/ /tmp/Symbols.zip
	fc-cache -r -f -v

rust_install:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

arch_vscode:
	sh code_install.sh
	mkdir -p $$HOME/.config/Code
	stow --target=$$HOME --restow Code
	cat Code/.config/Code/User/extensions.list | sed -e "s/^/--install-extension /g" | xargs code

dotfiles:
	stow --target=$$HOME --restow */

delete:
	stow --target=$$HOME --delete */

all_no_pkgs : rust_install gits dotfiles

all_arch: arch_packages all_no_pkgs

