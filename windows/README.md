# cosmicplayground and Windows

Are you using Windows? Support is a bit complicated:
see [cosmicplayground issue #29](https://github.com/cosmicplayground/cosmicplayground/issues/29).

As mentioned in the above posts,
<a href="https://wikipedia.org/wiki/Windows_Subsystem_for_Linux">WSL</a> is the recommended way for Windows users to develop Cosmicplayground.
(TODO video walkthrough)

- Windows instructions for VSCode: [/vscode](/vscode)
- Windows instructions for Postgres: [/postgres](/postgres)

WSL starts with Bash by default, so `chsh` doesn't work as expected.
To start with Fish, create a new shortcut (rightclick the desktop -> New -> Shortcut)
with the following contents: `%systemroot%\system32\bash -c /usr/bin/fish`

## [⇦](https://github.com/cosmicplayground/community)
