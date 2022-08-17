#!/bin/sh


PROJECT_DIR_NAME=".iproject"

install_project()
{
   # Create project dir
   PROJECT_DIR=$HOME/$PROJECT_DIR_NAME
   mkdir -p $PROJECT_DIR
   mkdir -p $PROJECT_DIR/bin

   # Copy project files to project dir
   CURRENT_DIR=$(dirname "$0")
   chmod +x $CURRENT_DIR/iproject.sh
   cp -R $CURRENT_DIR/iproject/* $PROJECT_DIR/.
   cp $CURRENT_DIR/iproject.sh $PROJECT_DIR/bin/iproject
}



export_bin_dir()
{
   # Export bin dir
   BASH_SHELL_CONFIG_FILE=$HOME/.bashrc
   ZSH_SHELL_CONFIG_FILE=$HOME/.zshrc

   if [ $(grep -c $PROJECT_DIR_NAME/bin $BASH_SHELL_CONFIG_FILE) -eq 0 ]; then
      echo "export PATH=\"\$HOME/$PROJECT_DIR_NAME/bin:\$PATH\"" >> $BASH_SHELL_CONFIG_FILE
   fi
   
   if [ $(grep -c $PROJECT_DIR_NAME/bin $ZSH_SHELL_CONFIG_FILE) -eq 0 ]; then
      echo "export PATH=\"\$HOME/$PROJECT_DIR_NAME/bin:\$PATH\"" >> $ZSH_SHELL_CONFIG_FILE
   fi
   
}


install_project
export_bin_dir