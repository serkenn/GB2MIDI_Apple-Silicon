# GB2MIDI
Tools for converting Garageband (Mac OS X) files to MIDI files

## 日本語
GarageBand (macOS) のファイルから MIDI を抽出するツールです。

### 使い方（手動）
GarageBand から MIDI を書き出すには、まず MIDI セグメントをループとして作成します（トラック全体にするにはセグメントを結合してから、ループ領域へドラッグ＆ドロップ）。ループは最大 45 小節まで。それ以上の場合はメニューの `Edit -> Add to Loop Library` を使います。作成されたループファイルは `/User/Library/Audio/Apple Loops/User Loops/SingleFiles/` に `.aif` で保存されます（初回作成まではフォルダ自体が存在しない場合があります）。

その `.aif` から “MTrk”〜“CHS” の範囲を切り出して `.mid` として保存します。手作業のほか、付属の [GB2MIDI "app"](GB2MIDI.zip) を使うと自動化できます（ドラッグ＆ドロップ、またはスクリプト起動で複数選択）。

### Apple Silicon / 近年の macOS
このリポジトリには Apple Silicon 向け `.app` を GitHub Actions で生成するワークフローが含まれています。Release から `GB2MIDI.app.zip` をダウンロードしてください。

### ブラウザ版
実験的な [JavaScript 版](https://larkob.github.io/GB2MIDI/index.html) もあります。ブラウザ上で変換できます。

Instructions:
In order to export MIDI from Garageband, you first need to create a loop from the MIDI segment (join segments for a whole track) via drag&drop into the loop area (up to 45 measures long, otherwise you the menu edit->add to loop library). You can find the resulting loop file in the folder /User/Library/Audio/Apple Loops/User Loops/SingleFiles/ with the .aif suffix.
(Please note that this folder is only created after you created your first loops and can be tricky to navigate to in the Finder.)

You can either use a Hex-Editor to cut out the part between “MTrk” and “CHS” and save as a .mid file or download and use the [GB2MIDI "app"](GB2MIDI.zip) (written in AppleScript) for Mac OS X in this repository. Either drag & drop onto the icon, or run the script and select files. The resulting files will be saved with the same name but a .mid suffix. The original AppleScript tool was published on my website http://www.larskobbe.de/midi-export-in-apples-garageband

## Apple Silicon / modern macOS
The bundled `.app` is Intel-only. For Apple Silicon (and any modern macOS), use the Python rewrite:

```bash
./gb2midi.py /path/to/loop1.aif /path/to/loop2.aif
```

It writes `.mid` files next to the input files. Python 3 is included on recent macOS versions.

I have also created a (experimental) [JavaScript-based version of the GB2MIDI app](https://larkob.github.io/GB2MIDI/index.html) which works directly in your browser.

This software is freeware and must be considered beta status. Use on your own risk, even though I believe it is perfectly safe to use.

## Apple Silicon .app build (GitHub Actions)
This repo includes a GitHub Actions workflow that builds a fresh Apple Silicon `.app` and attaches it to a GitHub Release.

How it works:
- The build runs on `macos-14` (Apple Silicon).
- It compiles `src/GB2MIDI.applescript` into `dist/GB2MIDI.app`.
- It bundles `gb2midi.pl` and the icon, then zips the app.

To publish a release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

The workflow will create a release asset named `GB2MIDI.app.zip`.
