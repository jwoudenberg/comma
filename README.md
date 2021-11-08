# ,

Comma runs software without installing it.

Basically it just wraps together `nix run` and `nix-index`. You stick a `,` in front of a command to
run it from whatever location it happens to occupy in `nixpkgs` without really thinking about it.

Changes with the upstream comma:

- Distributed as a flake.
- Uses your local `nix-index` database rather than a downloaded copy.
- Made to work with the 2.4 version of the Nix CLI.
- Dropped support for the `--install` flag.

## Usage

[See a quick demo on
YouTube](https://www.youtube.com/watch?v=VUM3Km_4gUg&list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs)

```bash
, cowsay neato
```
