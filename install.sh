#!/bin/sh

set -eu

skip_integration=false
if [ "${1:-}" = "--skip-integration" ]; then
	skip_integration=true
	shift
fi

if [ "$#" -ne 0 ]; then
	printf 'Usage: %s [--skip-integration]\n' "$0" >&2
	exit 2
fi

for dependency in git nvim herdr codex jq; do
	if ! command -v "$dependency" >/dev/null 2>&1; then
		printf 'Missing dependency: %s\n' "$dependency" >&2
		exit 1
	fi
done

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
user_home=${DOTFILES_TARGET_HOME:-${HOME:?HOME is not set}}
timestamp=$(date '+%Y%m%d-%H%M%S')

case "$user_home" in
	/*) ;;
	*)
		printf '%s\n' "Target home must be an absolute path: $user_home" >&2
		exit 1
		;;
esac

if [ "$user_home" = "/" ]; then
	printf '%s\n' "Refusing to use the filesystem root as target home." >&2
	exit 1
fi

backup_path() {
	target=$1
	backup="${target}.backup-${timestamp}"
	index=1

	while [ -e "$backup" ] || [ -L "$backup" ]; do
		backup="${target}.backup-${timestamp}-${index}"
		index=$((index + 1))
	done

	printf '%s\n' "$backup"
}

link_path() {
	source=$1
	target=$2

	if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
		printf 'Already linked: %s\n' "$target"
		return
	fi

	mkdir -p "$(dirname "$target")"

	if [ -e "$target" ] || [ -L "$target" ]; then
		backup=$(backup_path "$target")
		mv "$target" "$backup"
		printf 'Backed up: %s -> %s\n' "$target" "$backup"
	fi

	ln -s "$source" "$target"
	printf 'Linked: %s -> %s\n' "$target" "$source"
}

link_path \
	"$repo_dir/nvim/.config/nvim" \
	"$user_home/.config/nvim"

link_path \
	"$repo_dir/bin/.local/bin/ide" \
	"$user_home/.local/bin/ide"

case ":${PATH}:" in
	*":$user_home/.local/bin:"*) ;;
	*)
		printf '%s\n' "Warning: add $user_home/.local/bin to PATH." >&2
		;;
esac

if [ "$skip_integration" = false ]; then
	herdr integration install codex
fi

printf '%s\n' "Installation complete. Start Herdr, then run: ide <project-directory>"
