#!/usr/bin/env bash

set -e

copy() {
  mkdir -p "$2"
  cp -nv "$1" "$2"
}

REPO_DIR=$(dirname $(readlink -f "$0"));

should_download_cosmicplayground="Skip"
CPG_DEV_DIR=~/dev/cosmicplayground
if [ -d "$CPG_DEV_DIR" ]; then
  echo "$CPG_DEV_DIR already exists, skipping"
else
  echo "Download the Cosmicplayground repo to $CPG_DEV_DIR? (about 560MB of images/music/code/etc)"
  # TODO clean this up to a 1-liner, couldn't figure out the syntax error for:
  # select should_download_cosmicplayground in "Yes" "No";
  select should_download_cosmicplayground in "Yes" "No"; do
    case "$should_download_cosmicplayground" in
      Yes ) should_download_cosmicplayground=Yes; break;;
      No ) should_download_cosmicplayground=No; break;;
    esac
  done
fi

should_install_postgres="Skip"
if [ -x "$(command -v psql)" ]; then
  echo "Postgres is already installed, skipping"
else
  echo "Download and install Postgres? Cosmicplayground does not use a database, but Postgres is very useful :D"
  # TODO clean this up to a 1-liner, couldn't figure out the syntax error for:
  # select should_install_postgres in "Yes" "No";
  select should_install_postgres in "Yes" "No"; do
    case "$should_install_postgres" in
      Yes ) should_install_postgres=Yes; break;;
      No ) should_install_postgres=No; break;;
    esac
  done
fi

if [ -x "$(command -v fish)" ]; then
  echo "Fish is already installed, skipping"
else
  echo "Install and use Fish shell?"
  # TODO clean this up to a 1-liner, couldn't figure out the syntax error for:
  # select should_install_fish in "Yes" "No";
  select should_install_fish in "Yes" "No"; do
    case "$should_install_fish" in
      Yes ) should_install_fish=Yes; break;;
      No ) should_install_fish=No; break;;
    esac
  done
fi

echo "Configure Git?"
# TODO clean this up to a 1-liner, couldn't figure out the syntax error for:
  # select should_configure_git in "Yes" "No";
select should_configure_git in "Yes" "No"; do
  case "$should_configure_git" in
    Yes ) should_configure_git=Yes; break;;
    No ) should_configure_git=No; break;;
  esac
done

echo "Update and upgrade apt?"
select should_update_apt in "Yes" "No"; do
  case "$should_update_apt" in
    Yes ) sudo apt update; sudo apt upgrade -y; break;;
    No ) break;;
  esac
done

# curl
if [ -x "$(command -v curl)" ]; then
  echo "curl is already installed, skipping"
else
  sudo apt update
  sudo apt install -y curl
fi

# git - https://git-scm.com/
if [ -x "$(command -v git)" ]; then
  echo "Git is already installed, skipping"
else
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt install -y git
fi

# Fish Shell -- https://fishshell.com/
if [ "$should_install_fish" = "Yes" ]; then
  sudo apt install -y fish
  should_change_shell="Yes"
fi

# fnm
FNM_DIR=~/.fnm
FISH_CONFIG_DIR=~/.config/fish/conf.d/
if [ -d "$FNM_DIR" ]; then
  echo "fnm already exists at $FNM_DIR, skipping"
else
  echo "installing fnm"
  sudo apt install -y unzip
  curl -fsSL "https://fnm.vercel.app/install" | bash
  export PATH=~/.fnm:$PATH
  eval "`fnm env`"
  fnm install v18
  fnm use v18
  fnm default v18
  npm i -g npm
  npm i -g @feltcoop/gro
  mkdir -p "$FISH_CONFIG_DIR"
  copy "$REPO_DIR/fish/fnm.fish" "$FISH_CONFIG_DIR"
  copy "$REPO_DIR/fish/settings.fish" "$FISH_CONFIG_DIR"
fi

# create our conventional dev directory
DEV_DIR=~/dev
if [ -d "$DEV_DIR" ]; then
  echo "$DEV_DIR already exists, skipping"
else
  echo "making $DEV_DIR"
  mkdir "$DEV_DIR"
fi


# configure Git
if [ "$should_configure_git" = "Yes" ]; then
  echo "existing Git user: \"$(git config --global user.name)\""
  read -p "enter new Git user.name: " git_user_name
  echo "existing Git email: \"$(git config --global user.email)\""
  read -p "enter new Git user.email: " git_user_email
  git config --global user.name "$git_user_name"
  git config --global user.email "$git_user_email"
  # workflow options
  git config --global pull.rebase true # avoids tangling with merge commits
  git config --global push.default simple # avoids polluting remote with local branches
  # some other nice options
  git config --global color.ui auto
  git config --global core.pager 'less -x1,5'
  git config --global init.defaultBranch main
  echo "successfully configured Git"
elif [ "$should_configure_git" = "No" ]; then
  echo "chose not to configure Git, skipping"
fi

# download Cosmicplayground
if [ "$should_download_cosmicplayground" = "Yes" ]; then
  git clone https://github.com/cosmicplayground/cosmicplayground "$CPG_DEV_DIR"
  cd "$CPG_DEV_DIR"
  npm i
  if [ -x "$(command -v code)" ]; then
    $(which code) "$CPG_DEV_DIR"
  fi
elif [ "$should_download_cosmicplayground" = "No" ]; then
  echo "skipping cosmicplayground repo download"
else
  echo "cosmicplayground repo already exists, skipping"
fi

# VSCode configs -- https://code.visualstudio.com
REPO_VSCODE_DIR="$REPO_DIR"/vscode
VSCODE_USER_DIR=~/.config/Code/User
copy "$REPO_VSCODE_DIR"/settings.json "$VSCODE_USER_DIR"/
copy "$REPO_VSCODE_DIR"/keybindings.json "$VSCODE_USER_DIR"/
copy "$REPO_VSCODE_DIR"/snips.code-snippets "$VSCODE_USER_DIR"/snippets/

# PostgreSQL -- https://www.postgresql.org
# https://www.postgresql.org/download/linux/ubuntu/
if [ "$should_install_postgres" = "Yes" ]; then
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  curl -L https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt update
  sudo apt -y install postgresql
  mkdir -p "$FISH_CONFIG_DIR"
  copy "$REPO_DIR/fish/postgres.fish" "$FISH_CONFIG_DIR"
elif [ "$should_install_postgres" = "No" ]; then
  echo "skipping Postgres installation"
else
  echo "Postgres is already installed, skipping"
fi

echo "~~~~full setup complete"
echo "to finish setup, see the checklist at https://github.com/cosmicplayground/setup"
# TODO The above lines should go at the end of this script file,
# but how to install oh-my-fish without getting stuck in the fish shell?
# Forward an exit call somehow?

if [ "$should_change_shell" = "Yes" ]; then
  chsh -s $(which fish)

  # Oh My Fish -- https://github.com/oh-my-fish/oh-my-fish
  # This goes last because it changes to fish and ends the script, dunno how to fix.
  OMF_DIR=~/.config/omf
  if [ -d "$OMF_DIR" ]; then
    echo "Oh My Fish already exists at $OMF_DIR, skipping"
  else
    curl "https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install" | fish
  fi

  # TODO install theme/plugins?
fi
