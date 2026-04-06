#!/usr/bin/env perl
use strict;
use warnings;
use File::Spec;
use Cwd 'abs_path';

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

# styファイルの取得
sub get_git_root {
    my $dir = abs_path('.');
    while (1) {
        # .git フォルダ（またはファイル）が存在するかチェック
        if (-e File::Spec->catfile($dir, '.git')) {
            return $dir;
        }
        my $parent = File::Spec->catpath((File::Spec->splitpath($dir))[0,1], '..');
        $parent = abs_path($parent);
        
        # ルートディレクトリまで到達したら終了
        last if $dir eq $parent;
        $dir = $parent;
    }
    return undef;
}

my $root = get_git_root();

if (defined $root) {
    # Windowsのバックスラッシュをスラッシュに置換（TeX用）
    $root =~ s/\\/\//g;
    
    # lib/lualatex-report-template-sty を追加
    # 末尾の // はサブディレクトリも再帰的に探す指定
    my $sty_path = "$root/lib/lualatex-report-template-sty//";
    
    # Windowsの区切り文字「;」を使用。
    # 先頭に自分のパス、末尾に「;」を置くことで標準パスも維持される
    $ENV{'TEXINPUTS'} = "$sty_path;" . ($ENV{'TEXINPUTS'} // '');
    
    print "--- Template Path Loaded ---\n";
    print "Git Root: $root\n";
    print "Style Path: $sty_path\n";
    print "----------------------------\n";
} else {
    print "Warning: .git not found. Using default paths.\n";
}