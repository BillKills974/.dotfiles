arch_packages:
	sudo pacman --noconfirm --needed -Sy base base-devel bottom btop btrfs-progs clang cmake compsize dmenu docker dos2unix dosfstools exfatprogs fd firefox fzf gdb gdu git i3 julia kitty lazygit libimobiledevice lightdm lightdm-gtk-greeter lynx man-db man-pages nasm neofetch nmap npm openbsd-netcat openssh pciutils pv python-pip python-virtualenv ripgrep rofi stow tcpdump tldr tree tree-sitter tree-sitter-cli ttf-font-awesome unzip usbmuxd usbutils vim xclip xdg-utils xorg-xrandr xorg-server xorg-xinit zip zsh curl wget

clear_config:
	rm -Rf $$HOME/.config/nvim/lua/user
	rm -Rf $$HOME/.config/btop
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


