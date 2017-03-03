#!/bin/bash
#Initialize
cd ~/cli-conf
git submodule update --remote --init --recursive
git pull
cd ~
source "${HOME}/cli-conf/.boot"


system=$(uname)

if [ "${system}" == "Darwin" ]; then
	#Prepare the computer, install brew etc.
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install htop tmux vim tree wget iperf python3 ssh-copy-id wakeonlan cowsay fortune Caskroom/cask/atom git-extras Caskroom/cask/spotify zsh
elif [ "${system}" == "Linux" ]; then
	if [ -f /etc/debian_version ]; then
    sudo apt-get update
		sudo apt-get install htop tmux tree wget curl iperf python3 wakeonlan cowsay fortune software-properties-common python-software-properties git-extras build-essential zsh -y
		sudo add-apt-repository ppa:webupd8team/atom -y
		sudo apt-get update
		sudo apt-get install atom -y
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
		echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
		sudo apt-get update
		sudo apt-get install spotify-client -y
	elif [ -f /etc/redhat-release ]; then
    echo "RedHat based distros are not supported!"
	fi
fi
#Install atom packages
apm install git-plus git-projects minimap minimap-cursorline minimap-git-diff tree-view-git-status atom-jinja2 platformio-ide

#Remove any already existing file
rm "${HOME}/.ansi-colors"
rm "${HOME}/.bash_profile"
rm "${HOME}/.bashrc"
rm "${HOME}/.zshrc"
rm "${HOME}/.vim"
rm "${HOME}/.vimrc"
rm "${HOME}/.nvim"
rm "${HOME}/.nvimrc"
rm "${HOME}/.config/htoprc"
rm "${HOME}/.gitconfig"
rm "${HOME}/.ssh/config"

#Make a new .config directory for the htoprc to live in
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.ssh"

#Create some softlink to get most stuff setup
ln -s "${CLI_CONF}/.bash_profile" "${HOME}"
ln -s "${CLI_CONF}/.bashrc" "${HOME}"
ln -s "${CLI_CONF}/.zshrc" "${HOME}"
ln -s "${FSMAXB}/.vim" "${HOME}"
ln -s "${FSMAXB}/.vimrc" "${HOME}"
ln -s "${HOME}/.vim" "${HOME}/.nvim"
ln -s "${HOME}/.vimrc" "${HOME}/.nvimrc"
ln -s "${FSMAXB}/htoprc" "${HOME}/.config"

cp "${HOME}/cli-conf/ssh.cfg" "${HOME}/.ssh/config"

#Hack for FSMaxB's .bashrc
ln -s "${FSMAXB}/.ansi-colors" "${HOME}"

#Configure vim as per FSMaxB's definiton
hash vim 2> /dev/null && vim +PlugInstall +qall
hash vim 2> /dev/null && vim +GitGutterEnable +qall

#Configure git
ln -s "${CLI_CONF}/.gitconfig"

#Launch the freshly configured shell
if [[ $BASH == *"bash"* ]]; then
	source "${HOME}/.bash_profile"
elif [[ $ZSH_NAME == *"zsh"*  ]]; then
	source "${HOME}/.zshrc"
else
	echo "ERROR: No suitable shell config found!"
fi

chsh -s /bin/zsh $USER
