# README

# Installation

Installing scipy on MacOS Big Sur is a huge pain. Fortunately a kind soul wrote instructions on how to accomplish it:

https://return2.net/macos-big-sur-python-3-7-installation-with-homebrew/

What worked for me was the following:

```
OPENBLAS="$(brew --prefix openblas)" pip install scipy
```
