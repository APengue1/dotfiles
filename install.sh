#!/bin/sh


# Run all commands relative to the $HOME directory
cd $HOME

# Add config alias for this script.
# Sets the git working tree to $HOME
alias config='$(which git) --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'

# Do not show untracked files in $HOME directory.
config config --local status.showUntrackedFiles no

# Clone required repositories if they do not exist
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Cloning ohmyzsh.git into $HOME/.oh-my-zsh"
	git clone --quiet https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
	echo "Cloning powerlevel10k.git into $HOME/.oh-my-zsh/custom/themes/powerlevel10k"
	git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	echo "Cloning zsh-autosuggestions.git into $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
	git clone --quiet https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
	echo "Cloning zsh-syntax-highlighting.git into $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
	git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

echo "All required repositories exist."
echo ""


print_files () {
        for filename in $1; do
                echo $filename;
        done
        echo ""
}

now () {
        echo $(date +"%Y-%m-%dT%H.%M.%S")
}

backup_files () {
        for filename in $1; do
                datetime=$(now)
                backup_file=$filename.before_dotfiles_$datetime
                echo "Backing up to $backup_file"
                cp $HOME/$filename $HOME/$backup_file
        done
}
                                                 
backup_and_restore () {                                             
        echo "Backing up existing files and checking out the new ones..."
        backup_files "$1"                                      
        config restore $1                                                
}                                                                        
                                                               
config_checkout_patch () {                                      
        read -p "Backup existing files first (y/n)? " do_backup
        case $do_backup in                                               
                y|Y )                                          
                        echo "Backing up existing files..."              
                        backup_files "$1"                      
                ;;                                                       
                n|N )                                          
                        echo "Skipping backing up existing files."
                ;;                                             
                * )                                                      
                        echo "Invalid option. Exiting..."      
                        exit 1;                                   
                ;;                                             
        esac                                                             
                                                         
        echo ""                                                   
        config checkout --patch $1                             
}                                                                        

file_exclusions () {
        echo ":!:README.md :!:install.sh :!:LICENSE"
}
                                                         


# Checkout (copy) the contents of this repository into your $HOME directory.
# For files that do not exist, checkout normally.

non_existing_files=$(config ls-files --deleted -- $(file_exclusions))
if [ "$non_existing_files" ]; then
        echo "The following files do not exist on disk. Checkout them out.."
        print_files "$non_existing_files"
        config checkout $non_existing_files --quiet
fi


# For remaining files that exist already, choose what to do with them.

pre_existing_files=$(config ls-files --modified -- $(file_exclusions))
if [ "$pre_existing_files" ]; then
        echo "The following files already exist on disk:"
        print_files "$pre_existing_files"

        echo "What would you like to do?"
        echo "1. Backup existing files and 'git restore' the new ones."
        echo "2. Checkout each hunk individually with 'git checkout --patch'."
        echo "3. Do nothing."
        echo ""

        read choice
        case $choice in
                "1")
                        backup_and_restore "$pre_existing_files"
                        ;;
                "2")
                        config_checkout_patch "$pre_existing_files"
                        ;;
                "3")
			echo "Doing nothing... Exiting."
                        ;;
                *)
                        echo "Invalid option... Exiting."
                        exit 1;
                        ;;
        esac
fi
