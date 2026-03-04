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