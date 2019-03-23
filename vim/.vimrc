set nu              "显示行号
set autoindent      "自动缩进
set smartindent		"智能选择对齐方式
set shiftwidth=4    "每一级缩进的长度
set softtabstop=4   "在编辑模式的时候按退格键的时候退回缩进的长度
set tabstop=4	    "VIM Tab键宽度
set mouse=a			"打开鼠标功能
syntax on			"高亮显示    

"Vundle插件 {{{
set nocompatible  
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'				" 自动补全
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'					" 搜索文件
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/taglist.vim'
Plugin 'fholgado/minibufexpl.vim'			" 多文档编辑i
Plugin 'Lokaltog/vim-easymotion'			" 快速移动
Plugin 'Lokaltog/vim-powerline'				" 增强的状态栏
Plugin 'scrooloose/nerdcommenter'			" 快速加减注释

call vundle#end()
filetype plugin indent on
" }}}

" NERDTree {{{
"将F2设置为开关NERDTree的快捷键
map <f2> :NERDTreeToggle<cr>

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

let NERDTreeHighlightCursorline=1
let g:NERDTreeDirArrows = 0
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeShowBookmarks=1
"设置窗口尺寸
let g:NERDTreewinSize=20
"窗口是否显示行号
let g:NERDTreeShowLineNumbers=1
" }}}

" nerdtree-git-plugin {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" }}}

" YouCompleteme {{{
" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全

nnoremap <F3> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist

inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
" }}}

" TagBar {{{
map <leader>tb :TagbarToggle<CR>  " \tb 打开tagbar窗口
let g:tagbar_autofocus = 1
" }}}

" TagList {{{
" 使用'\tl'打开Taglist/TxtBrowser窗口，在右侧栏显示
nmap <leader>tl :Tlist<CR><c-l>
" :Tlist              调用TagList
let Tlist_Show_One_File        = 1				" 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1				" 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1				" 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1				" 自动折叠
"let Tlist_Sort_Type = "name"					" items in tags sorted by name
" }}}

" minibufexpl {{{
" 多文件切换，也可使用鼠标双击相应文件名进行切换
let g:miniBufExplMapWindowNavVim    = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs  = 1
let g:miniBufExplModSelTarget       = 1
" 解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplCycleArround=1
" buffer 切换快捷键，默认方向键左右可以切换buffer
map <C-n> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>
" }}}

" vim-indent-guides {{{
" \ig 打开/关闭 vim-indent-guides
"let g:indent_guides_enable_on_vim_startup = 0	" 默认关闭
"let g:indent_guides_guide_size            = 1	" 指定对齐线的尺寸
"let g:indent_guides_start_level 	  = 2		" 从第二层开始可视化显示缩进
" }}}

" vim-powerline {{{
let g:Powerline_symbols = 'unicode'
" }}}

"
