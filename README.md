# Dotfiles

Configurações pessoais de terminal pra macOS. Setup focado em produtividade com visual bonito.

---

## Stack

| Ferramenta | Função |
|---|---|
| [Ghostty](https://ghostty.org) | Emulador de terminal (GPU-accelerated, nativo do macOS) |
| [eza](https://eza.rocks) | Substituto moderno do `ls` com ícones e git status |
| [JetBrains Mono Nerd Font](https://www.nerdfonts.com) | Fonte com ícones embutidos |
| Zsh | Shell padrão do macOS |
| Tema Darkside | Tema escuro do Ghostty |

---

## Instalação em um Mac novo

Um comando e pronto:

```bash
git clone https://github.com/iagoguilherme/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./install.sh
```

O script `install.sh` faz:

1. Instala Homebrew (se não tiver)
2. Instala Ghostty + JetBrains Mono Nerd Font + eza + git
3. Cria symlinks dos arquivos de config pros lugares certos

Depois é só abrir o Ghostty que tudo já vai estar configurado.

---

## Estrutura do repo

```
dotfiles/
├── README.md          ← este arquivo
├── install.sh         ← script de instalação automática
├── .gitignore
├── ghostty/
│   └── config         ← config do Ghostty (tema, fonte, atalhos)
└── zshrc              ← config do shell zsh (aliases, etc)
```

---

## Como funciona (symlinks)

Os arquivos de config **não são copiados** pro sistema — são lincados (symlinks). Isso significa que quando você editar, por exemplo:

```bash
nano ~/.config/ghostty/config
```

Você está editando o arquivo do **repositório** (`~/dotfiles/ghostty/config`). Aí basta commitar:

```bash
cd ~/dotfiles
git add .
git commit -m "Trocar tema"
git push
```

E a mudança fica salva no GitHub pra sincronizar em outras máquinas.

### Verificar se os symlinks estão certos

```bash
ls -la ~/.config/ghostty/config ~/.zshrc
```

Deve mostrar setinhas `->` apontando pro `~/dotfiles/...`.

---

## Atalhos do Ghostty

| Atalho | Ação |
|---|---|
| `Cmd + Shift + Espaço` | **Quick terminal** (dropdown global, funciona em qualquer app) |
| `Cmd + T` | Nova aba |
| `Cmd + N` | Nova janela |
| `Cmd + D` | Split horizontal |
| `Cmd + Shift + D` | Split vertical |
| `Cmd + Option + ←/→/↑/↓` | Navegar entre splits |
| `Cmd + W` | Fechar split/aba |
| `Cmd + +` / `Cmd + -` | Aumentar/diminuir fonte |
| `Cmd + F` | Buscar no buffer |
| `Cmd + K` | Limpar tela |
| `Cmd + ,` | Abrir config |
| `Cmd + Shift + ,` | Recarregar config (após editar) |

---

## Aliases do shell

Definidos no `zshrc`:

| Alias | Comando real | O que faz |
|---|---|---|
| `ls` | `eza --icons --group-directories-first` | Listagem com ícones, pastas primeiro |
| `ll` | `eza -l --icons --group-directories-first --git` | Detalhada com status do git |
| `la` | `eza -la --icons --group-directories-first --git` | Inclui arquivos ocultos |
| `lt` | `eza --tree --icons --level=2` | Árvore de 2 níveis |
| `lt3` | `eza --tree --icons --level=3` | Árvore de 3 níveis |

### Status do git no `ll`

Quando você roda `ll` dentro de um repositório, aparece uma coluna extra:

- `-N` arquivo novo (não rastreado)
- `-M` modificado
- `--` sem alterações
- `-I` ignorado pelo `.gitignore`

---

## Customizações comuns

### Trocar o tema do Ghostty

Listar todos os temas disponíveis (preview ao vivo com setas):

```bash
ghostty +list-themes
```

Depois editar a config:

```bash
nano ~/.config/ghostty/config
```

E trocar a linha `theme = Darkside`. Recarregar com `Cmd + Shift + ,`.

### Ajustar transparência

No arquivo `~/.config/ghostty/config`, mexer em:

- `background-opacity = 0.88` — entre `0.7` (bem transparente) e `1.0` (opaco)
- `background-blur = 20` — intensidade do desfoque do fundo

### Trocar a fonte

Listar fontes Nerd Font disponíveis no Homebrew:

```bash
brew search nerd-font
```

Instalar uma nova:

```bash
brew install --cask font-nome-da-fonte
```

E trocar no config: `font-family = Nome Exato Da Fonte`.

---

## Salvando mudanças no GitHub

Workflow normal sempre que mexer em alguma config:

```bash
cd ~/dotfiles
git status              # ver o que mudou
git add .               # adicionar mudanças
git commit -m "descrição da mudança"
git push                # subir pro GitHub
```

---

## Sincronizar mudanças em outro Mac

Se você editou o repo em uma máquina e quer puxar as mudanças em outra:

```bash
cd ~/dotfiles
git pull
```

Como os arquivos do sistema são symlinks pro repo, as mudanças já estão ativas. Só recarregar:

- Ghostty: `Cmd + Shift + ,`
- Shell: `source ~/.zshrc`

---

## Troubleshooting

### Quick terminal (`Cmd + Shift + Espaço`) não funciona

Precisa de permissão de Acessibilidade no macOS:

1. Ajustes do Sistema → Privacidade e Segurança → Acessibilidade
2. Ativar o toggle do Ghostty
3. Reiniciar o Ghostty (`Cmd + Q` e abrir de novo)

### Ícones aparecem como quadradinhos no `ls`

A fonte não tem os símbolos. Confirmar que a Nerd Font está ativa:

```bash
grep font-family ~/.config/ghostty/config
```

Deve mostrar `font-family = JetBrainsMono Nerd Font`.

### Mudei a config mas não pegou

Recarregar conforme o caso:

- Mudanças no shell (`zshrc`): `source ~/.zshrc`
- Mudanças no Ghostty: `Cmd + Shift + ,` dentro da janela

### Symlinks quebraram

Recriar manualmente:

```bash
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/zshrc ~/.zshrc
```

---

## Adicionando novos arquivos ao repo

Pra incluir mais configs no futuro (ex: Neovim, tmux, starship):

1. Copiar o arquivo pra dentro do repo:
   ```bash
   cp ~/.config/nvim/init.lua ~/dotfiles/nvim/init.lua
   ```
2. Apagar o original e criar symlink:
   ```bash
   rm ~/.config/nvim/init.lua
   ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
   ```
3. Atualizar o `install.sh` adicionando a nova linha de symlink
4. Commitar e enviar:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Adicionar config do Neovim"
   git push
   ```
