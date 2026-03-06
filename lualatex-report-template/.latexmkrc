#!/usr/bin/env perl

# --- LuaLaTeX設定 (.latexmkrc) ---

# PDFを直接出力するモード (4 = lualatex)
$pdf_mode = 4;

# DVIやPSは作らない
$postscript_mode = $dvi_mode = 0;

# コンパイルコマンドの設定
# (-interaction=nonstopmode はエラーで止まらずに進む設定)
$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';

# 参考文献と索引の処理（日本語対応版を使う）
$bibtex = 'upbibtex %O %S';
$makeindex = 'upmendex %O -o %D %S';

# Gitのコマンドを使って、一番上のフォルダ（リポジトリのルート）の絶対パスを取得
my $repo_root = `git rev-parse --show-toplevel 2> /dev/null`;
chomp($repo_root); # 余計な改行を削除

# もしGit管理下であれば、絶対パスを使って探索パスを設定
if ($repo_root ne '') {
    # Windowsでも動くようにパスを安全に結合
    $ENV{'TEXINPUTS'} = "$repo_root/lib/lualatex-report-template-sty//;" . $ENV{'TEXINPUTS'};
} else {
    # 万が一Git管理下でなかった場合の保険
    $ENV{'TEXINPUTS'} = '../lib/lualatex-report-template-sty//;' . $ENV{'TEXINPUTS'};
}