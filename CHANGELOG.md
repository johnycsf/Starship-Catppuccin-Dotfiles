# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/) where tagged releases exist.

## [Unreleased]
- Clarify that `main` stays the GitHub default; log bugs as Issues during testing.
- Document `testing` → `main` PR workflow (verify first, include CHANGELOG).

### Added

- `install.sh` installs **Homebrew** (if missing), installs **eza**, and creates/updates `alias ls='eza -lh --icons --git --hyperlink --header'` in bash/zsh rc files
- `install.sh` now installs **MesloLGS Nerd Font** (non-Mono) into the user fonts directory on Linux, macOS, and WSL, then refreshes `fc-cache` when available
- Interactive `./manage.sh` control center (where applicable)
- Soft pastel terminal UI for install/manage scripts
- `DISCLAIMER.md`, `CREDITS.md`, `CONTRIBUTING.md`, Sponsors funding links
- GitHub Issue bug report template

### Changed

- README: document Homebrew, eza, and the `ls` alias; document automatic font install and how to fix missing OS icons after an earlier install
- Standardized beginner-friendly install, update, and backup UX

### Fixed

- macOS OS icon in `starship.toml`: `Macos` now uses the Nerd Font Apple glyph (`nf-linux-apple`) instead of the incorrect Devicons character
- Missing Nerd Font after install caused OS / glyph icons to render as boxes
- Typo in `starship.toml`: `fg:creen` → `fg:green` for `vimcmd_symbol`

<!--
## [1.0.0] - YYYY-MM-DD
### Added
- Initial public release
-->
