# Install fnm
curl -fsSL https://fnm.vercel.app/install | bash

# Source the correct fnm setup
eval "$(fnm env)"

# Optional: Install a specific version of Node
fnm install 18
fnm use 18

ln -sf ~/.fnm/node-versions/ /usr/local/Cellar/