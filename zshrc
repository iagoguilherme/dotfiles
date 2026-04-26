# ==================================================
# 🐍 CONFIGURAÇÕES DE AMBIENTE (CONDA/MAMBA)
# ==================================================

# >>> conda initialize >>>
# Este bloco gerencia o ambiente Conda (Miniforge3)
__conda_setup="$('/Users/iagoguilherme/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/iagoguilherme/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/iagoguilherme/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/iagoguilherme/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# Este bloco inicializa o Mamba para instalações mais rápidas
export MAMBA_EXE='/Users/iagoguilherme/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/iagoguilherme/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"
fi
unset __mamba_setup
# <<< mamba initialize <<<


# ==================================================
# 🚀 ATALHOS PERSONALIZADOS (ALIASES)
# ==================================================

# Atalho para o deploy completo: GitHub + Apps Script Push + Versionamento
# O comando 'cd' garante que o script rode dentro da pasta correta do projeto
alias saggeo-up='cd /Users/iagoguilherme/Scripts/saggeo-ecosystem/src/drive && bash deploy_saggeo.sh'

# Atalho rápido para abrir o projeto no VS Code
alias saggeo-code='code /Users/iagoguilherme/Scripts/saggeo-ecosystem'

# ==================================================
# 🛠️ CONFIGURAÇÕES EXTRAS
# ==================================================

# Melhora o histórico do terminal
export HISTSIZE=10000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
# Aliases do eza (substitui ls)
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first --git"
alias la="eza -la --icons --group-directories-first --git"
alias lt="eza --tree --icons --level=2"

# Aliases do eza (substitui ls)
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first --git"
alias la="eza -la --icons --group-directories-first --git"
alias lt="eza --tree --icons --level=2 --group-directories-first"
alias lt3="eza --tree --icons --level=3 --group-directories-first"
