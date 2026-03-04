# レポート用LaTeXテンプレート

これは、LaTeXでレポートを作成するためのテンプレートです。以下の2種類のテンプレートが存在します。

| テンプレート名 | 表紙 | 目次 | メモ |
| :--- | :---: | :---: | :--- |
| `lualatex-report-normal-template` | 有 | 有 | フォーマルなレポートの作成に適しています |
| `lualatex-report-simple-template` | 無 | 無 | カジュアルな普段使いのレポート作成に適しています |

また、各テンプレートの仕上がりイメージを確認できるサンプルファイルを同梱しています。テンプレートを使用する際の参考に利用してください。
- `report-normal-sample.pdf`
    - `lualatex-report-normal-template`テンプレートを使用した、フォーマルな表紙・目次ありの構成例。
- `report-simple-sample.pdf`
    - `lualatex-report-simple-template`テンプレートを使用した、表紙・目次なしの構成例。

## 開発環境
- **TeX Distribution**: TeX Live 2025
- **Engine**: LuaLaTeX
- **Editor**: Visual Studio Code
- **Extension**: LaTeX Workshop

## 構成
`lualatex-report-normal-template`および`lualatex-report-simple-template`は以下のような構成となっています。

```
.
├── main.tex              # 【メイン】親ファイル。各ファイルを統合します
├── .latexmkrc            # 【設定】latexmkの動作設定ファイル
├── settings.json         # 【設定】VSCode LaTeX Workshop用のビルドレシピ
├── contents/             # 【本文・設定】ソースファイル群
│   ├── preamble.tex      # プリアンブル（パッケージ読み込み・書式設定）
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
- `contents/preamble.tex`
    - パッケージの追加や、独自のコマンド定義（マクロ）を行う場所です。レイアウトを調整したい場合はここを編集します。
- `contents/body.tex`
    - **メインの執筆場所**です。
    - レポートの本文をここに記述します。
- `out/`
    - コンパイル時に**自動生成**されます。
    - 実行後のPDFや中間ファイル（`.aux`, `.log`等）はこの中に格納されます。

## 使い方
1. `lualatex-report-normal-template`または`lualatex-report-simple-template`のリポジトリをダウンロードし、解凍します。
1. 解凍したフォルダをVSCode等のエディタで開きます。
1. `main.tex` を開き、必要に応じて以下の設定を編集します。
    1. **レイアウト**：必要に応じて`=== レイアウト ===`セクションのコメントアウトを以下のように変更します。
        1. 段落ごとのインデントを行わない場合は`\setlength{\parindent}{0pt}`のコメントアウトを外します。
        1. 段落間に空きを入れる場合は`\setlength{\parskip}{0.6em}`のコメントアウトを外し、必要に応じて段落間の大きさを調整します。
    1. **参照・参考文献**：参照文献等を載せる場合は、`=== 参照 ===`セクション以下のように変更します。
        1. thebibliography環境を用いる場合は`\usepackage[superscript]{cite}`のコメントアウトを外し、`\end{document}`直前にある`=== 参考文献 ===`セクションの`\input{contents/reference.tex}`のコメントアウトを外します。
        1. BiBLaTeXを用いる場合は、`\usepackage[backend=biber, style=numeric-comp, sorting=none]{biblatex}`および`\addbibresource{references.bib}`のコメントアウトを外し、bibファイルを作成した上で`\addbibresource{references.bib}`を任意のファイル名に変更します。そして`\end{document}`直前にある`=== 参考文献 ===`セクションの`\printbibliography}`のコメントアウトを外します。
    1. **タイトル情報**：`=== タイトル情報 ===`セクションの、`\title`、`\author`等を変更します。
1. `contents/`フォルダ中の`body.tex`にレポート本文の内容を書きます。
1. 本文を分割して管理する場合は、`contents/`フォルダ内にtexファイルを作成し、`main.tex`の`=== 本文 ===`セクションに`\input{contents/作成したファイル名}`を追記します。
1. 編集が終了したら、保存しLaTeXのコンパイルを行います。
1. コンパイルが成功したら、生成されたpdfファイルを開いて、内容を確認します。

## CloudLaTeXでの使い方
本テンプレートはCloudLaTeXでも利用可能です。以下の手順でセットアップしてください。

1. 以下のフォルダおよびファイルをダウンロードし、準備します。なお、`setting.json`や`.latexmkrc`は不要です。
    - `main.tex`
    - `contents/`フォルダ（中身のファイルを含む）
    - `figures/`フォルダ
    - `data/`フォルダ（使用する場合）
1. CloudLaTeXのプロジェクト画面に、上記のファイル・フォルダをそのままドラッグ＆ドロップし、アップロードします。
1. 画面右上のハンバーガーメニューを開き、プロジェクト設定のLaTeXエンジンを`LuaLaTeX`に変更し、保存します。
1. `コンパイル`ボタンを押し、LaTeXのコンパイルを行います。
1. コンパイルが成功したら、本プロジェクトをコピーし、任意の名前をつけ、上記「使い方」同様に、必要に応じて`main.tex`の変更を行います。

## 注意事項
- すべてのファイルはUTF-8で保存してください。
- 日本語やスペースをファイル名に使用するのは避けてください（コンパイルエラーの原因となる場合があります）。
- 初回ビルドには時間がかかる場合があります。
- 生成されたPDFを外部ビューアで開いたままにすると、再ビルドに失敗する場合があります。

## 更新履歴
- **Ver.1.0.0 (2026-03-04)**
    - 初版公開。