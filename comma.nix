{ pkgs, ... }:

pkgs.writeShellScriptBin "," ''
  #!/bin/bash
  #
  # usage example:
  #   $ , yarn --help
  # This finds a derivation providing a bin/yarn, and runs it with `nix run`.
  # If there are multiple candidates, the user chooses one using `fzf`.
  set -euo pipefail

  if [[ $# -lt 1 ]]; then
    >&2 echo "usage: , <program> [arguments]"
    exit 1
  fi

  argv0=$1; shift

  case "''${argv0}" in
    @OVERLAY_PACKAGES@)
      attr="''${argv0}"
      ;;
    *)
      attr="$(${pkgs.nix-index}/bin/nix-locate --top-level --minimal --at-root --whole-name "/bin/''${argv0}")"
      if [[ "$(echo "''${attr}" | wc -l)" -ne 1 ]]; then
        attr="$(echo "''${attr}" | ${pkgs.fzf}/bin/fzf)"
      fi
      ;;
  esac

  if [[ -z $attr ]]; then
    >&2 echo "no match"
    exit 1
  fi

  nix run "nixpkgs.''${attr}" -c "''${argv0}" "$@"
''
