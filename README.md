# cosmicplayground dev setup

This repo has docs, configs, and scripts for setting up a dev environment from scratch
for coding on [Cosmicplayground](https://github.com/cosmicplayground/cosmicplayground).

Required:

- `apt` like Debian and Ubuntu - see [issue #2](https://github.com/cosmicplayground/setup/issues/2)

Optional:

- [`fish`](https://fishshell.com), the **f**riendly **i**nteractive **sh**ell
- [VSCode](https://code.visualstudio.com)

## verified working operating systems

- Linux
  - Ubuntu 21.10
  - for more distros, see [issue #2](https://github.com/cosmicplayground/setup/issues/2)
- Windows
  - WSL Ubuntu 20.04
  - until [this issue is resolved](https://github.com/cosmicplayground/cosmicplayground/issues/26),
    Windows users must use something like
    [WSL](https://wikipedia.org/wiki/Windows_Subsystem_for_Linux) or another VM with Linux —
    ([learn more](windows))
- macOS
  - see [issue #1](https://github.com/cosmicplayground/setup/issues/1)

## instructions

**1**. install a browser for development
  (I like to develop with [Chromium](https://www.chromium.org/Home))

**2**. install a text editor like [VSCode](https://code.visualstudio.com)
  (preferably one with good [Svelte support](https://github.com/sveltejs/language-tools)) —
  see [the `vscode/` directory](vscode) for recommended extensions and more

**3**. download
[this repo's files](https://github.com/cosmicplayground/setup/archive/refs/heads/main.zip)
and run [`setup.sh`](setup.sh):

```bash
bash setup.sh
```

and follow the prompts ⚡

> `setup.sh` should be idempotent;
> if you notice a problem running it more than once, bug reports are appreciated

**4**. start [Cosmicplayground](https://github.com/cosmicplayground/cosmicplayground) in dev mode:

```bash
cd ~/dev/cosmicplayground
npm i
# then
npm start
# or with gro, which is installed by the setup script with `npm i -g @feltcoop/gro`
gg # or gro dev
```

> learn more about [`@feltcoop/gro`](https://github.com/feltcoop/gro)

**5**. browse to `localhost:3000`!

## docs

- [`fish/`](fish) — config files that get copied over for fish initialization
- [`vscode/`](vscode) — config files for VSCode (copied over unless they exist)
- [`keyrate/`](keyrate) — speedy keyboard repeat rates
- [`windows/`](windows) — extra steps and notes for Windows users
- [`postgres/`](postgres) — extra steps for Windows WSL users

## links and resources

- task runner `@feltcoop/gro`: [github.com/feltcoop/gro](https://github.com/feltcoop/gro)
- Svelte: [svelte.dev](https://svelte.dev)
- SvelteKit: [kit.svelte.dev](https://kit.svelte.dev)
- [fish](https://fishshell.com) shell
- [VSCode](https://code.visualstudio.com) (not required, but recommended for
  [its Svelte support](https://github.com/sveltejs/language-tools))
  - [VSCode keyboard shortcuts for Linux](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)
- [Git](https://git-scm.com)
- [Cosmicplayground Dev Community](https://www.cosmicplayground.dev)
  ([source](https://github.com/cosmicplayground/community))
  - private feedback? <cosmicplayground.org@gmail.com>

## contributing

Please see
[contributing.md in the community repo](https://github.com/cosmicplayground/community/blob/main/contributing.md).


## license 🐦

public domain ⚘ [The Unlicense](license)