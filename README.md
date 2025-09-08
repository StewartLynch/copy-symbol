# copy-symbol

`copy-symbol` is a command-line tool that copies a PNG image representation of a given SF Symbols name to the clipboard.

## Install

#### Command line

```sh
cd copy-symbol
swift build -c release
ln -s ${PWD}/.build/release/copy-symbol /usr/local/bin/copy-symbol
```

#### Xcode

Open the `Package.swift` and build the project, then run the resulting `copy-symbol` tool from the command line.


## Usage

```sh
copy-symbol <sf-symbol-name> [-size N]
```

The PNG image of the specified symbol name is copied to your clipboard.

With the optional `-size` parameter, you can specify the maximum width or height of the image. The default is 100 px.

## Disclaimer
It is your responsibility to make sure you are following the terms and conditions of using Apple's symbols. For more information, see https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/.

## Author
[Ortwin Gentz](https://www.futuretap.com/about/ortwin-gentz) ([Mastodon](https://mastodon.social/@ortwingentz))

## Sponsors wanted
If you would like to support my Open Source work, consider joining me as a [sponsor](https://github.com/sponsors/futuretap)! 💪️ Your sponsorship enables me to spend more time on this and other community projects. Thank you!
