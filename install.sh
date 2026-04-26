#!/bin/bash
# Setup automático de dotfiles pra macOS
# Uso: ./install.sh

set -e  # para na primeira falha

DOTFILES="$HOME/dotfiles"

# Cores pro output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()   { echo -e "${BLUE}▶${NC}  $1"; }
ok()    { echo -e "${GREEN}✓${NC}  $1"; }
warn()  { echo -e "${YELLOW}⚠${NC}  $1"; }
err()   { echo -e "${RED}✗${NC}  $1"; }

# ─────────────────────────────────────────────────
# 1. Validações iniciais
# ─────────────────────────────────────────────────

if [[ "$(uname)" != "Darwin" ]]; then
    err "Esse script é só pra macOS."
    exit 1
fi

log "Iniciando setup do ambiente..."
echo ""

# ─────────────────────────────────────────────────
# 2. Xcode Command Line Tools (necessário pro Homebrew)
# ─────────────────────────────────────────────────

if ! xcode-select -p &> /dev/null; then
    log "Instalando Xcode Command Line Tools..."
    xcode-select --install
    warn "Aguarde a instalação do Xcode Tools terminar e rode esse script novamente."
    exit 0
else
    ok "Xcode Command Line Tools já instalado."
fi

# ─────────────────────────────────────────────────
# 3. Homebrew
# ─────────────────────────────────────────────────

if ! command -v brew &> /dev/null; then
    log "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Adiciona Homebrew ao PATH (Apple Silicon vs Intel)
    if [[ -d "/opt/homebrew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/Homebrew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    ok "Homebrew instalado."
else
    ok "Homebrew já instalado."
fi

# ─────────────────────────────────────────────────
# 4. Pacotes via Homebrew
# ─────────────────────────────────────────────────

log "Instalando aplicativos (cask)..."
brew install --cask ghostty font-jetbrains-mono-nerd-font 2>/dev/null || true
ok "Aplicativos instalados."

log "Instalando ferramentas de linha de comando..."
brew install eza git 2>/dev/null || true
ok "Ferramentas instaladas."

# ─────────────────────────────────────────────────
# 5. Symlinks
# ─────────────────────────────────────────────────

log "Criando symlinks..."

# Backup de configs existentes
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        warn "Fazendo backup de $target -> $target.bak"
        mv "$target" "$target.bak"
    fi
}

# Ghostty
mkdir -p "$HOME/.config/ghostty"
backup_if_exists "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
ok "Ghostty config lincada."

# Zsh
backup_if_exists "$HOME/.zshrc"
ln -sf "$DOTFILES/zshrc" "$HOME/.zshrc"
ok "zshrc lincado."

# ─────────────────────────────────────────────────
# 6. Permissao de Acessibilidade (para Cmd+Shift+Espaco)
# ─────────────────────────────────────────────────

echo ""
log "Configurando permissao de Acessibilidade..."
warn "O macOS exige clique humano pra ativar essa permissao (protecao contra malware)."
echo ""
echo "  Vou abrir o painel de Acessibilidade pra voce."
echo "  La, basta:"
echo "    1. Procurar 'Ghostty' na lista (ou clicar no '+' e adicionar)"
echo "    2. Ativar o toggle"
echo ""
read -p "  Pressione ENTER pra abrir o painel (ou Ctrl+C pra pular)..."

# Abre o painel de Acessibilidade direto
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"

# ─────────────────────────────────────────────────
# 7. Resumo final
# ─────────────────────────────────────────────────

echo ""
echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}  Setup completo! 🎉${NC}"
echo -e "${GREEN}=============================================${NC}"
echo ""
echo "Proximos passos:"
echo ""
echo "  1. Abrir o Ghostty (Spotlight -> 'Ghostty' ou: open -a Ghostty)"
echo ""
echo "  2. Se ainda nao ativou no painel que abri, ative agora:"
echo "     Privacidade e Seguranca -> Acessibilidade -> ativar Ghostty"
echo ""
echo "  3. Reiniciar o Ghostty (Cmd + Q e abrir de novo) pra permissao pegar"
echo ""
echo "  4. Testar o atalho global Cmd + Shift + Espaco em qualquer app"
echo ""
echo "  5. Backups das configs antigas (se existirem) ficaram com sufixo .bak"
echo "     Confira que tudo funciona e apague depois com:"
echo "     rm ~/.config/ghostty/config.bak ~/.zshrc.bak"
echo ""
