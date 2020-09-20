DOTFILES_ROOT=$(pwd -P)

install_symlinks () {
  echo "Installing symlinks"

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    ln -sf "$src" "$dst"
  done
}

install_symlinks