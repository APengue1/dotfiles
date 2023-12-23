#!/bin/sh


# Add config alias for this script.
# Sets the git working tree to $HOME
alias config='$(which git) --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'

# Do not show untracked files in $HOME directory.
config config --local status.showUntrackedFiles no


function print_files () {
        for filename in $1; do
                echo $filename;
        done
        echo ""
}

function now () {
        echo $(date +"%Y-%m-%dT%H.%M.%S")
}

function backup_files () {
        for filename in $1; do
                datetime=$(now)
                backup_file=$filename.before_dotfiles_$datetime
                echo "Backing up to $backup_file"
                cp $HOME/$filename $HOME/$backup_file
        done
}
                                                 
function backup_and_restore () {                                             
        echo "Backing up existing files and checking out the new ones..."
        backup_files "$1"                                      
        config restore $1                                                
}                                                                        
                                                               
function config_checkout_patch () {                                      
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

function file_exclusions () {
        echo ":!:README.md :!:install.sh :!:LICENSE"
}
                                                         


# Checkout (copy) the contents of this repository into your $HOME directory.
# For files that do not exist, checkout normally.

non_existing_files=$(config ls-files --deleted -- $(file_exclusions))
if [[ "$non_existing_files" ]]; then
        echo "The following files do not exist on disk. Checkout them out.."
        print_files "$non_existing_files"
        config checkout $non_existing_files --quiet
fi


# For remaining files that exist already, choose what to do with them.

pre_existing_files=$(config ls-files --modified -- $(file_exclusions))
if [[ "$pre_existing_files" ]]; then
        echo "The following files already exist on disk:"
        print_files "$pre_existing_files"

        echo "What would you like to do?"
        echo "1. Backup existing files and checkout the new ones."
        echo "2. git checkout --patch."
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
