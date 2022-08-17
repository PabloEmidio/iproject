#!/bin/sh

CURRENT_DIR=$(dirname "$0")

if [ "$1" = "dev" ]; then
   echo -e "You are running using dev script's path\n"

   PROJECT_DIR=$CURRENT_DIR/..
   shift
else
   PROJECT_DIR=$HOME/.iproject
fi

TEMPLATE_DIR=$PROJECT_DIR/templates

USE_TEMPLATE="default"
PROJECT_NAME="new_project"
NEW_PROJECT_SRC_FILES_DIRNAME="src"

create_template()
{
   cp -r $TEMPLATE_DIR/$USE_TEMPLATE $PROJECT_NAME 2> /dev/null

   if [ "$?" -ne 0 ]; then
      echo "Failed in use template $USE_TEMPLATE"
      exit 1
   fi


   if [ $NEW_PROJECT_SRC_FILES_DIRNAME != "src" ]; then
      mv ./$PROJECT_NAME/src ./$PROJECT_NAME/$NEW_PROJECT_SRC_FILES_DIRNAME
   fi
}


print_help()
{
   printf "\033[1mUSAGE\033[m\n"
   printf "iproject [OPTIONS]\n\n"
   printf "\033[1mOPTIONS\033[m\n"
   printf "   ---help, -h\t\t\t\tDisplay this help message\n"
   printf "   init, --init, -i\t\t\tSelect project name\n"
   printf "   template, --template, -t\t\tSelect template to be used\n"
   printf "   source-name, --source-name, -s\tSelect code src dirname\n\n"
}


for arg in "$@"; do
   case $arg in
      init|--init|-i) 
         PROJECT_NAME=$2
         shift
         shift
         ;;
      template|--template|-t)
         USE_TEMPLATE=$2
         shift
         shift
         ;;
      source-name|--source-name|-s)
         NEW_PROJECT_SRC_FILES_DIRNAME=$2
         shift
         shift
         ;;
      --help|-h)
         print_help
         exit
         ;;
      *)
         print_help
         exit 1
         ;;
   esac
done


create_template