" System vimrc file for MacVim
"
" Maintainer:  Bjorn Winckler <bjorn.winckler@gmail.com>
" Last Change:	Sat Aug 29 2009

set nocompatible

" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it.

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none

"文字コード
set encoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

"number
set number
set modifiable
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "画面上でタブ文字が占める幅

set nf="" "10進数

"<Ctr-j>を<esc>にマップ
imap <c-j> <esc>

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;

"-------イカちゃん くコ:彡 -------
"au = automod イベントが起きたとき登録しておいたコマンドを実行
"VimEnter ... Vim が起動した時
au VimEnter * set statusline=くコ:彡

"InsertEnter ... 挿入モードになった時
au InsertEnter * set statusline=━┓🚶

"InsertLeave ... 挿入モードをやめた時
au InsertLeave * set statusline=くコ:彡

"statusline とはイカを表示するための領域のこと
set laststatus=2

"filerの設定
let g:vimfiler_as_default_explorer = 1

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    " ここにインストールしたいプラグインのリストを書く
    NeoBundle 'kana/vim-submode'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
        \ 'windows' : 'make -f make_mingw32.mak',
        \ 'cygwin' : 'make -f make_cygwin.mak',
        \ 'mac' : 'make -f make_mac.mak',
        \ 'unix' : 'make -f make_unix.mak',
      \ },
    \ }
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'h1mesuke/unite-outline'
    NeoBundle 'Align'
    NeoBundle 'scrooloose/nerdtree' "ファイルをtree表示してくれる
    NeoBundle 'tpope/vim-rails' "Rails向けのコマンドを提供する
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'tpope/vim-endwise' "Ruby向けにendを自動挿入してくれる
    NeoBundle 'tomtom/tcomment_vim' "コメントON/OFFを手軽に実行する
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'idanarye/vim-merginal' " git管理(編集系、コマンド直接実行)
    NeoBundle 'rhysd/committia.vim' " git管理(コミット画面を編集しやすくする)
    NeoBundle 'gregsexton/gitv' "git管理（gitのlogをグラフィカル表示）
    NeoBundle 'mattn/emmet-vim' "emmet-vim
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'slim-template/vim-slim'
    NeoBundle 'nathanaelkane/vim-indent-guides' "インデントに色をつけて見やすくする
    NeoBundle 'vim-scripts/AnsiEsc.vim' "ログファイルを色付けしてくれる
    NeoBundle 'bronson/vim-trailing-whitespace' "行末の半角スペースを可視化
    NeoBundle 'alpaca-tc/alpaca_tags' "CTagsを自動化してくれるツール
    NeoBundle 'altercation/vim-colors-solarized' " Color Scheme
    NeoBundleCheck
  call neobundle#end()
endif

" vimshell setting
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "

" vimshell map
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

" 行頭 Shift + h
" 行末 Shift + l
nnoremap <S-h> ^
nnoremap <S-l> $

" NERDTreeの設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>

"------------------------------------
" vim-rails
"------------------------------------
""{{{
"有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction
let g:neocomplete#enable_at_startup = 1

"Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
  au!
aug END
"}}}


let g:indent_guides_enable_on_vim_startup = 1 " 自動的にvim-indent-guidesをオンにする

" Ruby辞書ファイル
let g:neocomplete#sources#dictionary#dictionaries = {
\   'ruby': $HOME . '/dicts/ruby.dict',
\ }

" grep検索
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" unite grepにhw(highway)を使う
if executable('hw')
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
endif

"FixWhitespaceというコマンドを実行するとそうしたスペースを自動的に削除してくれる
NeoBundleLazy 'basyura/unite-rails', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : [
      \     'rails/bundle', 'rails/bundled_gem', 'rails/config',
      \     'rails/controller', 'rails/db', 'rails/destroy', 'rails/features',
      \     'rails/gem', 'rails/gemfile', 'rails/generate', 'rails/git', 'rails/helper',
      \     'rails/heroku', 'rails/initializer', 'rails/javascript', 'rails/lib', 'rails/log',
      \     'rails/mailer', 'rails/model', 'rails/rake', 'rails/route', 'rails/schema', 'rails/spec',
      \     'rails/stylesheet', 'rails/view'
      \   ]
      \ }}

"------------------------------------
" Unite-rails.vim
"------------------------------------
"{{{
function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>

  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END
"}}}

"------------------------------------
" クリップボードの中身を貼り付ける時に自動でペーストモードになる設定
" http://qiita.com/ringo/items/bb9cf61a3ccfe6183c7b
"------------------------------------
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif


" Rubyのコードがコーディングルールに遵守されているかチェックする
" http://qiita.com/yuku_t/items/0ac33cea18e10f14e185
"NeoBundle 'scrooloose/syntastic'
"let g:syntastic_mode_map = { 'mode': 'passive',
"            \ 'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop']

"if !exists('loaded_matchit')
  " matchitを有効化
"  runtime macros/matchit.vim
"endif

"------------------------------------
" ウィンドウ幅やタブ関連の設定
"------------------------------------
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
"s+nptT move to tab
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
" nnoremap sp :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

syntax enable
set background=light
" set t_Co=256
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
colorscheme solarized

filetype plugin on
filetype indent on
