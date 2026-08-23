#!/usr/bin/env bash
# Install Starship (if missing), MesloLGS Nerd Font, starship.toml, and wire up bash and/or zsh.
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/johnycsf/Starship-Catppuccin-Dotfiles/main/starship.toml"
MARKER="# starship (johnycsf/Starship-Catppuccin-Dotfiles)"
# Non-Mono MesloLGS NF — OS icons render at full size (Mono variants scale them down).
FONT_BASE_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"
FONT_FILES=(
  "MesloLGS NF Regular.ttf"
  "MesloLGS NF Bold.ttf"
  "MesloLGS NF Italic.ttf"
  "MesloLGS NF Bold Italic.ttf"
)

die() { echo "error: $*" >&2; exit 1; }

ensure_starship() {
  local bin_dir="${HOME}/.local/bin"
  mkdir -p "$bin_dir"
  export PATH="${bin_dir}:/usr/local/bin:${PATH}"

  if command -v starship >/dev/null 2>&1; then
    echo "Starship already installed: $(command -v starship) ($(starship --version 2>/dev/null | head -1))"
    return 0
  fi

  command -v curl >/dev/null 2>&1 || die "curl is required to install starship"

  echo "Starship not found; installing to ${bin_dir} via https://starship.rs/install.sh ..."
  # -y skips confirmation; -b installs to a user-writable dir (no sudo)
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$bin_dir"

  if ! command -v starship >/dev/null 2>&1; then
    die "starship install finished but binary not found on PATH; try opening a new terminal and re-running"
  fi
  echo "Installed starship: $(command -v starship) ($(starship --version 2>/dev/null | head -1))"
}

# Download MesloLGS Nerd Font into a user font directory (Linux / macOS / WSL).
install_nerd_font() {
  command -v curl >/dev/null 2>&1 || die "curl is required to install fonts"

  local font_dir
  case "$(uname -s)" in
    Darwin) font_dir="${HOME}/Library/Fonts" ;;
    Linux|MINGW*|MSYS*|CYGWIN*) font_dir="${HOME}/.local/share/fonts/MesloLGS-NF" ;;
    *)
      echo "Skipping font install (unsupported OS: $(uname -s))."
      echo "Install MesloLGS Nerd Font manually: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
      return 0
      ;;
  esac

  mkdir -p "$font_dir"

  local missing=0 name dest url
  for name in "${FONT_FILES[@]}"; do
    dest="${font_dir}/${name}"
    if [[ -f "$dest" && -s "$dest" ]]; then
      continue
    fi
    missing=1
    break
  done

  if ((missing == 0)); then
    echo "MesloLGS Nerd Font already installed: $font_dir"
  else
    echo "Installing MesloLGS Nerd Font -> $font_dir"
    for name in "${FONT_FILES[@]}"; do
      dest="${font_dir}/${name}"
      url="${FONT_BASE_URL}/$(printf '%s' "$name" | sed 's/ /%20/g')"
      echo "  downloading $name ..."
      curl -fsSL "$url" -o "$dest"
      [[ -s "$dest" ]] || die "failed to download $name"
    done
    echo "Installed MesloLGS Nerd Font (4 faces)."
  fi

  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f "$font_dir" >/dev/null 2>&1 || fc-cache -f >/dev/null 2>&1 || true
    echo "Refreshed font cache (fc-cache)."
  fi

  echo
  echo ">>> Set your terminal font to: MesloLGS NF  (or \"MesloLGS Nerd Font\")"
  echo "    Do NOT pick a Mono variant — Mono shrinks OS icons."
  echo "    Then open a new terminal window for the font to apply."
  echo
}

install_config() {
  local src dest="$HOME/.config/starship.toml"
  mkdir -p "$HOME/.config"

  if [[ -f "${BASH_SOURCE[0]%/*}/starship.toml" ]]; then
    src="${BASH_SOURCE[0]%/*}/starship.toml"
    cp "$src" "$dest"
    echo "Installed config from repo copy -> $dest"
  else
    curl -fsSL "$REPO_RAW" -o "$dest"
    echo "Installed config from GitHub -> $dest"
  fi
}

# Ensure ~/.local/bin is on PATH in the shell rc (needed when Starship is installed there).
ensure_local_bin_path() {
  local rc="$1"
  local line='export PATH="$HOME/.local/bin:$PATH"'

  [[ -f "$rc" ]] || return 0
  if grep -Fq '.local/bin' "$rc" 2>/dev/null; then
    return 0
  fi

  {
    echo ""
    echo "$MARKER — PATH"
    echo "$line"
  } >>"$rc"
  echo "Added ~/.local/bin to PATH in $rc"
}

# Append init once; skip if already present.
ensure_init() {
  local rc="$1" shell_name="$2" init_line="$3"

  if [[ ! -e "$rc" ]]; then
    # Only create an rc if that shell is actually used / available.
    if ! command -v "$shell_name" >/dev/null 2>&1; then
      echo "Skipping $rc ($shell_name not installed)"
      return 0
    fi
    touch "$rc"
  fi

  ensure_local_bin_path "$rc"

  if grep -Fq 'starship init' "$rc" 2>/dev/null; then
    echo "Already configured: $rc"
    return 0
  fi

  {
    echo ""
    echo "$MARKER"
    echo "$init_line"
  } >>"$rc"
  echo "Updated $rc"
}

detect_targets() {
  # Prefer explicit arg: bash | zsh | both (default: both that exist)
  local mode="${1:-both}"
  case "$mode" in
    bash) echo bash ;;
    zsh) echo zsh ;;
    both|"")
      local out=()
      command -v bash >/dev/null 2>&1 && out+=(bash)
      command -v zsh >/dev/null 2>&1 && out+=(zsh)
      # Fall back to $SHELL if somehow neither is on PATH
      if ((${#out[@]} == 0)); then
        case "${SHELL:-}" in
          */bash) out+=(bash) ;;
          */zsh) out+=(zsh) ;;
          *) die "neither bash nor zsh found; pass bash or zsh explicitly" ;;
        esac
      fi
      printf '%s\n' "${out[@]}"
      ;;
    *) die "usage: $0 [bash|zsh|both]" ;;
  esac
}

main() {
  local mode="${1:-both}" shell

  ensure_starship
  install_nerd_font
  install_config

  while IFS= read -r shell; do
    case "$shell" in
      bash) ensure_init "$HOME/.bashrc" bash 'eval "$(starship init bash)"' ;;
      zsh) ensure_init "$HOME/.zshrc" zsh 'eval "$(starship init zsh)"' ;;
    esac
  done < <(detect_targets "$mode")

  echo
  echo "Done. Open a new terminal (or: source ~/.bashrc / source ~/.zshrc)."
  echo "If icons still look like boxes, set the terminal font to MesloLGS NF and restart the terminal."
}

main "$@"
