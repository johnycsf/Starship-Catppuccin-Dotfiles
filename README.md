# Starship with Catppuccin theme

![Repobeats analytics image](https://repobeats.axiom.co/api/embed/ce842a52094ac581de623718f7235a95de99c767.svg "Repobeats analytics image")

[![Sponsor](https://img.shields.io/badge/Sponsor-%E2%9D%A4-ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/johnycsf)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Issues](https://img.shields.io/badge/issues-welcome-lightgrey.svg)](../../issues/new/choose)

My [Starship](https://starship.rs/) prompt config (Catppuccin Mocha).

**Starship + Catppuccin Mocha** — one-liner install for bash/zsh on **Linux, macOS, and WSL**.

Works with **bash** and **zsh**.

![Starship Catppuccin prompt preview](assets/prompt-preview.png)

## Support this work

**If this prompt helped you — or saved you time — please consider [sponsoring or donating](https://github.com/sponsors/johnycsf).** Your support keeps dotfiles and homelab tools maintained for everyone.

Your sponsorship funds:

- Keeping the installer working on **Linux, macOS, and WSL**
- Updating the Catppuccin theme as Starship releases new features
- More beginner-friendly configs and homelab stacks

[![Sponsor johnycsf](https://img.shields.io/badge/GitHub%20Sponsors-Donate-ea4aaa?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/johnycsf)

👉 **[github.com/sponsors/johnycsf](https://github.com/sponsors/johnycsf)** — even a small monthly sponsorship helps keep development going.

## Quick install

```bash
curl -fsSL https://raw.githubusercontent.com/johnycsf/Starship-Catppuccin-Dotfiles/main/install.sh | bash
```

That will:

1. Install **Starship** if it is missing
2. Install **MesloLGS Nerd Font** into your user fonts folder (Linux / macOS / WSL)
3. Install this `starship.toml`
4. Install **Homebrew** if missing, then install **eza**
5. Set `ls` to `eza -lh --icons --git --hyperlink --header` (creates or replaces an existing `ls` alias)
6. Wire up bash and/or zsh (including Homebrew on `PATH`)

**After install:** set your terminal’s font to **MesloLGS NF** (not a Mono variant), then open a new terminal. Without that step, OS icons show as boxes or tofu.

Or clone and run locally:

```bash
git clone https://github.com/johnycsf/Starship-Catppuccin-Dotfiles.git
cd Starship-Catppuccin-Dotfiles
./install.sh        # bash and/or zsh
./install.sh bash   # bash only
./install.sh zsh    # zsh only
```

Open a new terminal (or `source ~/.bashrc` / `source ~/.zshrc`).

## macOS

Fully supported on **macOS** (Intel and Apple Silicon). The default shell is **zsh**; bash works too.

```bash
curl -fsSL https://raw.githubusercontent.com/johnycsf/Starship-Catppuccin-Dotfiles/main/install.sh | bash
# or zsh only:
./install.sh zsh
```

The installer will:

- Install Starship to `~/.local/bin`
- Install **MesloLGS NF** into `~/Library/Fonts`
- Install **Homebrew** (if missing) and **eza**, then set the enhanced `ls` alias
- Update `~/.zshrc` and/or `~/.bashrc`

**Set your terminal font to MesloLGS NF**, then open a new window:

| Terminal | Font setting |
|----------|----------------|
| **iTerm2** | Settings → Profiles → Text → Font |
| **Terminal.app** | Settings → Profiles → Font |
| **Cursor / VS Code** | Settings → Terminal › Integrated: Font Family |
| **Warp** | Settings → Appearance → Text → Font |

Without the Nerd Font, OS icons in the prompt show as boxes or tofu.

### Already installed but missing icons?

Re-run the installer (it skips Starship/config if present and still installs the font):

```bash
curl -fsSL https://raw.githubusercontent.com/johnycsf/Starship-Catppuccin-Dotfiles/main/install.sh | bash
```

Then pick **MesloLGS NF** in your terminal settings (Cursor, VS Code, Windows Terminal, iTerm, GNOME Terminal, etc.).

## Manual install

1. Install Starship: https://starship.rs/guide/#%F0%9F%9A%80-installation
2. Install [MesloLGS Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) and set it as your terminal font
3. Copy the config:

```bash
mkdir -p ~/.config
curl -fsSL https://raw.githubusercontent.com/johnycsf/Starship-Catppuccin-Dotfiles/main/starship.toml \
  -o ~/.config/starship.toml
```

4. Add **one** of these to your shell rc:

**bash** (`~/.bashrc`):

```bash
eval "$(starship init bash)"
```

**zsh** (`~/.zshrc`):

```zsh
eval "$(starship init zsh)"
```

## Credits

This repo packages or configures upstream software. See [CREDITS.md](CREDITS.md) for the main developers and projects this work builds on.

## Disclaimer

This project is provided **as is**. The author is **not responsible** for any loss, damage, data corruption, downtime, security issues, or other consequences from using it. Full text: [DISCLAIMER.md](DISCLAIMER.md).

## Bug reports & contributions

If you hit an error, please [open a GitHub Issue](../../issues/new/choose) and follow [CONTRIBUTING.md](CONTRIBUTING.md). Fixes via Pull Request are welcome. GitHub Issues/PRs are the supported way to report problems—there is no private support channel.

## Security

See [SECURITY.md](SECURITY.md) for how to report vulnerabilities.
