# レポート用LaTeXテンプレート

これは、LaTeXでレポートを作成するためのテンプレートです。本リポジトリはレポート用のテンプレートと、Gitサブモジュール化した際に使用するテンプレートのスタイルファイルで構成されています。

本リポジトリの構成の概要を以下に示します。

```
.
├── lualatex-report-template/         # テンプレート
├── lualatex-report-template-sty/     # スタイルファイルが格納されています
├── .gitignore                        # Git管理除外設定
├── README.md                         # 本説明書
├── report-normal-sample.pdf          # ノーマル版の完成見本
└── report-simple-sample.pdf          # シンプル版の完成見本
```

main.tex中の設定を切り替えることで、以下の2種類のテンプレートを使用することができます（使用方法の詳細は下記）。
| テンプレート名 | 表紙 | 目次 | メモ |
| :--- | :---: | :---: | :--- |
| ノーマル版 | 有 | 有 | フォーマルなレポートの作成に適しています |
| シンプル版 | 無 | 無 | カジュアルな普段使いのレポート作成に適しています |

また、各テンプレートの仕上がりイメージを確認できるサンプルファイルを同梱しています。テンプレートを使用する際の参考に利用してください。
- `report-normal-sample.pdf`
    - ノーマル版テンプレートを使用した、フォーマルな表紙・目次ありの構成例。
- `report-simple-sample.pdf`
    - シンプル版テンプレートを使用した、表紙・目次なしの構成例。

## 開発環境
- **TeX Distribution**: TeX Live 2025
- **Engine**: LuaLaTeX
- **Editor**: Visual Studio Code
- **Extension**: LaTeX Workshop

## 構成
### `lualatex-report-template/`の構成
`lualatex-report-template/`は以下のような構成となっています。

```
.
├── main.tex              # 【メイン】親ファイル。各ファイルを統合します
├── .latexmkrc            # 【設定】latexmkの動作設定ファイル
├── settings.json         # 【設定】VSCode LaTeX Workshop用のビルドレシピ
├── contents/             # 【本文・設定】ソースファイル群
│   ├── base.sty          # パッケージ等の読み込みを行います
│   ├── title.sty         # タイトルデザインを行います
│   ├── config.tex        # レイアウトなどの詳細設定を行います
│   ├── body.tex          # 本文（レポートの中身）
│   └── reference.tex     # 参考文献（thebibliography環境用）
├── data/                 # 【データ】表計算用のCSVやソースコードなど
├── figures/              # 【画像】挿入する画像ファイル（PNG, PDF, JPG）
└── out/                  # 【出力】ビルド時に生成される一時ファイルおよびPDF
```

- `main.tex`
    - メインファイル。
    - タイトル情報やパッケージの設定を行います。
- `.latexmkrc`/`settings.json`
    - LuaLaTeXでのコンパイルを自動化するための設定です.
    - 基本的には編集不要ですが、VSCodeでビルドが失敗する場合はこれらがルートにあることを確認してください。
- `contents/base.sty`
    - パッケージの追加や、独自のコマンド定義（マクロ）を行う場所です。
- `contents/title.sty`
    - タイトルデザインを行います。新たなタイトルデザインを追加する際はここを編集します。
- `contents/config.tex`
    - レイアウトを調整したい場合はここを編集します。
- `contents/body.tex`
    - **メインの執筆場所**です。
    - レポートの本文をここに記述します。
- `out/`
    - コンパイル時に**自動生成**されます。
    - 実行後のPDFや中間ファイル（`.aux`, `.log`等）はこの中に格納されます。

### `lualatex-report-template-sty/`の構成
`lualatex-report-template-sty/`は以下のような構成となっています。

```
.
├── lualatex-report-base.sty      # パッケージ等の読み込みを行います
└── lualatex-report-title.sty     # タイトルデザインを行います
```

- `lualatex-report-base.sty`
    - `base.sty`のGitサブモジュール化用ファイルです。
- `lualatex-report-title.sty`
    - `title.sty`のGitサブモジュール化用ファイルです。

## 使い方
1. `lualatex-report-template/`のリポジトリをダウンロードし、解凍します。
1. 解凍したフォルダをVSCode等のエディタで開きます。
1. `contents/`フォルダ中の`config.tex`ファイルを開き、必要に応じて以下の設定を行います。
    1. **レイアウト・装飾**：必要に応じて`=== レイアウト・装飾 ===`セクションを変更します。
    1. **参照・参考文献**：参考文献等を載せる場合は、`=== 参考文献 ===`セクション以下のように変更します。
        1. thebibliography環境を用いる場合は`\usepackage[superscript]{cite}`のコメントアウトを外し、`main.tex`ファイルの`\end{document}`直前にある`=== 参考文献 ===`セクションの`\input{contents/reference.tex}`のコメントアウトを外します。
        1. BiBLaTeXを用いる場合は、`\usepackage[backend=biber, style=numeric-comp, sorting=none]{biblatex}`および`\addbibresource{references.bib}`のコメントアウトを外し、bibファイルを作成した上で`\addbibresource{references.bib}`を任意のファイル名に変更します。そして`main.tex`ファイルの`\end{document}`直前にある`=== 参考文献 ===`セクションの`\printbibliography`のコメントアウトを外します。
1. `main.tex` を開き、必要に応じて以下の設定を編集します。
    1. `=== スタイル選択 ===`セクションの`\newcommand{\titleStyle}{}`のコメントアウトを外し、空欄{}内に1（ノーマル版）または2（シンプル版）の数字を記入します。
    1. `=== タイトル ===`セクションの、`\title`、`\author`等を変更します。
1. `contents/`フォルダ中の`body.tex`ファイルにレポート本文の内容を書きます。
1. 本文を分割して管理する場合は、`contents/`フォルダ中にtexファイルを作成し、`main.tex`ファイルの`=== 本文 ===`セクションに`\input{contents/[作成したファイル名].tex}`を追記します。
1. 編集が終了したら、保存しLaTeXのコンパイルを行います。
1. コンパイルが成功したら、生成されたpdfファイルを開いて、内容を確認します。

## Gitサブモジュール化の方法
複数のレポートで共通のスタイルを適用し、一括でアップデートしたい場合、`lualatex-report-template-sty/`リポジトリ中のstyファイルをGitサブモジュールとして利用できます。以下の手順でセットアップしてください。
1. プロジェクトを作成するフォルダを開き、Gitで管理されていない場合以下をターミナルに打ち込みます。
    ```
    git init
    ```
1. プロジェクトのルートディレクトリ（隠しフォルダ`.git`のある階層）で以下をターミナルに打ち込みます。
    ```
    git submodule add https://github.com/ihkonro/latex-report-template-dist.git lib
    ```
1. main.texを開き、以下の手順でstyファイルを読み込みます。
    1. `=== base.styの読み込み ===`セクションで、`\usepackage{lualatex-report-base}`のコメントアウトを外し、`\usepackage{contents/base}`をコメントアウトします。
    1. `=== title.styの読み込み ===`セクションで、`\usepackage{lualatex-report-title}`のコメントアウトを外し、`\usepackage{contents/title}`をコメントアウトします。
1.  テンプレートを最新版に更新する場合、プロジェクトのルートディレクトリで以下をターミナルに打ち込みます。
    ```
    git submodule update --remote lib
    ```

## CloudLaTeXでの使い方
本テンプレートはローカルにLaTeX環境がない場合、CloudLaTeXでも利用可能です。以下の手順でセットアップしてください。

1. 以下のフォルダおよびファイルをダウンロードし、準備します。なお、`setting.json`や`.latexmkrc`は不要です。
    - `main.tex`
    - `contents/`フォルダ全体
    - `figures/`フォルダ
    - `data/`フォルダ（使用する場合）
1. CloudLaTeXのプロジェクト画面に、上記のファイル・フォルダをそのままドラッグ＆ドロップし、アップロードします。
1. 画面右上のハンバーガーメニューを開き、プロジェクト設定のLaTeXエンジンを`LuaLaTeX`に変更し、保存します。
1. `コンパイル`ボタンを押し、LaTeXのコンパイルを行います。
1. コンパイルが成功したら、以降は通常通り`main.tex`や`body.tex`を編集して使用してください。

## 注意事項
- すべてのファイルはUTF-8で保存してください。
- 日本語やスペースをファイル名に使用するのは避けてください（コンパイルエラーの原因となる場合があります）。
- 初回ビルドには時間がかかる場合があります。
- 生成されたPDFを外部ビューアで開いたままにすると、再ビルドに失敗する場合があります。

## 更新履歴
- **Ver.1.0.0 (2026-03-04)**
    - 初版公開。
- **Ver.2.0.0 (2026-03-06)**
    - テンプレートの一元化と拡張性の向上を行いました。また、Gitサブモジュール化に対応しました。