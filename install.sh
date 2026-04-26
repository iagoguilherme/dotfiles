#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "🔗 Criando symlinks..."

# Ghostty
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# Zsh
ln -sf "$DOTFILES/zshrc" "$HOME/.zshrc"

echo "✅ Symlinks criados!"
echo ""
echo "📦 Instalando ferramentas via Homebrew..."

# Verifica se Homebrew está instalado
if ! command -v brew &> /dev/null; then
    echo "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Instala tudo de uma vez
brew install --cask ghostty font-jetbrains-mono-nerd-font
brew install eza git

echo ""
echo "🎉 Setup completo! Abra o Ghostty e aproveite."
