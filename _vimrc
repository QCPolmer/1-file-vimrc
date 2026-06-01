
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" MINIMAL INSTALLS: BELOW ARE THE MAIN THINGS NEEDED"""
""BELOW REQUIRES SYNTAX/SYNTAX.VIM, FILETYPE.VIM and needed 'syntax' file
""""" will run without, throws erros and no syntax highlighting. 
""""""""""""""""""""""
"""" win-key-base, 
"""j+k to enter normal mode, 
"""d+f in normal mode to launch my custom-functs menu
""" 	(check it out, it explains other features)
""""""""""""""""""""
""" (explained in custom-functs menu, but...
"""	lines starting with ":",":+", "=", "=+" try to execute 
"""	code on pressing 'enter' (shift+enter ignores, '=' gets results)
"""""""""""""""'
""" IF ON DIFFERENT COMPUTER: 
"""   :w|so %   to run this script!
"""""""""""""""""""""""""""""""""""""""""
"MENUS ARE AT BOTTOM, UNDER CHEATSHEETS!!!
"""""""""""""""""""""	 
 " :b:WIN_KEYS__SETTUP__CTRL_S_COMPILE:b:
autocmd VimEnter *    echo "               MENU:'df' IN NORMAL MODE "

syntax enable
filetype plugin on

"" BELOW SPELL REQUIRES spell/system language files (spellcheck) 
"" ONLY "silent!"  because on dos this throws an error,
silent! set number
silent! setl spell
silent! autocmd BufEnter * setl spell
silent! set spelllang=en_us
"""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildmode=longest,list

" THIS ALLOWS LINE BREAKS WITH \ !!! MULTI_LINE CRAP!!!
set nocompatible

"highlight search results
set hlsearch
"system clipboard, if available 
if has('clipboard') && has('unnamedplus')
	set clipboard=unnamedplus
endif
set ff=unix

if v:version >= 750
  " Code for Vim version 7.5 or higher
	set cryptmethod=blowfish2
else
  " Code for Vim versions lower than 7.5
endif

nnoremap [[ [m
nnoremap ]] ]m
nnoremap ? /;<enter>

if has("unix") 
	set clipboard=unnamedplus 
else
	set clipboard=unnamed 
endif

" this is myFunction, for calling an 'interpreter' like 
" script, so with a single key press I can compile/interpret
" a command ()
function! Vim_1_Key_Run_Compile_LINUX_GUI_XTERM()
	if filereadable( ( expand('%:r') . '.cmd') )  
		execute("!xterm -hold -e 'sh %:r.cmd'")
	elseif filereadable( ( expand('%:r:r') . '.cmd') )  
		execute("!xterm -hold -e 'sh %:r:r.cmd'")
	"new 4/4/2026- looking up 3 files (max) to find 'm.cmd'...  
	elseif filereadable( (   'm.cmd') )  
		execute("!xterm -hold -e 'sh ./m.cmd'")
	elseif filereadable( (   '../m.cmd') )  
		execute("!xterm -hold -e 'cd ../ && sh ./m.cmd'")
	elseif filereadable( (   '../../m.cmd') )  
		execute("!xterm -hold -e 'cd ../../ && sh ./m.cmd'")
	elseif filereadable( (   '../../../m.cmd') )  
		execute("!xterm -hold -e 'cd ../../../ && sh ./m.cmd'")

	elseif filereadable( ( expand('%:r') . '.vim') )  
		" input here catches <cr> calls in keybinding
		execute('call input("")| 
		 \call input("Running script, ENTER to continue")| so %')
	elseif filereadable( ( expand('%') . '.cmd') )  
		execute("!xterm -hold -e 'sh %.cmd'")
	elseif filereadable( ( expand('%') . '.bat') )  
		execute("!xterm -hold -e 'sh %.bat'")
	elseif filereadable( ( expand('%') . '.VIM_C_S.bat') )  
		execute("!xterm -hold -e 'sh %.VIM_C_S.bat'")
	elseif expand("%:e") == "py"
		execute("!xterm -hold -e 'cd %:p:h; echo python % >> sh %.VIM_C_S.bat \n ./%.VIM_C_S.bat'")
	elseif expand("%:e") == "c"
		execute("!xterm -hold -e 'cd %:p:h; echo tcc -run %>> sh %.VIM_C_S.bat\n ./%.VIM_C_S.bat'")
	else
		execute("!xterm -hold -e 'cd %:p:h; echo REM filename: %>> sh %.VIM_C_S.bat\n'")
	endif	
endfunction

function! Vim_1_Key_Run_Compile()
	w
	if has("gui_running") && has("unix")
		call Vim_1_Key_Run_Compile_LINUX_GUI_XTERM()
		return
	endif 
	
	if filereadable( ( expand('%:r') . '.cmd') )  
		execute('!%:r.cmd')
	elseif filereadable( ( expand('%:r:r') . '.cmd') )  
		execute('!%:r:r.cmd')
	"new 4/4/2026- looking up 3 files (max) to find 'm.cmd'...  
	elseif filereadable( (   'm.cmd') )  
		if has('win32') || has('win64')
			execute('!"m.cmd"')
		else
			execute('!"./m.cmd"')
		endif
	elseif filereadable( (   '../m.cmd') )
		if has('win32') || has('win64')
			execute('! cd "../" && "m.cmd"')
		else
			execute('! cd "../" && "./m.cmd"')
		endif  	
	elseif filereadable( (   '../../m.cmd') )
		if has('win32') || has('win64')
			execute('! cd "../../" && "m.cmd"')
		else
			execute('! cd "../../" && "./m.cmd"')
		endif  
	elseif filereadable( (   '../../../m.cmd') )
		if has('win32') || has('win64')
			execute('! cd "../../../" && "m.cmd"')
		else
			execute('! cd "../../../" && "./m.cmd"')
		endif  

	elseif filereadable( ( expand('%:r') . '.vim') )  
		" input here catches <cr> calls in keybinding
		execute('call input("")| 
		 \call input("Running script, ENTER to continue")| so %')
	elseif filereadable( ( expand('%') . '.cmd') )  
		execute('!%.cmd')
	elseif filereadable( ( expand('%') . '.bat') )  
		execute('!%.bat')
	elseif filereadable( ( expand('%') . '.VIM_C_S.bat') )  
		execute('!%.VIM_C_S.bat')
	elseif expand("%:e") == "py"
		execute("!echo python % >> %.VIM_C_S.bat \n !%.VIM_C_S.bat")
	elseif expand("%:e") == "c"
		execute("!echo tcc -run %>> %.VIM_C_S.bat\n !%.VIM_C_S.bat")
	else
		execute("!echo REM filename: %>> %.VIM_C_S.bat\n!%.VIM_C_S.bat")
	endif	
endfunction

" remapping the 'esc' key to use jk or kj, because Esc sucks
imap jk <Esc> 
imap kj <Esc>

inoremap <C-S> <Esc>:call Vim_1_Key_Run_Compile() <CR><CR> i
noremap <C-S> :call Vim_1_Key_Run_Compile() <CR><CR>

"""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>

" In many terminal emulators the mouse works just fine, thus enable it.
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

if has('mouse')
  set mouse=a
endif

set nobackup
set noundofile

" reopening a file to last line edited.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" filetype plugin on
" set omnifunc=syntaxcomplete#Complete

" set completeopt+=menuone
" set completeopt+=noselect


set guifont=Consolas:h14:b

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd' 
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

""""""""""""""""""""""""""""""""""
""setting arrow key + shift select
"""""""""""""""""""""""""""""""""
set keymodel=startsel,stopsel

set selectmode+=key

"NOTE: on dos, uses CTRL ARROWS
"Don't know why, but it works
"
""""""""""""""""""""""""""""""""
"	MyMAKING LIKE WINDOWS:
"	copied from mswin.vim and paste.vim
"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let paste_cmd = {'n': ":call Paste()<CR>"}
let paste_cmd['v'] = '"-c<Esc>' . paste_cmd['n']
let paste_cmd['i'] = "\<c-\>\<c-o>\"+gP"

func! Paste()
  let ove = &ve
  set ve=all
  normal! `^
  if @+ != ''
    normal! "+gP
  endif
  let c = col(".")
  normal! i
  if col(".") < c	" compensate for i<ESC> moving the cursor left
    normal! l
  endif
  let &ve = ove
endfunc


" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

if has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y 
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>		"+gP
    map <S-Insert>		"+gP

    cmap <C-V>		<C-R>+
    cmap <S-Insert>		<C-R>+
endif

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

if 1
    exe 'inoremap <script> <C-V> <C-G>u' . paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste_cmd['v']
endif

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

if has("gui")
  " CTRL-F is the search dialog
  noremap  <expr> <C-F> has("gui_running") ? ":promptfind\<CR>" : "/"
  inoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-O>:promptfind\<CR>" : "\<C-\>\<C-O>/"
  cnoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-C>:promptfind\<CR>" : "\<C-\>\<C-O>/"

  " CTRL-H is the replace dialog,
  " but in console, it might be backspace, so don't map it there
  nnoremap <expr> <C-H> has("gui_running") ? ":promptrepl\<CR>" : "\<C-H>"
  inoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-O>:promptrepl\<CR>" : "\<C-H>"
  cnoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-C>:promptrepl\<CR>" : "\<C-H>"
endif

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""
""""   :b:MyScripts:b:"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'ctrl+c" in everything but dos, in dos just 'c' 
fu! MyInput_loop_ctrlc_break(getCodeStr2execute, getsleeptimeStrOR_blankstr)
  try
	while nr2char( getchar(1)) != 'c'
		execute "" . a:getCodeStr2execute  
		if a:getsleeptimeStrOR_blankstr != ""
			execute "sleep " . a:getsleeptimeStrOR_blankstr
		endif 
	endwhile
  " for ctrl+c
   catch /^Vim:Interrupt$/
   endtry
endfu

fu! MyMenusFuncts()
	call MyMenu_or_menuCmd( "g:MyMenus_Main", [] )
	redraw! 
endfu

"remapping MyMenuFuncts to 'df/fd' in Normal mode
map fd :call MyMenusFuncts()<CR>
map df :call MyMenusFuncts()<CR>


"BELOW FUNCTIONS ALLOW TAB COMPLETION (CUSTOM)!!!
let g:MyCustomComplete_LIST = []
fu! MyCustComplet(inStrBeforeCursor, instr, cursorPos)
   return filter(copy(g:MyCustomComplete_LIST), 
   \ 'v:val =~ "^" . a:inStrBeforeCursor') 
endfu
fu! MyCustComplet_REGEX(inStrBeforeCursor, instr, cursorPos)
   return filter(copy(g:MyCustomComplete_LIST), 
   \ 'match(v:val, a:inStrBeforeCursor) != -1')
endfu
fu! MyInput(dispTxt, initial_input, getCompleteList)
  let g:MyCustomComplete_LIST = a:getCompleteList
  return input(a:dispTxt, a:initial_input, "customlist,MyCustComplet")
endfu
fu! MyInput_REGEX(dispTxt, initial_input, getCompleteList)
  let g:MyCustomComplete_LIST = a:getCompleteList
  return input(a:dispTxt, a:initial_input, "customlist,MyCustComplet_REGEX")
endfu

" :b: menus_core :b: :b: menu_example :b: "THIS IS FOR CHEATSHEET
"run with: MyMenu_or_menuCmd( 
"		getMenuStr, getINJECTreplaceWList_Or_emptylist)
" Can run from '=' starting lines to (sometimes) return results
" <INJECT>: if second parameter (getINJECT...)!=[] AND select entry has 
"	<INJECT>, will run entry 1x per parimeter
" <INPUT> in an entry will be replaced upon selection by user input
" OTHER USE: getMenuStr can be a menu call instead of a menu 
"   EG: MyMenu_or_menuCmd("> echo '<INPUT> <INJECT>'", ['a','b'])
"=MyMenu_or_menuCmd(g:MyMenus_Main, [])
let g:menuData222 = "
\<M> systemCall;> dir  </M>
\<M> vimscriptCall;: echo '<INPUT> <INJECT>'  </M>
\<M> LoadMenu;: g:menuData222 </M> "

fu! MyMenu_or_menuCmd( getMenuStr, getINJECTreplaceWList_Or_emptylist)
	let l:l = split(MyTrim( a:getMenuStr ),  "<M>")
	let l:i_s = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for l:i in range(len(l:l)) 
	  let l:l[l:i] = l:i_s[l:i]."-". split(l:l[l:i],"</M>")[0] |endfor
	
	"clearing chars typed before (max, 10)...
	for l:i in range(10) | call getchar(0) | endfor
	if 1 < len( split(  a:getMenuStr,  "<M>"))
	  echo "\n" . join(split(join(l:l, "\n")." ", "\<CR>'"), "<CR>'")	
	  let l:gotchar = nr2char( getchar())
	  redraw! 
	  if stridx(l:i_s, l:gotchar) >= len(l:l)| return "" | endif
	  if stridx(l:i_s, l:gotchar) == -1| return "" | endif
	  let l:chose = l:l[stridx(l:i_s, l:gotchar)]
	  let l:chose = l:chose[ (1+ stridx( l:chose,";")):]
	" IF just a command, no menu tags("<M>")
	else |   let l:chose = a:getMenuStr | endif
	" handle INPUT tag HERE
	let l:chose_inputs = split(" ".l:chose." ", "<INPUT>")
	if 1 < len(l:chose_inputs) 
	  for l:i in range( len(l:chose_inputs)-1 )
	     let l:chose_inputs[l:i]= l:chose_inputs[l:i] .
\		input( "REPLACE #". string(l:i).
\		" <INPUT> IN:: \n" . l:chose . "\n with: \n")
	  endfor
	  let l:chose = MyTrim(join(l:chose_inputs, ""))
	endif
	
	"running cmds
	let l:INJ = a:getINJECTreplaceWList_Or_emptylist
	let l:retStr = ""
	if len(l:INJ) == 0 | call add(l:INJ, "") | endif
	for l:i in range(len(l:INJ)) 
	 if l:chose[0] == ":"
	     let l:output = ""
	     redraw 
	     redir => l:output 
	     execute( MyTrim(join(split(
\		" ". l:chose[1:]." ", "<INJECT>"), l:INJ[l:i])))
	     redir END
	     let l:retStr = l:retStr . l:output 
	 elseif l:chose[0] == ">"
	    let l:retStr = l:retStr . system( MyTrim(join(split(
\		" ". l:chose[1:]." ", "<INJECT>"), l:INJ[l:i]))) 
	 elseif MyTrim(l:chose)[0] == "g" 
	  if exists( MyTrim(l:chose))
	     let g:MyMenusHandler_TMPMENU = ""
	     execute 'let g:MyMenusHandler_TMPMENU = ' .MyTrim(l:chose)
	     return MyMenu_or_menuCmd(MyTrim(
\		"".g:MyMenusHandler_TMPMENU),
\		 a:getINJECTreplaceWList_Or_emptylist)
	  endif
	 endif
	 if stridx(l:chose, "<INJECT>") == -1 | break| endif
	endfor
	return l:retStr
endfu

" :b: system_cmds :b:

" do NOT run a recursive search through a large drive!!!
" **/*.txt -  recursive file search  for globStr, can add more 
" than 1 thing to search for!
" format_0vim_1path_2shell == 1 is for if using absolute
"     paths, NOT starting at current file!!!
fu! MyEverything(globStr_list, bool_asList, format_0vim_1path_2shell)
	let l:retGlob = []
	let l:sep = "/" "unix type
	if has('win32') || has('win64') | let l:sep = "\\" | endif 
	for l:j in range(len(a:globStr_list))
	  let l:glob = split(glob(a:globStr_list[l:j]), "\n")
	  for l:i in range(len(l:glob))
		if a:format_0vim_1path_2shell == 0
		  call add(l:retGlob, l:glob[l:i])
		elseif a:format_0vim_1path_2shell == 1
		  call add(l:retGlob, expand('%:p:h') .l:sep .l:glob[l:i])
		elseif a:format_0vim_1path_2shell == 2
		  call add(l:retGlob, shellescape(
\			expand('%:p:h') . l:sep . l:glob[l:i])) | endif
	    endfor
	endfor
	if a:bool_asList ==1 | return l:retGlob |endif
	return "\n".join(l:retGlob, "\n"). "\n"
endfu
" notepad (filename) OR (filename) works
fu! MyOpen( getStr, getRtrnExitLine) " RtrnExit for use with '=MyOpen('..
  "runs it as if it was a shortcut, system finds prog
  if has("win16") || has("win32") || has("win64") " Win 98+ 
    call system("start ". MyTrim(a:getStr))
  elseif has("macunix") | call system("open ". MyTrim(a:getStr))
  elseif has("unix") | call system("xdg-open ". MyTrim(a:getStr))
  endif
  if(a:getRtrnExitLine ==1)
	return "\n:q!\n"
  endif
  return 0
endfu
" notepad (filename) OR (filename) works
fu! MySysOpenCurLine() "runs it as if it was a shortcut, system finds prog
  call MyOpen( MyTrim(getline(".")), 0) 
endfu
" getSearchStr something like: "/root/Downloads/**/*CMakeLists.txt*"
fu! MySearch(getSearchStr)
 let l:MyE_start = "\n=MyOpen(\""
 let l:MyE_end = "\",1)"
 return l:MyE_start . join( MyEverything([a:getSearchStr], 1, 0), (l:MyE_end . l:MyE_start) ) . l:MyE_end "../*.txt,*.txt
endfu

fu! MyReadFileList(getList, asLinesList)
	let l:ret = []
	for l:i in a:getList | "readfile returns lines-list
\	  let l:ret =  let l:ret +readfile(a:getList[l:i)| endif
	if a:asLinesList | return l:ret |endif
	return "\n" + join( l:ret, "\n") "\n" 
endfu

":b:  OnStart command & cmd-script_creator :b:
"
let g:MyStartCmds_on =1
autocmd BufRead * call MyStartCmds_autorun()
fu! MyStartCmds_autorun()
	if g:MyStartCmds_on == 1 && MyTrim(getline(1)) == "REM #vimStartCmd"
		if index( argv(), "@vimRunOnStart") != -1
		       call RunTag("<vimStartCmd>")
		endif
	endif
endfu

fu! MyMakeCmd_post_polyglot()
  call append( line(0), split('REM #vimStartCmd
\NLINE!REM || gvim "$0" "$@" @vimRunOnStart; exit 0;
\NLINE!gvim "%0" "%@" @vimRunOnStart || exit 
\NLINE!exit
\NLINE!<vimStartCmd> let g:MyStartCmds_on = 0 
\NLINE!
\NLINE!" ----- =NO= COMMENTS IN THIS CODE, AFTER IS OK ----- "
\NLINE!" ----- -ONLY- runs on start if @vimRunOnStart cmdline param ----- "
\NLINE!" -----     (settup so can be saved as cmd/sh to auto-dothis)----- "
\NLINE!" ----- SETTUP STAND-ALONE SCRIPT: COPY vim.exe TO FILE, 
\NLINE!" -----		replace "gvim" with "vim -u _vimrc" and add
\NLINE!" -----		"_vimrc" to file with this script! 
\NLINE!" -----		(non-windows will need their own vim to run)
\NLINE!" ----- BELOW are "useful" cmds, delete unneeded! ----- "
\NLINE!"argv()[0] " vim 8.something pulls input arguments!
\NLINE!"call search(' . "'". '*goto_pagetxt' . "'.'". 'onstart' . "'" . ',"b") 
\NLINE!"execute "start"  " ----start->insert mode
\NLINE!"=MySearch("/file/**/*this.txt*") 
\NLINE!"=MyOpen("url_or_file", 1) "1 here means "return :q!" for "=" exiting! 
\NLINE!"q!   " to quit after run!
\NLINE!<vimStartCmd>
\NLINE!=RunTag("<vimStartCmd>") 
\NLINE!NLINE!NLINE!' , "NLINE!") )
endfu


" :b:Run_N_tags:b:

fu! RunTag( getTagStr)
	let l:split = split(join(getline(1,"$"),"\n"), a:getTagStr)
	if( len(l:split) < 3)
		throw "error, need more than 3 tags in doc!"
		return 
	endif
	execute( l:split[1])	
endfu

":b:MyRunLineAndPost2Line:b:
let g:tmpVar1234123112 ={'.':''} "vim 7.3, dict-entrys can change types

let g:Run_ON =0 "redefined later, here for if code reuse
function! MyRunLineAndPost2Line()
  " adding item to undo buffer, so cntrl+Z will work.
  if g:Run_ON != 1 "NOT for running all lines 
	execute "normal! i\<C-G>u\<Esc>"
  endif	
 
  " for use with MyRun_ALL_Line... (see below funct)
  let l:line = getline('.')	

  if l:line[0] != "=" && l:line[0] != ":" | return
  endif
  if l:line[0] == ":" && l:line[1] == ":"  | return
  endif

  if l:line[1] == "+" | let l:has_plus =1
	let l:line = l:line[0] . strpart(l:line,2)
  else | let l:has_plus =0
  endif
  
  let l:start_col = col('.')
  let l:start_line = line('.') 
   	
  let l:line_nxt =  getline(l:start_line +1) 
  if l:line_nxt[0] == '|' | execute("".(l:start_line +1). 'delete')
  endif
   
   let l:first_exe_ran = 0
   try	
	if l:line[0] == ":" | let l:line = '"Ok"|' . strpart(l:line,1)
	else | let l:line = strpart(l:line,1)
	endif

	execute( "let g:tmpVar1234123112['.']=" . 	l:line  )
	if string(g:tmpVar1234123112['.']) != 
\				string("RUN()_ON_RETURN_IGNORE")
  	  call append(l:start_line ,  
\		split("|" . string(g:tmpVar1234123112['.']),"\n"))
	endif
	let l:first_exe_ran = 1
   catch
      call append(l:start_line , ["|" . "FAILED"] )
   endtry
	

  if l:has_plus | call cursor(l:start_line, l:start_col )
  else  | call cursor(l:start_line, 0 )
  endif	
	
endfunction

" For running ALL lines
let g:Run_ON = 0
function! Run()
	if g:Run_ON| return "RUN()_ON_RETURN_IGNORE"
	endif
	"below is because it's needed for MyRunLineAndPost2Line 
	let l:caught = 0 | let l:tmp = {".":""}
	if exists("g:tmpVar1234123112")
		let l:tmp["."]=g:tmpVar1234123112["."]
		let l:caught = 1
	endif 
	let g:Run_ON=1	
	call MyRun_ALL_LineStartWith_EQUAL_NPost2Line()
	let g:Run_ON=0
	if l:caught | let  g:tmpVar1234123112["."] = l:tmp["."]
	endif
	return "RUN()_ON_RETURN_IGNORE"
endfunction
" Makes == lines run and post as if set to var, can do 
"  =  runs and post Ok if successful
function! MyEnterRnLineAndPostHandler()
	let l:line = getline('.')
  	if l:line[0] != "=" && l:line[0] != ":" | return "\<CR>"
  	endif
  	if l:line[0] == ":" && l:line[1] == ":"  | return "\<CR>"
  	endif
	if l:line[1] == "+"
		return "\<Esc>:call MyRunLineAndPost2Line()\<CR>a"
	endif
	if (line('.')+1) >= line('$')  
	     return "\<Esc>:call MyRunLineAndPost2Line()\<CR>j$a\<CR>"
	else
	     return "\<Esc>:call MyRunLineAndPost2Line()\<CR>jj^i"
	endif
	  return ""
endfunction
"inoremap <CR> <C-o>:call MyEnterRnLine_WRAPPER()<CR>
inoremap <expr> <CR> MyEnterRnLineAndPostHandler()

function! MyRun_ALL_LineStartWith_EQUAL_NPost2Line()
  let l:i = 0
  let l:caught_pos = getpos('.')
  while l:i <= line('$')
	let l:line =   getline(l:i) 
	if l:line[0] == '=' || l:line[0] == ":"
		 call cursor(l:i, 1) | call MyRunLineAndPost2Line()
	endif
	let l:i += 1
  endwhile
  call cursor(l:caught_pos[1],  1) 
endfunction

":b: spreasheet_functs:b:

let g:MySortTab = 0 | let g:MySortBy_boolNumb = 0
let g:MySortIdx = " 0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQr
\RsStTuUvVwWxXyYzZ"
fu! MySortTab_AbiggerNB( la, lb)
	" return a:la - a:lb - simple sort
	let l:la = split(a:la, '\t') | let l:lb = split(a:lb, '\t')
	if len( l:la) <= g:MySortTab | return -1 | endif
	if len( l:lb) <= g:MySortTab | return 1 | endif
	let l:ta = l:la[g:MySortTab] | let l:tb = l:lb[g:MySortTab]
	if g:MySortBy_boolNumb == 1
	  if has("float") | return float2nr( 
\		str2float(l:ta) - str2float(l:tb)) 
	  else | return str2nr(l:ta) - str2nr(l:tb) | endif 
	else "if string comparison
	  if stridx(g:MySortIdx, l:ta[0]) > stridx(g:MySortIdx, l:tb[0]) 
		 return 1 | else | return -1 |endif
	endif
	return 0 
endfu

fu! MySortByTab()
   redraw! 
   let l:in = split(input( "-----SORT LINES BY SELECT TAB-------
\\n\r inputs: ( '#lines2pull 1numbSort0alphabet 1reverse0none')
\  \n\r EG: '10000 1 0' OR '$ 1 0'  \n\r"), " ")
   if len(l:in) < 3 | return | endif 
   
   if l:in[0] == "$" | let l:in[0] = string(line("$") +1) |endif
   let g:MySortTab = virtcol('.')/&tabstop
   let g:MySortBy_boolNumb = str2nr(l:in[1])  

    let l:lines = getline(line('.'), line('.') +str2nr(l:in[0])-1)
    call sort(l:lines, "MySortTab_AbiggerNB")
    if l:in[2] =="1" | call reverse(l:lines) | endif
    call setline(line('.'), l:lines)
endfu

fu! MyCopyBuffRun()
	execute( "let g:tmpVar1234123112['.']=" . 	MyTrim(@+)  )
	let @+ =  string(g:tmpVar1234123112['.'])
	echohl MoreMsg | redraw
	echomsg "Result: '". @+
\		."' , saved to copy buffer! (can paste it!)"
	call getchar() | echohl None
endfu

fu! MyPullLinesWith( inPat) "pattern_ret_list_or_BLANK_interactive_ret_copbuff
	if a:inPat == ""
	  let l:cont = input(
\  "\n\rEnter txt-blocks(words) what lines must contain"
\  ."\n\r multiple searches should be separated by ||: "
\		."\n\r   (EG:search 1 || search 2)   \n\r")
	else
	  let l:cont = a:inPat
	endif
	if l:cont =="" | return []| endif
	let l:searches = split(MyTrim(l:cont), "||")
	let l:keptLines = []

	let l:l = getline(1, "$")
	let l:out = []
	for l:k in range( len(l:searches))
	 let l:cont_list = split(MyTrim(l:searches[l:k]), " ") 
	 for l:i in range( len(l:l))
	  let l:keep_line = 1
	  for l:j in range( len(l:cont_list))
		if stridx(l:l[l:i], l:cont_list[l:j]) == -1 
			let l:keep_line = 0
		endif	
	   endfor
	   if l:keep_line == 1 && index(l:keptLines, l:i) == -1 
		 call add(l:out, l:l[l:i]) | call add(l:keptLines, l:i)
	   endif
	 endfor
	endfor
	if a:inPat !="" | return l:out |endif
	
	echohl MoreMsg | redraw
	echomsg "Pulled ".len(l:out)
\		." lines, saved to copy buffer! (can paste it!)"
	call getchar() | echohl None
	let @+=join(l:out, "\n")
	let @"=join(l:out, "\n")
endfu

let g:MySumSel_clipboard_catch = {".":0} 
fu! MySumSelectedText(...)	
	normal gv
	call MySumSelectedText_CORE(visualmode(), 0)
    	silent! execute "normal! \<Esc>''"  
	let @+ = g:MySumSel_clipboard_catch['.']
	"normal gv
endfu

fu! MyAvrgSelectedText(...)	
	normal gv
	call MySumSelectedText_CORE(visualmode(), 1)
    	silent! execute "normal! \<Esc>''"  
	let @+ = g:MySumSel_clipboard_catch['.']
	"normal gv
endfu
fu! MyAvrgCol()
	call MySelect_col()
	silent! execute("normal! \<Esc>")	
	call MyAvrgSelectedText()
	let @+ = g:MySumSel_clipboard_catch['.']
endfu
fu! MySumCol()
	call MySelect_col()
	silent! execute("normal! \<Esc>")	
	call MySumSelectedText()
	let @+ = g:MySumSel_clipboard_catch['.']
endfu
""""""EDITED FROM:
" Maintainer:	GrepSuzette (https://github.com/emugel/vim-sum)
" License:	    This file is placed in the public domain.
function! MySumSelectedText_CORE(type, get_avrg_not_sum)
    let s:sel_save = &selection | let &selection = "inclusive"
    let s:saved_unnamed_register = @@
    let s:count = 0

    if !(a:type ==# '') | return
    endif
	
    normal! gvy
    match Search /\(^\|\s\|\n\)\zs\%V-\?[0-9]*[,.]\?[0-9]\+\%V[0-9]\?\ze\($\|\s\|\n\)/
    normal! `> 

    let s:idx = 0 | let s:sum = 0
    
    while s:idx != -1
        let s:pos = match(@@, '\(^\|\s\|\n\)\zs-\?[0-9]*[,.]\?[0-9]\+\ze\($\|\s\|\n\)', s:idx)
	" echomsg s:a[0] . "  " . s:a[1] . "  " . s:a[2]
        if s:pos > -1
	    let s:str_matched = matchstr(@@, '\(^\|\s\|\n\)\zs-\?[0-9]*[,.]\?[0-9]\+\ze\($\|\s\|\n\)', s:idx)
	    "checking if float enabled at compile time
            if has('float')
	    	let s:sum += str2float(substitute(s:str_matched, ',', '.', ""))
            else
		let s:sum += str2nr(substitute(s:str_matched, ',', '.', ""))
	    endif
	    let s:count +=1
		
	    let s:idx = s:pos +  len(s:str_matched) + 1
        else | break
        endif
    endwhile
	
    if a:get_avrg_not_sum == 1 | let s:sum = s:sum/s:count
    endif 
	
    "checking if float enabled at compiletime
    if has('float')
      if (floor(s:sum) == s:sum) | let s:ssum = printf("%d",float2nr(s:sum))
      else | let s:ssum = printf("%f", s:sum) 
      endif
    else | let s:ssum = printf("%d", s:sum)
    endif

    echohl MoreMsg | redraw
    if a:get_avrg_not_sum == 1
      echomsg "Avrg: " . s:ssum . 
	\ " (paste /w 'p', ':match None' to hide)"
    else
      echomsg "Sum: " . s:ssum . " (paste with 'p', ':match None' to hide)"
    endif
    call getchar() | echohl None
	
    let &selection = s:sel_save | let @@ = s:saved_unnamed_register
    let @* = s:ssum
    let g:MySumSel_clipboard_catch['.'] = s:ssum
endfunction

fu! MySelect_col(...)	
	 let l:lines_down = MyTrim(input( 
\		"\n\rNumber of lines DOWN from cur. line to get?"
\	    ."\n\r(blank = all of them)") )
	if l:lines_down == ""
		let l:lines_down  = line("$")
	else
		let l:lines_down  = str2nr(l:lines_down) + line(".") -1
	endif
	
	let l:arg_numb_in = get(a:, 0, 0) | let l:arg_1_in = get(a:, 1, 0)

	if l:arg_1_in | let l:in_get_cols_to_right = l:arg_1_in
	else | let l:in_get_cols_to_right = 1
	endif
	
	set nowrap
	set virtualedit=block
	
	" Get and jump to current col (rounded to tab pos) start
	" (using *100 and /100 because 'float' don't work in some vim
	"let l:tmp_curcol = 1+(((virtcol('.')*100) / (&tabstop *100)) *&tabstop)
	let l:tmp_curcol = (virtcol('.')/&tabstop) *&tabstop
	let l:tmp_curline = line('.')
	execute "normal! " . l:tmp_curline . "G" . l:tmp_curcol . "|"	
	
	let l:tmp_nxt_tab = (&tabstop *l:in_get_cols_to_right) 
\		+ l:tmp_curcol	
	                                                                                                   
	let l:tmpWidth = strwidth( getline(l:lines_down))
	while  l:tmpWidth < 1+l:tmp_nxt_tab 
	  let l:tmpWidth = l:tmpWidth +1 	
	  call setline(l:lines_down, getline(l:lines_down) ." ")	       
	endwhile	
	
	execute "normal! " . l:lines_down . "G" . l:tmp_nxt_tab . "|"
	execute "normal! \<C-q>" . l:tmp_curline . "G" . l:tmp_curcol . "|" 
endfu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :b: timer_drawMode_diceGame :b:               
"""""""""""""""""""""""""""""""           
fu! Draw_char(charStr, x, y) "MUST be numeric 1 and 2
	if (line('$') < a:y || a:y <0 || a:x < 1) | return -1 |endif
	let l:ln = getline(a:y) |if len(l:ln) < a:x | return -1|endif
	if a:x-2 >= 0 | let l:lineStrtStr = l:ln[0: a:x-2]
      	else | let l:lineStrtStr = "" | endif
      	call setline(  a:y, l:lineStrtStr. a:charStr[0]. l:ln[(a:x):])
endfu
fu! Draw_getChar(x,y) "MUST be numeric 1 and 2
	if (line('$') < a:y || a:y <0 || a:x-1 < 0) | return -1 |endif
	let l:ln = getline(a:y) |if len(l:ln) <= a:x-1 | return -1|endif
	return l:ln[(a:x-1)]
endfu
let g:count =0
fu! Draw_fillBucket(charStr, x, y)
	let l:start_char = Draw_getChar(a:x, a:y)
	call Draw_char(a:charStr, a:x, a:y)
	if l:start_char == -1 | return | endif
	if l:start_char == a:charStr | return|endif
	
	let l:x = a:x| let l:y= a:y| let l:list_xys = []
	call extend(l:list_xys,
\	   [[l:x+1, l:y],[l:x-1, l:y],[l:x, l:y+1],[l:x, l:y-1]])
	while len(list_xys) != 0
		let l:x = l:list_xys[0][0] | let l:y = l:list_xys[0][1] 
		call remove(list_xys, 0)	
		if Draw_getChar(l:x, l:y)!=l:start_char |continue| endif
		call Draw_char(a:charStr, l:x, l:y)
		call extend(l:list_xys,
\	   	  [[l:x+1, l:y],[l:x-1, l:y],[l:x, l:y+1],[l:x, l:y-1]])
	endwhile
endfu



let g:drawing_brush = split("a", "\n")
let g:drawing_brush_lenRange = range(len(g:drawing_brush))
let g:drawing_posPrev = [-100000,-100000,-100000,-100000]
let g:drawFill_1_Boxl_2 = 0 "for next click/movement
let g:drawEyedropper_bool = 0 "for next click/movement
fu! Draw_distBetween(a, b ) "0 is min, ints only
   if a:a == a:b | return 0 | endif
   if a:a > a:b | let l:dist= a:a- a:b| else | let l:dist= a:b- a:a |endif
   return l:dist 
endfu
fu! DrawFill_settupNxtClick()
	let g:drawFill_1_Boxl_2+=1 | let g:drawing_posPrev=getpos('.')
endfu
fu! DrawMode_Eydrp_Bckt_Box( pos) "returns 1 if did anything
  "eyedropper
  if g:drawEyedropper_bool == 1 | let g:drawEyedropper_bool = 0
    let l:a = Draw_getChar(a:pos[2], a:pos[1])
    if l:a != -1 | let g:drawing_brush = split( (l:a),"\n")  
	let g:drawing_brush_lenRange = range(len(g:drawing_brush))| endif
    return 1 | endif
	
  "one press for box, 2+ for FILL (next click
  if g:drawFill_1_Boxl_2 >1 | let g:drawFill_1_Boxl_2 = 0 
	call DrawingModeFunct( 1 ) | return 1 
  endif
  if g:drawFill_1_Boxl_2 ==1| let g:drawFill_1_Boxl_2 = 0
    call Draw_fillBucket(g:drawing_brush[0], a:pos[2], a:pos[1]) 
	return 1 | endif
  return 0
endfu 
fu! DrawingModeFunct( drawBox ) " draws boxes, AND 'smoothed' lines
  let l:pos = getpos('.') | let l:prev= g:drawing_posPrev
  let l:strk_merge=6 | let l:pos2Draw = []
 
  if a:drawBox == 1 | let l:strk_merge=10000 | endif 
  if 1 == DrawMode_Eydrp_Bckt_Box( l:pos) | return |endif 

  "early break, for if dist > limit for nearby ones
  call DrawingModeFunct_CORE( l:pos)
  if Draw_distBetween(l:prev[2], l:pos[2] ) + 
\	  Draw_distBetween(l:prev[1], l:pos[1] ) > l:strk_merge 
	let g:drawing_posPrev = l:pos |return | endif

  "setting horiz places to draw
  while 0 < Draw_distBetween(l:prev[2], l:pos[2] ) 
	  call add(l:pos2Draw, l:prev[2] )
	  if l:prev[2]<l:pos[2]| let l:prev[2]=l:prev[2]+1 
	  elseif l:prev[2]>l:pos[2] | let l:prev[2]=l:prev[2]-1 |endif
  endwhile
  call add(l:pos2Draw, l:prev[2] )
  "drawing horiz and vert
  while 0 < Draw_distBetween(l:prev[1], l:pos[1] ) 
       for l:i in range(len( l:pos2Draw ))
	 let l:prev[2] = l:pos2Draw[l:i]
	 call DrawingModeFunct_CORE( l:prev)
       endfor
     if l:prev[1]<l:pos[1]| let l:prev[1]=l:prev[1]+1 
     elseif l:prev[1]>l:pos[1] | let l:prev[1]=l:prev[1]-1 |endif
  endwhile
  "last line drawing
  for l:i in range(len( l:pos2Draw ))
	 let l:prev[2] = l:pos2Draw[l:i]
	 call DrawingModeFunct_CORE( l:prev)
   endfor
  let g:drawing_posPrev = l:pos
endfu
fu! DrawingModeFunct_CORE( getPos_2_draw) 
   let l:pos = a:getPos_2_draw 
   if 1 == DrawMode_Eydrp_Bckt_Box( l:pos) | return | endif    
   for l:i in g:drawing_brush_lenRange
      let l:len = len(g:drawing_brush[l:i]) " g:drawing_brush=strList
      let l:line = getline(l:pos[1] + l:i)
      if l:pos[2]-2 >= 0 | let l:lineStrtStr = l:line[0: l:pos[2]-2]
      else | let l:lineStrtStr = "" | endif
      call setline(  l:pos[1] + l:i, l:lineStrtStr.
\		g:drawing_brush[l:i]. l:line[l:pos[2]+l:len-1:])
    endfor
endfu

fu! DrawMode_EntrLeave()
  redraw! |let l:in = input( "\n\r(turns normal mode into draw):
\ \n\r(RETURN TO INSERT MODE FOR BETTER UNDO, can 'search & replace all' )
\ \n\r(IN DRAW MODE: shift+r to go to replace mode )
\ \n\r  ------------------INPUT TO LAUNCH DRAW MODE:----------------------
\ \n\r 'a STR_BRUSH_OR_BLANK_FOR_COPYBUFF' -Draw txt mode (ESC exits)
\ \n\r 'b STR_BRUSH_OR_BLANK_FOR_COPYBUFF' -Draw txt-smooth mode(ESC exits)
\ \n\r     press SPACE TWICE and click on a far point to box-fill
\ \n\r	   press SPACE and click for paint-fill
\ \n\r	   press TAB for eyedropper (next click)
\ \n\r 'q' nodraw mode, for use with CTRL+Q then HOLD SHIFT DRAG and COPY
\ \n\r  	(then add to brush via <esc> 'b/a' here!)
\ \n\r 'c CHAR intLength inHeight'(c - 70 30)- generate a 'canvas'
\ \n\r ''   ---- Exits/disable (just press 'enter' )
\ \n\r 'ANYTHING ELSE' -- sets brush 
\ \n\r" )
	
	if l:in == "" | 
		"disable all (resetting to factory default)
		set mouse=a
		autocmd! CursorMoved * 
		let g:drawFill_1_Boxl_2 = 0 |  let g:drawEyedropper_bool = 0
		nnoremap <Space> <Space>
		nnoremap <Esc> <Esc>
		nnoremap <Tab> <Tab>
	return| endif
	let l:in_l = split(l:in, " ")
  	if len(l:in_l) == 0 || stridx( "abcq", l:in_l[0] )==-1 | 
		" below does NOT split on new lines, not sure if fixable
		let g:drawing_brush = split( l:in, "\n")
	 return | endif

	"make canvas (input: c CHAR LENGTH HEIGHT )
	if l:in_l[0] == 'c' 
		let l:c_out = []
		for l:i in range(str2nr(l:in_l[3]))
		   call append(line('.'), repeat(l:in_l[1], 
\			str2nr(l:in_l[2]))) 
		endfor 
		call DrawMode_EntrLeave() | return
	endif	
	
	if len(l:in_l) < 2 " pulling copy buffer if no 'brush' added
		let g:drawing_brush = split("a", "\n")
		let @+=@" | let g:drawing_brush = split(@+, "\n") 
	else | let g:drawing_brush = split(l:in_l[1], "\n") | endif

	"for ALL below
	set mouse=n
	let g:drawing_brush_lenRange = range(len(g:drawing_brush))
	let g:drawing_posPrev = [-1000,-1000,-1000,-1000]
	nnoremap <Space> :call DrawFill_settupNxtClick()<CR>
	nnoremap <Tab> :let g:drawEyedropper_bool=1<CR>
	nnoremap <Esc> :call DrawMode_EntrLeave()<CR>

	"'merged' line (for fast strokes, slow could merge unwanted
	" (can draw a box by pressing space and clicking far point)
	if l:in_l[0] == "q" |  autocmd! CursorMoved * 
		 set mouse=a| endif
	if l:in_l[0] == "b"
	   autocmd! CursorMoved * call DrawingModeFunct( 0) 
	elseif l:in_l[0] == "a"
	  " unmerged line drawing
	  execute "autocmd! CursorMoved * call DrawingModeFunct_CORE(
\		getpos('.'))"
	endif
endfu


fu! MyTimer_ms2time( secs)
  return (a:secs/60) . ":" . (a:secs - (60* (a:secs/60))) 
endfu
fu! MyTimer_min_n_secs_to_millisecs( mins_n_secs )
	let l:tmp = split(" " . a:mins_n_secs . ": : ", ":")
	if (60*str2nr(l:tmp[0]))+str2nr(l:tmp[1]) <=0 | return 0 | endif
	return (60 * str2nr(l:tmp[0])) + str2nr(l:tmp[1]) 
endfu
fu! MyTimer_blocking_LOOP()
   	let g:MyTimer_last_pause[1] -=1
	let l:time = g:MyTimer_last_pause[1] 
	if l:time <=0 
	  set novisualbell | set errorbells | exe "normal \<Esc>"
	  if &titlestring[0]!='!' | let &titlestring="!!!!TIMER!!!"
	    echo "TIME! (ctrl+c, exits)"
	  else | let &titlestring="----timer---" 
	    echo "---time!--- (ctrl+c, exits)" | endif	  
	else | echo "(ctrl+c/c exits):" . MyTimer_ms2time( l:time )
	  let &titlestring = "" . MyTimer_ms2time( l:time )
	endif
	redraw 
endfu
let g:MyTimer_last_pause = [0,0]
fu! MyTimer_blocking()
	while 1
	   let &titlestring =""  | set visualbell
	   let l:in =   input( 
	   \"<CtrlC breaks/c if no gui> <ESC reverts window title> " . 
	   \"\n(use deflt clock-eggtimer in android):" . 
	   \"\n  Enter'00:00' or '00','l'=last, 'c'=continue, 'ESC':")
	   if (l:in=="c") | let l:time = g:MyTimer_last_pause[1]
	   elseif l:in == "l" | let l:time = g:MyTimer_last_pause[0]
	   else | let l:time = MyTimer_min_n_secs_to_millisecs( l:in)
	     if l:time >0 | let g:MyTimer_last_pause[0] = l:time | endif
	   endif
	   if l:time <=0 | return | endif
	   let g:MyTimer_last_pause[1] = l:time
	   call MyInput_loop_ctrlc_break("call MyTimer_blocking_LOOP()", 
		\ "1000ms")
	endwhile 
endfu


fu! MyDice_solitare( )
	let l:cash = 10 | let l:coins = 1 | let l:heads = 0
	let l:max_bet = l:cash
	let l:coins_if_win = 1 | let l:cash_to_win = 100
	while 1
		redraw!
		let l:bet = str2nr(input( "\n\rCTRL +C/-2 EXITS... \n\r   "
\		   .l:cash." : cash\n\r   " 
\		   . l:coins .":coins to flip(1 heads =win)\n\r   " 
\		   .l:coins_if_win
\		     .":market condition (if win, flip # coins nxt) \n\r"
\	    .l:max_bet. ":MAX BET: "."\n\r" 
\	    ."bet 0(blank) or more...(0 rerolls market condition): \n\r"))
		if l:bet == -2 | return | endif
		if l:bet <= 0  
			let l:coins =1 | let l:max_bet = l:cash  
			let l:coins_if_win = Roll(2,1) "3 heads, n row
			if l:coins_if_win !=2 |let l:coins_if_win=1|endif
			continue
		endif
		if l:bet >l:max_bet | let l:bet = l:max_bet |endif
		for l:i in range(l:coins)
		  let l:heads = l:heads + MyRand(2)
		endfor
		if l:heads >= 1
		  let l:cash = l:cash +l:bet
		  let l:max_bet =l:bet *2
		  let l:coins = l:coins_if_win
		  echo "\n\r\n\rGot ". l:heads . " heads! Next flips:".l:coins
\		  ."\n\r     WON : ". l:bet . " cash! \n\r"
		else
		  let l:cash = l:cash -l:bet
		  let l:coins = 1 | let l:max_bet = l:cash
		  echo "\n\r\n\rGot 0 heads! Next roll 1 heads, and"
\		  ."\n\r LOST : ". l:bet . " cash! \n\r"
		endif
		
		let l:coins_if_win = Roll(2,1) "3 heads, n row
		if l:coins_if_win !=2 |let l:coins_if_win=1|endif
		
		call input("")
		let l:heads = 0
		if l:cash <= 0 | echo "You lost... sorry!"| return| endif
		if l:cash >= l:cash_to_win | echo "You won!"| return| endif
	endwhile
endfu

" :b: Random_generation :b:               
fu! MyTrimGendStrLines()
  let l:trimStrs = input("\n\r CLEAN gen-strs?EG:|'str'->|str (y=yes)")
  let l:delc = MyTrim(input(
\   "\n\r DEL lines begin following chars:(blank==none)"))
  for l:i in reverse(range(1, len(getline(1,"$"))))
	let l:l = getline(l:i)
	if l:trimStrs == 'y' && l:l[0:1] == "|'" && l:l[-1:-1] == "'"
	  call setline(l:i, l:l[2:-2])
	elseif l:trimStrs == 'y' && l:l[0] == "|"
	  call setline(l:i, l:l[1:])
	elseif l:delc != '' && -1 != stridx(l:delc, l:l[0]) && l:l != ""
	  call setline( l:i, "")
	endif
  endfor
endfu

fu! MyTrim( str_in)
	return  substitute(a:str_in, '^\_s*\|\_s*$', '', 'g')
endfu

"vim 7 version found here: https://github.com/posva/Rndm
let g:rndm_m1 = 32007779 + (localtime()%100 - 50)
let g:rndm_m2 = 23717810 + (localtime()/86400)%100
let g:rndm_m3 = 52636370 + (localtime()/3600)%100
" NOTE returns starting at > 0 to (-1 + upperLimit)
fu! MyRand( upperLimit)
  if exists("*rand()") | return rand() % a:upperLimit | endif
  " from vimRandtag puluggin (for vim 7)
  let m4= g:rndm_m1 + g:rndm_m2 + g:rndm_m3
    if( g:rndm_m2 < 50000000 )
        let m4= m4 + 1357
    endif
    if( m4 >= 100000000 )
        let m4= m4 - 100000000
        if( m4 >= 100000000 )
            let m4= m4 - 100000000
        endif
    endif
    let g:rndm_m1 = g:rndm_m2
    let g:rndm_m2 = g:rndm_m3
    let g:rndm_m3 = m4
    return g:rndm_m3 % a:upperLimit
endfu
fu! MyRand_listDraw( getList )
	return a:getList[ MyRand( len(a:getList) ) ]
endfu 
" NOTE: ROLLS START AT 1, GO -1 FOR LIST INDEXES! 
fu! Roll( maxDiceRoll, numberOfDice)
	let l:ret = 0
	for l:i in range(a:numberOfDice)
	    let l:ret += MyRand(a:maxDiceRoll) +1	
	endfor 
	return l:ret
endfu

fu! RandDraw_data_INIT( getObj2Use)
  let a:getObj2Use["?"] = [
\	    ' "" # d4 d6 d8 d20 d100 cards !non_randomized_text '] 
		" added in below loop!
	  let a:getObj2Use["."] = [] 
	  let a:getObj2Use["#"] = range(10)
	  let a:getObj2Use["d4"] = range(1,4)
	  let a:getObj2Use["d6"] = range(1,6)
	  let a:getObj2Use["d8"] = range(1,8)
	  let a:getObj2Use["d20"] = range(1,20)
	  let a:getObj2Use["d100"] = range(1, 100)
	  let a:getObj2Use["cards"] = split(
\		"1H 2H 3H 4H 5H 6H 7H 8H 9H 10H JH QH KH AH "
\		. "1S 2S 3S 4S 5S 6S 7S 8S 9S 10S JS QS KS AS "
\		. "1C 2C 3C 4C 5C 6C 7C 8C 9C 10C JC QC KC AC "
\		. "1D 2D 3D 4D 5D 6D 7D 8D 9D 10D JD QD KD AD", " ")
  return a:getObj2Use
endfu

fu! RandDraw_LoadData(getStr, getObj2Use) " can be blank obj!
	let l:ssplit = split(a:getStr, ":d:")
	let l:ssplit_tmpStr = ""
	let l:delim = "\n"
	if len(l:ssplit) == 1
		let l:ssplit_tmpStr = l:ssplit[0]
	else
		let l:delim = MyTrim(l:ssplit[1])
		let l:ssplit_tmpStr = l:ssplit[0] . l:ssplit[2]
	endif
	let l:ssplit = split(l:ssplit_tmpStr, ":g:" )
	
	for l:i in range( len(l:ssplit) )
		let l:ssplit[ l:i ] = MyTrim( l:ssplit[ l:i ] )
	endfor    "  whitespace trimmed	

	" setting up obj, if originally blank
	if 0 == has_key( a:getObj2Use, "?")
	 	call RandDraw_data_INIT( a:getObj2Use)
	endif	
	
	call extend( a:getObj2Use["."], split( l:ssplit[0], l:delim ))
	" default
	" help function, lists 'group1 group2' etc. 
	" only 1 item, so it will ALWAYS draw/disp it!	

	for l:i in range( len(l:ssplit) )
	       "binary list, [name, data, name, data, etc] 
		if l:i % 2 == 0  "so I want it to run on odd #s only!
			continue
		endif
		if 0 == has_key( a:getObj2Use,  l:ssplit[ l:i ])
			 let a:getObj2Use[ l:ssplit[ l:i ] ] = []
		endif
		call extend( a:getObj2Use[ l:ssplit[ l:i ] ],
\			split(l:ssplit[ l:i + 1 ], l:delim))
		let a:getObj2Use["?"][0]=
\			a:getObj2Use["?"][0]." ".l:ssplit[l:i]
	endfor

	return a:getObj2Use
endfu


let g:RandDraw_SAVED_STRUCT = RandDraw_data_INIT( {} )
fu! RandDraw_dataFrom( int_copyBuff_0_dirNNestedFiles_1_openFile_2 )
	redraw!
	echo "
\\n\r  -------------------------------
\\n\r --------------EXAMPLE DATA IN COPY-PASTE BUFFER:
\\n\r (non-group whitespace is trimmed, so tabs/new lines OK!)
\\n\r BASIC: 
\\n\r      new-line-separated text, divided by lines
\\n\r ADVANCED:
\\n\r 	    (group data 0 (group_name is '') )
\\n\r    :d:  DELIMITER_OPTIONAL_DEFAULT='\\n' :d: 
\\n\r	     (NOTE: DELIMITER IS REGEX: use '\.', NOT '.')
\\n\r    :g:   GROUP_NAME1__OPTIONAL :g:
\\n\r        (group data 1)
\\n\r  etc. (other groups named like group 1!)
\\n\r  
\ "
	if a:int_copyBuff_0_dirNNestedFiles_1_openFile_2 == 0
	  let l:getData = input( "
\\n\r  ACCESSING FROM: COPY/PASTE BUFFER
\\n\r	press 'a'ENTER to pull and process data from copy buffer!
\ " )
	  if l:getData == "a"
	    let g:RandDraw_SAVED_STRUCT = {}
	    let g:RandDraw_SAVED_STRUCT = RandDraw_LoadData(@+,
\		g:RandDraw_SAVED_STRUCT )
	 endif
      elseif a:int_copyBuff_0_dirNNestedFiles_1_openFile_2 ==1
          let l:getData = input( "
\\n\r  ACCESSING FROM: ALL NESTED FILES IN DIR
\\n\r 	  WARNING: this will SAVE and CLEAR UNDO of CURRENT FILE
\\n\r	press 'b'ENTER to CONFIRM & pull and process data from files!
\ " )
	  if l:getData == "b"
	    let g:RandDraw_SAVED_STRUCT = {}
	     MyRecursive_RunOnAllFiles( 
\		 "let g:RandDraw_SAVED_STRUCT = 
\			RandDraw_LoadData( join(getline(1,'$'),'\n'),
\		    g:RandDraw_SAVED_STRUCT)",    [] )
	 endif
      else " int_copyBuff_0_dirNNestedFiles_1_samePage_2 ==2
          let l:getData = input( "
\\n\r  ACCESSING FROM: OPEN FILE
\\n\r	press 'c' ENTER to CONFIRM & pull and process data from files!
\ " )
	  if l:getData == "c"
	    let g:RandDraw_SAVED_STRUCT = {}
	    let g:RandDraw_SAVED_STRUCT = RandDraw_LoadData(
\		join(getline(1,'$'), "\n" ),
\		g:RandDraw_SAVED_STRUCT )
	 endif
      endif
endfu

fu! RandDraw( group_list,  numb2draw,  splitNreCombineByOrBlank)
" group_list_join_one_after_another_PER_ITEM__can_be_one_item!,
  let l:o=RandDraw_2dList(
\	a:group_list, a:numb2draw, a:splitNreCombineByOrBlank)
  for l:i in range(len(l:o))| let l:o[l:i] = join( l:o[l:i], "") |endfor
	return l:o
endfu
fu! RandDraw_2dList( group_list,  numb2draw,  splitNreCombineByOrBlank)
" group_list_join_one_after_another_PER_ITEM__can_be_one_item!,
	let l:out= []
	for l:i in range( a:numb2draw) | call add(l:out, []) | endfor
	for l:i in range( len(a:group_list))
	   let l:tmp = RandDraw_CORE( a:group_list[l:i], 
\		a:numb2draw,  a:splitNreCombineByOrBlank )
	   for l:j in range(len(l:out))
		call add(l:out[l:j], l:tmp[l:j])
	   endfor
	endfor
	return l:out
endfu
fu! RandDraw_CORE( MyRandDraw_SAVED_STRUCT__GROUP, 
\  number2draw,  splitNreCombineBy_or_blankstr )
	let l:out = []
	if a:MyRandDraw_SAVED_STRUCT__GROUP[0] == "!"
	  for l:i in range(a:number2draw)
		call add(l:out, a:MyRandDraw_SAVED_STRUCT__GROUP[1:])
	  endfor
	  return l:out 
	endif
	let l:group = g:RandDraw_SAVED_STRUCT[ 
\		a:MyRandDraw_SAVED_STRUCT__GROUP]
	""""""""""""""""""""simple draw if splitNComb == ""	
	if a:splitNreCombineBy_or_blankstr == ""
	  for l:i in range(a:number2draw)
	    call add(l:out, MyRand_listDraw(l:group))
	  endfor
	  return l:out
	endif
	""""""""""""""""""" recombine-n-draw
	let l:splitNcomb =  a:splitNreCombineBy_or_blankstr
	let l:newL= []
	for l:i in range(len(l:group))
		if stridx(l:group[l:i], l:splitNcomb) != -1
		   if 1 < len(split( l:group[l:i], l:splitNcomb))
			call add( l:newL, l:group[l:i] )
	endif | endif | endfor
	for l:i in range(a:number2draw)
	   call add(l:out,
\	    split(MyRand_listDraw(l:newL), l:splitNcomb)[0] .
\		l:splitNcomb .
\	    join(split(MyRand_listDraw(l:newL), l:splitNcomb)[1:],
\		l:splitNcomb) )
	endfor
	return l:out
endfu


" :b:fold_n_bookmark:b:
let g:MyIndent_ON = 0
fu! MyIndentFoldToggle()
	set foldmethod=indent 
	if g:MyIndent_ON == 0
		let g:MyIndent_ON = 1 | set foldenable	
	else 
		let g:MyIndent_ON = 0 | set nofoldenable
	endif

endfu

fu! MyTagCORE(getTagsStr, str_sum_count_list_or_avrg) "open doc
	let l:docLines = getline(1,'$')
	for l:i in range(len(l:docLines))
	   if stridx("=|:", l:docLines[l:i][0]) !=-1
		let l:docLines[l:i] = ""
	   endif
	endfor
	let l:list = MyGetTxtBtweenTags(join(l:docLines,"\n"), 
\		split(MyTrim(a:getTagsStr)," "))
	if a:str_sum_count_list_or_avrg == "count"
		return len(l:list)
	endif
	if a:str_sum_count_list_or_avrg == "list" |return l:list |endif
	if has('float')
		let l:sum = 0.0
		for l:i in range(len(l:list))
			let l:sum += str2float(l:list[l:i])
		endfor
	else
		let l:sum = 0
		for l:i in range(len(l:list))
			let l:sum += str2nr(l:list[l:i])
		endfor
	endif
	if a:str_sum_count_list_or_avrg == "avrg"
		return l:sum/len(l:list)
	endif
	" a:str_sum_count_list_or_avrg == "sum"
	return l:sum
endfu

" :b:TagAvrgSumCount_Doc :b:
" NEXT FEW (8?) FUNCTS  WILL -NOT- PULL =/:/| STARTING LINES!!!
" (So can run from equals statements without pull tag there)
" INPUT: string, tag list space separated 
" 	(see menu->spread..->space_btwn_tags for example/to test) 
fu! TagList(getTagsStr) "open doc, won't pull :,|,= starting lines
	return MyTagCORE(a:getTagsStr, "list")
endfu
fu! TagAvrg(getTagsStr) "open doc, won't pull :,|,= starting lines
	return MyTagCORE(a:getTagsStr, "avrg")
endfu
fu! TagCount(getTagsStr) "open doc, won't pull :,|,= starting lines
	return MyTagCORE(a:getTagsStr, "count")
endfu
fu! TagSum(getTagsStr) "open doc, won't pull :,|,= starting lines
	return MyTagCORE(a:getTagsStr, "sum")
endfu
fu! TagMax(getTagsStr) "open doc, won't pull :,|,= starting lines
	let l:m = TagNumbList(a:getTagsStr) |let l:max = l:m[0] 
	for l:i in range(len(l:m)) 
	  if l:m[l:i] > l:max | let l:max = l:m[l:i] |endif
	endfor
	return l:max
endfu
fu! TagMin(getTagsStr) "open doc, won't pull :,|,= starting lines
	let l:m = TagNumbList(a:getTagsStr) |let l:min = l:m[0] 
	for l:i in range(len(l:m)) 
	  if l:m[l:i] < l:min | let l:min = l:m[l:i] |endif
	endfor
	return l:min
endfu
fu! TagNumbList(getTagsStr) "open doc, won't pull :,|,= starting lines
	let l:l = MyTagCORE(a:getTagsStr, "list")
	for l:i in range(len(l:l))
		if has('float')
			let l:l[l:i] = str2float(l:l[l:i])
		else
			let l:l[l:i] = str2nr(l:l[l:i])
		endif 
	endfor	
	return l:l
endfu
fu! TagStockProjection( cash, trades, tradePrecentOfCash,
\ prcntMulti4_1trade) " all precents are in decimal, 1.0= 100%
"prcntMulti4_1trade > 1.0 will gain, (so 1.05 would be 5% gain/trade)
"THIS IS AN ESTIMATE: high trade%s_of_cash cripple on losses
	let l:out = a:cash
	for l:i in range(a:trades)
		let l:tradeBet = l:out * a:tradePrecentOfCash
		let l:out = l:out - l:tradeBet + 
\			(l:tradeBet * a:prcntMulti4_1trade)
	endfor
	return l:out
endfu

fu! MyTagTSVCols()
	let l:inp = input("input tag to format collumns (WHOLE DOC)")
	if l:inp == ""| return | endif
	let l:l = getline(1,'$')
	call add(l:l, "") | call insert(l:l, "") "offset l:i 1st line
	
	for l:i in range(len(l:l))
		if l:l[l:i] == "" | continue| endif
		let l:line = split(l:l[l:i], "\t")
		let l:outLine = ""
		for l:j in range(len(l:line))
		  let l:outLine = l:outLine . l:inp . l:j. 
\			" ".l:line[l:j]." ".  l:inp . l:j . " "
		endfor
		call setline(l:i, outLine)
	endfor
endfu

fu! MyList2dToTSV( list2d, str_remove_chars_inStrFromTSV)
  let l:str = "\n" | let l:s = &tabstop-2
  for l:j in range(len(a:list2d))
	let l:list = a:list2d[l:j]
	for l:i in range(len(l:list))
	  let l:str = l:str . 
\		join(split(string(l:list[i]),"'"),"")[0:l:s] ."\t"
	endfor 
	let l:str = l:str . "\n"
   endfor
   for l:i in range(len(a:str_remove_chars_inStrFromTSV))
    let l:str = join(split(l:str,a:str_remove_chars_inStrFromTSV[l:i]),"")
   endfor
   return l:str
endfu
fu! TagStockTrades( getListGroupsTags, getTagPrcntWin, 
\	getTagPrcentLoss, getListTagsDayWins_Loss)
" EVERYTHING IN ABOVE IS IN %(decimal) CHANGE!!!
" I think allWin/loss == win/loss ratio == price_change/trade 
"	(what avrg precent diff to bet each trade will make)
" EG: =TagStockTrades(["#"."JAN"], "WIN %", "LOSS %",
"			["WIN DAYS", "LOSS DAYS"])
" DATA_EG:(1 entry, can add btween JAN #JAN WIN % 1.12 % DAYS 3 DAYS WIN   
"		LOSE % 0.12 % DAYS 4 DAYS LOSE #JAN 
"	HARD CODED FOR MONTHS/MAIN GROUPS TO START WITH '#'/'!'/'$'
" OK, this is VERY specifically for my stock trading, a generic 
"	version is TagCompare2 (below) doesn't produce TSV, tho.
 set nowrap   
 let l:l2d =[["Month", "Trades", "Win%", "win/loss", 
\   "AvrgWin", "AvrgLoss", "MaxWin", "MaxLoss","AvWnDays","AvLsDays"]]
 
 for l:g in range(len( a:getListGroupsTags ))
   let l:t = "" | let l:d_list = copy(a:getListTagsDayWins_Loss)
   while len(l:d_list)<2 | call add(l:d_list, "-")  |endwhile
   let l:t = MyTrim(a:getListGroupsTags[l:g]) . " "
 
   for l:i in range(len(l:d_list))
	let l:d_list[l:i]  = l:t . l:d_list[l:i]
   endfor
   "adding row of generated 2d list
   call add( l:l2d, TagCompare2( l:t . a:getTagPrcntWin, 
\	l:t . a:getTagPrcentLoss, l:d_list, 0 )[1]) 
  endfor
  return MyList2dToTSV( l:l2d, "#$@!")
endfu

"returns 2d list, or TSV (tsv is easy to view)
fu! TagCompare2( getTagStrA, getTagStrB, c_ListExtra_tags_2_indv_avrg,
\		rtrnTSV_NOT_2dList) 
	" For number-lists!!! (ALL tags below!)
	let l:o = [["TagA","","","","","","",""],
\		   [a:getTagStrA,"-","-","-","-","-","-","-"]]
	let l:o[0][4]='avrgA' | let l:o[1][4] =TagAvrg(a:getTagStrA)
	let l:o[0][5]='avrgB' | let l:o[1][5] =TagAvrg(a:getTagStrB)
	let l:ac = TagCount(a:getTagStrA)|let l:bc =TagCount(a:getTagStrB)
	let l:o[0][1]='Count' | let l:o[1][1] =l:ac + l:bc
	let l:o[0][6]='MaxA' | let l:o[0][7]='MaxB'
	if l:ac !=0 | let l:o[1][6] = TagMax(a:getTagStrA) |endif
	if l:bc !=0 | let l:o[1][7] = TagMax(a:getTagStrB) |endif
	
	let l:o[0][2]='CountA%' | let l:o[0][3]='SumA/B'
	if l:ac !=0 && l:bc !=0 
		if has("float")
		 let l:o[1][2]=(0.0+l:ac)/(l:ac + l:bc) 
		else | let l:o[1][2] = l:ac/l:bc
		endif
		let l:o[1][3] = 
\		  (TagSum(a:getTagStrA)/TagSum(a:getTagStrB))
	endif
	for l:i in range(len( a:c_ListExtra_tags_2_indv_avrg ))
	 call add( l:o[0], 'C'.l:i.'avrg')
	 call add(l:o[1],TagAvrg(a:c_ListExtra_tags_2_indv_avrg[l:i]))
	endfor
	if a:rtrnTSV_NOT_2dList == 1
		return MyList2dToTSV( l:o, "#$@!")
	endif
	return l:o
endfu

fu! MyGetTxtBtweentags_curDoc()
	redraw!
	let l:tags = input(
\	"\n\rInput tags space separated(get text between every-other tag"
\	 . "\n\r in cur-open-doc between, like HTML. )"
\	 ."\n\r  (FOR =TagAvrg/TagSum/TagCount('# @'), see cheatsheets)"
\	 ."\n\r EG: TAG:'# @' TXT_IN_DOC:'# @1@  @2@ # @3@' -> '1 2'\n\r")
	if l:tags == "" | return | endif
	let l:joinTagsBy = input("\n\rJoin tags by: \n\r")
	
	let l:out = MyGetTxtBtweenTags(join(getline(1,'$'),"\n"),
\		split(MyTrim(l:tags), " ") )
	echohl MoreMsg | redraw
	echomsg "Pulled ".len(l:out)
\	  ." txt between tags, saved to copy buffer! (can paste it!)"
	call getchar() | echohl None
	let @+=join(l:out, l:joinTagsBy)
	let @"=join(l:out, l:joinTagsBy)
endfu
fu! MyGetTxtBtweenTags(getTxt, getTags_nested_list)
	let l:txt = a:getTxt | let l:retList = []
	for l:j in range(len(a:getTags_nested_list))
		let l:split = split(" ".l:txt." ", 
\			a:getTags_nested_list[l:j])
		let l:retList = []
		for l:i in range( len( l:split ) )
			if l:i % 2 == 0 | continue | endif
			call add( l:retList, l:split[l:i])
		endfor
		let l:txt = join(l:retList, " ")
	endfor
	return l:retList
endfu
fu! MyRecursive_findTxtBetweenTag_N_files(  
\		getTags_nested_list, getSuffixList_blanklist_for_ALL )
	let g:tmpstr_1235253535 =""
	let g:tmptag_1235253535 =a:getTags_nested_list
	call MyRecursive_RunOnAllFiles( 
\	  "let g:tmpstr_1235253535 = g:tmpstr_1235253535 .
\	    join(MyGetTxtBtweenTags(join(getline(1,'$'), '\n'), 
\	      g:tmptag_1235253535  ), '\n\n') ", 
\		a:getSuffixList_blanklist_for_ALL )
	return g:tmpstr_1235253535
endfu  

" THIS KILLS UNDO BUFFER, AND SAVES FILE!!!
fu! MyRecursive_RunOnAllFiles( getStr_ExecutableOneLiner, 
\		getSuffixList_blanklist_for_ALL ) " eg: [".js", ".txt"]
	w | let l:curFile = expand("%")
	if 0 == len(a:getSuffixList_blanklist_for_ALL)
	   execute( 'args **/*')
	else
	   for l:i in range(len(a:getSuffixList_blanklist_for_ALL))
		execute( 'argadd **/*'. 
\			a:getSuffixList_blanklist_for_ALL[l:i] )
	   endfor
	endif
	argdo execute a:getStr_ExecutableOneLiner
	execute( "b " . l:curFile )
	argdelete *
endfu

fu! MyRand_wordsSetText()
 let l:buffer = @+
 if( "y" == input("Setting copy/paste buffer to data ('y' to confirm)") )
 	let l:buffer = split(l:buffer, ":t:")
	for l:i in len(l:buffer)
		let l:buffer[l:i] = MyTrim( l:buffer[l:i] )
	endfor	
 endif	
endfu
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""":b:C_CHEATSHEET:b:""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #include "file"	searches local file first
" #include <file>	searches system files(compiler) first
" ----------------------------------
" -----------------STRUCTS/ARRAYS DECLARATIONS----------
" --------------------------------
" struct { int a; double b;} structVar; 
"   structVar.a = (int)structVar.b;
" int arr2d[10][10];  char stringvar[100];
" -----------------------------
" -----------------POINTERS INTEGERS/LIST--------
" --------------------------------
"  int *pointer_to_integer; 
"  int integer =2;
"  pointer_to_integer = &integer;
"  int integer_list[100];
"  pointer_to_integer = integer_list;
"	//pointing to first list element
"  pointer_to_integer[0] += 1; 
"	//setting pointed-to array-var to a value
"	// I think number in brackets is relative 2 pointer
"  pointer_to_integer += 1;
"	//advancing pointer by 1 place, at [1]
"  --------------------------
"  --------------------POINTERS STRUCT:------------
" --------------------------------
"  struct { int a; int b;} struct1;
"  struct struct1 *pointer_to_struct1;
"  pointer_to_struct1 = (struct struct1*)malloc(sizeof(struct struct1));;
"  pointer_to_struct1->a =1;
"  free( pointer_to_struct1 );
" ---------------------------
" ------------------VAR/FUNCT PREFIX:----------
" --------------------------------
" extern int a; // can used outside of file(?)
" static int a; // used inside of file(?)
" ---------------------------------------
" ----------- I/O (#include <stdio.h>)-------------
" ---------------THIS IS COMPLEX, HERE IS AN EXAMPLE:
" --------------(I removed many, many functions (sscanf, sprintf,etc)
" char scan_in[5]; int i;
" printf("please type in a 4 character filename, and a number");
" scanf("%4s %i", scan_in, &i);
" FILE *f = fopen(scan_in, "w"); //can be "r" for "read, "w" write!
" if(f==NULL){ 
"	printf("no file found, throwing error\n" );
" 	return 1; } //error
" char large_str[2000];
" sprintf(large_str,"%s %i",scan_in, i); 
" int i=0;
" while( large_str[i] != '\0'){
"	fputc( large_str[i], f);}
" fclose(f);
" FILE *f_read = fopen(scan_in, "r"); 
" i=0;  char tmp_c;
" char readStr[2000];
" tmp_c = fgetc(f_read);
" while( tmp_c != EOF){
"	readStr[i] = tmp_c;
"	i+=1;
"	tmp_c = fgetc(f_read); }
" readStr[i] = '\0';
" printf("\n will close once 'ENTER' is pressed:");
" while(getchar(c) != 'c'){ }
" return 0; //no error
"------------------------------------
"--------------------PRINTF FORMATS------------
"--------------------------------------
" %s - str, %12s -s Max chars, %i-int, %c-char, %f-float (cast double?
"--------------------------------------
" -------------------MEMORY (%include <stdlib.h>)
"--------------------------------------
" (t*)malloc(sizeof(t))        free(p)
"--------------------------------------
" -------------------MATH (#include <math.h>, compiler option -lm)
"--------------------------------------
" (THESE TAKE 'double' DATA TYPE, TYPICALLY, DEGREES IN RADIANS)
" sin(a), cos(a), tan(a), asine(y),acos(x), atan(r), atan2(y,x)
" sqrt(x), log(x), exp(p), pow(x,y), ceil(x), floor(x)
" -----------MATH IN DIFFLIB(#include <stdlib.h>)(compiler option -lm)
" abs(x), random(), srandom(seed)
"--------------------------------------
" -------------------STRINGS (#include <string.h>)
"--------------------------------------
" strlen(s_to_\0), 
" strcpy(too,from), strncpy(too,from,at_most_chars), stpcpy(too,from), 
" strcmp(string, compare_with_this_ret_index__0=equal)
" strncmp(string, compare_with_this_ret_index__0=equal, 
"	max_chars_to_check)
"--------------------------------------
" ----------------------COMPILING:
"--------------------------------------
" tcc "program.c" -lm  
" gcc -o "program_out" "program.c" -lm
""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""":b:C_MINIMALPROGRAM:b:"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""
" #include <stdio.h>
" #include <stdlib.h>
" int main(int numb_of_inputs_plus_1, char* inputs_list_0_is_fileName){
"	printf(" %s\n", inputs_first_is_fileName[0]);
"	int i; char str1[200];
"	scanf("%100s %i", str1, &i);
"       return 0;}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""":b:JS2VIM_CHEATSHEET:b:""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""modified form w0rp's 'Vim Script for the JavaScripter'"
"
" BELOW IS FOR -LARGE- FILE-LISTS. 
" 	FOR SMALLER, USE STUFF IN THE FILE/SYS 'fd' MENU!!!
" recursive run terminal cmd on all files vim (/w full filename):
"     MyRecursive_RunOnAllFiles("!echo ". shellescape(expand("%:p")) )
" recursive find and replace in vim:
"     args **/* | argdo %s\Vsearch_string/replace_string/g | update
" recursive 'api-get' style tag fetcher from files
"     let @+ =MyRecursive_findTxtBetweenTag_N_files(
"	    [getTags], getSuffixList_blanklist_for_ALL )
"
" JS 		 	Vim 
" prompt("")		call input("");
" if(){}else if(){}...  elseif 
"
" o[i] != undefined	has_key(o)
" str.length 		len(str)
" str[i] 			str[i]
" str[str.length - i] 	str[-i]
" str.slice(i) 		str[i:]
" str.slice(start, end) 	str[start : end - 1]
" str.slice(start, -1) 	str[start : -2]
" str.slice(-2, -1) 	str[-2 : -2]
" str + x 		str . x
" str.indexOf(x) 		stridx(str, x)
" str.lastIndexOf(x) 	strridx(str, x
" str.trim() 		No direct equivalent
" Math.pow(x, y)		pow(x, y)
" Math.ceil(x) 		ceil(x)
" Math.floor(x) 		floor(x)
" Math.trunc(x) 		trunc(x)
" Math.sqrt(x) 		sqrt(x)
" Math.exp(x) 		exp(x)
" Math.log(x) 		log(x)
" Math.log10(x) 		log10(x)
" Math.log2(x) 		log(x) / log(2)
" Math.abs(x) 		abs(x)
" Math.acos(x) 		acos(x)
" Math.asin(x) 		asin(x)
" Math.atan(x) 		atan(x)
" Math.atan2(x, y) 	atan2(x, y)
" Math.cos(x) 		cos(x)
" Math.tan(x) 		tan(x)
" list.length 		len(list)
" list[i] 		get(list, i)
" list[list.length - i] 	get(list, -i)
" No equivalent 		list[i]
" No equivalent 		list[-i]
" list.slice(start, end) 	list[start : end - 1]
" list.slice(start, -1) 	list[start : -2]
" list.slice(0, 1) 	list[0 : 0]
" list.concat(x) 		list + x
" list.push(x) 		add(list, x)
" list.push(...x) 	extend(list, x)
" list.unshift(x) 	insert(list, x)
" list.splice(i, 0, x) 	insert(list, i, x)
" list.splice(i, 2) 	remove(list, i, i + 1)
" list.pop() 		remove(list, -1)
" list.indexOf(x, i) 	index(list, x, i)
" list.join(x) 		join(list, x)
" list.reverse() 		reverse(list)
" list.sort() 		sort(list)
" list.sort(CmpFunc) 	sort(list, CmpFunc)
" obj.xyz = value 	let obj.xyz = value
" obj[key] 		get(obj, key)
" No equivalent 		obj[key]
" obj[key] = value 	let obj[key] = value
" delete obj1[key] 	call remove(obj1, key)
" Object.keys(obj) 	keys(obj)
" Object.values(obj) 	values(obj)
" isNaN(not_a_number) 	isnan(not_a_number)
" 
" TYPE CONVERSION VIM:
" str2nr(x) str2float(x) float2nr(x), 
" float2nr(ceil(x)), float2nr(floor(x))
" floor(x) string(x)
" 
" TYPE CONVERSION JAVASCRIPT:
" ""+var, parseInt(str), parseFloat(str), JSON.parse(obj)
" JSON.stringify(str, null_OPTIONAL, int_indent_OPTIONAL), 
" TYPES:
" JS 'typeof var'		vim 'type(var)'
" "object" 		v:t_dict
" "number"		v:t_float
" "number"		v:t_number
" "string" 		v:t_string
" "undefined"		---
" 
" Vim var scope (always include):
" g:x 	x in the global scope.
" l:x 	x in the local scope.(in functions)
" a:x 	Function argument x (inputs). Read-only.
" v:x 	A read-only special Vim variable x.
" 
" ERRORS:
" JS:			vim:
" try {			try
" }			    echo "Try"
" catch(err) {		catch
" }  			    echo "Caught it"
"			 endtry
""""""""""""""""""""""""""""""""""""""""""
""""""""" :b:JS_HTML_MINIMAL_FILE:b:"""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""
" <html><body>
" <textarea id="links" rows="30" cols="100" > </textarea>
" <br><button onclick="buttonFunct()">button </button>
" <script>
" function buttonFunct(){};
" document.addEventListener("keydown", function(e){
"	document.getElementById("links").value.trim();
"	var KEYCODES = {right:39, down:40, left:37, up:38};
"	if (e.keyCode == KEYCODES.right) { //linking
"		window.location.href = "www.google.com"; }
"	if (e.key == "c"){  var c = prompt( "pressed c";} }
" </script></body></html>
""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
":b: MySpeedRead :b:
function! MySpeedRead() "written mostly by GROK 3.0
  let l:wpm = str2nr( input("type wpm-ish (~500), ctrl+c exits:"))
  let l:ms_per_word = float2nr(60000.0 / l:wpm)  
  let l:screen_width = &columns 
  while 1
    let l:curr_pos = getpos('.')  
    silent! normal! w  
    redraw
    if l:curr_pos == getpos('.')  
      break
    endif
    let l:word = expand('<cWORD>')  
    let l:padding = repeat(' ', (l:screen_width - strlen(l:word)) / 2)
    echon l:padding . l:word
    redraw
    execute 'sleep ' . l:ms_per_word . 'm'  
  endwhile
endfunction
" :b: vim MyReplaceUdrCrsr :b:
" GROK made core code, Gemini refined 
function! MyReplaceUdrCrsr()
	let l:curline = line('.')
	let l:line = getline('.')
	let l:col  = col('.') " 1-based index
	redraw
	echo  " 
\ \n\r---------EXCEL REPLACE WORD UNDER CURSOR(finicky, same type ONLY)
\ \n\r -SINGLE WORD, NUMBERS, SINGLE/DOUBLE QUOTED (input with quotes): "
	let l:in = input("> ")
	if len(l:in) == 0 | return | endif
	" 1. DETERMINE PATTERN (default-word)
	let l:pattern = '[A-Za-z0-9_.-]\+' 
	"1. DETERMINE PATTERN (default-word) Number detect
	if l:in =~# '^\s*[-+]\?\d\+\(\.\d\+\)\?\([eE][-+]\?\d\+\)\?\s*$'
		let l:pattern ='[-+]\?\d\+\(\.\d\+\)\?\([eE][-+]\?\d\+\)\?'
	" Quote detect (Fixed regex)
	elseif l:in[0] == '"' || l:in[0] == "'"
		let l:q = l:in[0]
		let l:pattern = l:q . '[^' . l:q . ']*' . l:q
	endif
	" 2. FIND WHICH MATCH ENCOMPASSES THE CURSOR
	let l:start = -1
	let l:end = -1
	let l:search_pos = 0
	" Loop through all matches in the line
	while 1
		let l:s = match(l:line, l:pattern, l:search_pos)
		if l:s == -1 | break | endif
		let l:e = matchend(l:line, l:pattern, l:search_pos)
		
		" If cursor (l:col) is between start and end (1-based vs 0-based check)
		if (l:col > l:s) && (l:col <= l:e)
			let l:start = l:s
			let l:end = l:e
			break
		endif
		let l:search_pos = l:e
	endwhile
	"3. FALLBACK: replace word, or failing replace character
	if l:start == -1
		let l:wordpattern = '[A-Za-z0-9_.-]\+' 
		let l:start = match(l:line, l:wordpattern . '\%' . (l:col + 1) . 'c')
		if l:start == -1
            	let l:start = match(l:line, l:wordpattern . '\%' . (l:col + 2) . 'c')
        	endif
		let l:end = -1
		if l:start != -1
			let l:end = matchend(l:line, l:wordpattern, l:start)
		endif
		if  l:start == -1 || l:end == -1
			let l:start = l:col - 1
			let l:end = l:col
		endif
	endif
	" 4. APPLY
	let l:newline = strpart(l:line, 0, l:start) . l:in . strpart(l:line, l:end)
	call setline(l:curline, l:newline)
	" Move cursor to the end of the new word
	call cursor(l:curline, l:start + strlen(l:in))
endfunction

":b: MyMenus :b:

let g:MyMenuCheatSheets = join(split( "
\<M> ---IN LINUX,TO SAVE VIMRC- in bash==cd $HOME---vim .vimrc ;:  </M> 
\<M> vimRC (all cheatsheets are here+vimcode)  ;:view $MYVIMRC  </M> 
\<M> JS2Vim      ;
\:view $MYVIMRC | execute 'normal! /JS2VIM_CHEATSHEE++T\<CR>'</M> 
\<M> Vim menu eg:;
\:view $MYVIMRC | execute 'normal! /menu_exampl++e\<CR>'</M> 
\<M> C           ;
\:view $MYVIMRC | execute 'normal! /C_CHEATSHEE++T\<CR>'</M> 
\<M> C  prog     ;
\:view $MYVIMRC | execute 'normal! /C_MINIMALPROGRA++M\<CR>'</M> 
\<M> HTML/JS eg: ;
\:view $MYVIMRC | execute 'normal! /JS_HTML_MINIMAL_FIL++E\<CR>'</M> 
\", "++"), '' )

let g:MyMenuBookmarks_BASE= "
\<M>Fold/Unfold by indent ;:call MyIndentFoldToggle()  </M> 
\<M>Code cheatsheets      ; g:MyMenuCheatSheets </M> 
\<M>Scan/Rescan doc for bookmarks? \n\r
\    (FORMAT= :b:BOOKMARK_NAME:b: );:call MyBookmarks_scan()  </M> "
let g:MyMenuBookmarks = "" . MyMenuBookmarks_BASE
fu! MyBookmarks_scan( )
	let l:start_end = split(input(
\	 "\n please type in start/end tags (tests per line), space divided
\\n\r	  (eg:'function (')   BLANK defaults to ':b: :b:'"), ' ')
	if len(l:start_end) < 2
		let l:start_end = [":b:", ":b:"]
	endif
	let g:MyMenuBookmarks = g:MyMenuBookmarks_BASE
	let l:doc_lines = getline(1, "$")
	for l:i in range(len(l:doc_lines))
		let l:mark = split(" ". l:doc_lines[l:i], l:start_end[0])
		if len( l:mark) >1
		  let l:mark = split(l:mark[1], l:start_end[1])
		  if len( l:mark) >0
		    let g:MyMenuBookmarks = g:MyMenuBookmarks .
\			" <M>". l:mark[0] ." ;:execute 'normal! /" 
\			  .l:mark[0] . "\<CR>' </M>"
		  endif
		endif 
	endfor
endfu

fu! MyOpenRecentFile()

	"clearing chars typed before (max, 10)...
	for l:i in range(10) | call getchar(0) | endfor	
	
	let l:tmp_old = v:oldfiles[0:7]
	
	let l:old_disp = " -------':bro old' for FULL LIST--------\n"
	let l:dipsChars = split("a b c d e f g h", " ")

	for l:i in range(len( l:tmp_old ))
		let l:old_disp = l:old_disp ."  " .  l:dipsChars[l:i] . ": " . " ---- " . split(split(l:tmp_old[l:i], "\\")[-1], "/")[-1] . " ---- " . l:tmp_old[l:i] . "\n" 
	endfor	
	
	echo l:old_disp

	let l:gotchar = index( l:dipsChars, nr2char( getchar()) )
	  redraw! 
	if(l:gotchar == -1)
		return
	endif 

	"clearing chars typed before (max, 10)...
	for l:i in range(10) | call getchar(0) | endfor	
	
	execute 'edit ' . l:tmp_old[l:gotchar]
endfu

"////////////////////////////////
"////////////////////////////////
" ----------------------------------------------------------------------------
" :b: Calendar Menu Script:b: -( Vim 7.4 Compatible (Drop-in style)
" ----------------------------------------------------------------------------
"  made basically by grok+gemini (from translation from js version)
let g:HtmTxt_cal_calender_delineator = "<CALENDER__ADD_ENTRIES_FROM_MENU_WHEN_CURSOR_BETWEEN_THESE_TAGS>\n"
let g:HtmTxt_cal_entry_delineator = "___________"

let g:HtmTxt_cal_month_numbers = ["January","February","March","April","May","June",
            \ "July","August","September","October","November","December"]

let g:HtmTxt_cal_item_date_catch = {}

fu! HtmTxt_cal_get_weekday(year, month, day)
    let l:m = a:month
    let l:y = a:year
    if l:m == 1 || l:m == 2
        let l:m += 12
        let l:y -= 1
    endif
    let l:k = a:day
    let l:j = l:y / 100
    let l:y = l:y % 100

    let l:h = (l:k + ((13 * (l:m + 1)) / 5) + l:y + (l:y / 4) + (l:j / 4) + 5 * l:j) % 7

    let l:days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    return l:days[l:h]
endfu

fu! HtmTxt_cal_trim(str)
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfu

fu! HtmTxt_cal_get_words(str)
    return split(a:str, '\v[^a-zA-Z0-9]+')
endfu

fu! HtmTxt_cal_get_curr_time_block()
    let l:now = localtime()
    let l:hour24 = str2nr(strftime("%H", l:now))
    let l:hour = l:hour24 % 12
    if l:hour == 0 | let l:hour = 12 | endif

    let l:obj = {}
    let l:obj.minute = str2nr(strftime("%M", l:now))
    let l:obj.hour   = l:hour
    let l:obj.AM_PM  = l:hour24 >= 12 ? "PM" : "AM"
    let l:obj.weekday = strftime("%A", l:now)
    let l:obj.day    = str2nr(strftime("%d", l:now))
    let l:obj.month  = g:HtmTxt_cal_month_numbers[str2nr(strftime("%m", l:now))-1]
    let l:obj.year   = str2nr(strftime("%Y", l:now))
    return l:obj
endfu

fu! HtmTxt_cal_month_from_txt_or_number(m)
    if a:m == '' | return '' | endif
    if a:m =~ '^\d\+$'
        let l:idx = str2nr(a:m) - 1
        return (l:idx >= 0 && l:idx < 12) ? g:HtmTxt_cal_month_numbers[l:idx] : ''
    endif
    for l:month in g:HtmTxt_cal_month_numbers
        if toupper(l:month[:len(a:m)-1]) == toupper(a:m)
            return l:month
        endif
    endfor
    return ''
endfu

fu! HtmTxt_cal_getItem_n_date(text_block)
    if has_key(g:HtmTxt_cal_item_date_catch, a:text_block)
        return g:HtmTxt_cal_item_date_catch[a:text_block]
    endif

    let l:parts = HtmTxt_cal_get_words(a:text_block)
    if len(l:parts) < 6 | return {} | endif

    let l:item = {}
    let l:i = 0
    while l:i + 4 < len(l:parts)
        if l:parts[l:i] =~ '^\d\+$' && l:parts[l:i+1] =~ '^\d\+$' && toupper(l:parts[l:i+2]) =~ '^AM\|PM'
            let l:item.hour   = str2nr(l:parts[l:i])
            let l:item.minute = str2nr(l:parts[l:i+1])
            let l:item.AM_PM  = toupper(l:parts[l:i+2])
            let l:item.month  = l:parts[l:i+3]
            let l:item.day    = str2nr(l:parts[l:i+4])
            let l:item.year   = (l:i+5 < len(l:parts)) ? str2nr(l:parts[l:i+5]) : 0
            break
        endif
        let l:i += 1
    endwhile

    if !has_key(l:item, "hour") | return {} | endif

    let l:item.month_number = index(g:HtmTxt_cal_month_numbers, l:item.month)

    " === FIX: Safe 12-hour to 24-hour normalization ===
    if l:item.AM_PM ==# 'AM' && l:item.hour == 12
        let l:item.hour = 0
    elseif l:item.AM_PM ==# 'PM' && l:item.hour < 12
        let l:item.hour += 12
    endif

    let g:HtmTxt_cal_item_date_catch[a:text_block] = l:item
    return l:item
endfu


fu! HtmTxt_cal_compare_dates(a, b)
    let l:oa = HtmTxt_cal_getItem_n_date(a:a)
    let l:ob = HtmTxt_cal_getItem_n_date(a:b)
    if empty(l:oa) || empty(l:ob) | return 0 | endif

    if l:oa.year != l:ob.year | return l:oa.year > l:ob.year ? 1 : -1 | endif
    if l:oa.month_number != l:ob.month_number | return l:oa.month_number > l:ob.month_number ? 1 : -1 | endif
    if l:oa.day != l:ob.day | return l:oa.day > l:ob.day ? 1 : -1 | endif
    if l:oa.AM_PM !=# l:ob.AM_PM | return l:oa.AM_PM ==# 'PM' ? 1 : -1 | endif
    if l:oa.hour != l:ob.hour | return l:oa.hour > l:ob.hour ? 1 : -1 | endif
    if l:oa.minute != l:ob.minute | return l:oa.minute > l:ob.minute ? 1 : -1 | endif
    return 0
endfu


fu! HtmTxt_cal_genTxt_date(prev, p_min, p_hr, p_ampm, p_day, p_mon, p_yr)
    let l:work = empty(a:prev) ? HtmTxt_cal_get_curr_time_block() : copy(a:prev)

    let l:min  = a:p_min  != '' ? str2nr(a:p_min)  : l:work.minute
    let l:hr   = a:p_hr   != '' ? str2nr(a:p_hr)   : l:work.hour
    let l:ampm = a:p_ampm != '' ? toupper(a:p_ampm): l:work.AM_PM
    let l:day  = a:p_day  != '' ? str2nr(a:p_day)  : l:work.day
    let l:yr   = a:p_yr   != '' ? str2nr(a:p_yr)   : l:work.year

    let l:month = a:p_mon != '' ? HtmTxt_cal_month_from_txt_or_number(a:p_mon) : l:work.month
    if l:month == '' | let l:month = l:work.month | endif

    " --- FIX 1: Turn internal 24-hour state safely back into 12-hour display format ---
    if l:hr > 12
        let l:hr -= 12
        let l:ampm = "PM"
    elseif l:hr == 0
        let l:hr = 12
        let l:ampm = "AM"
    endif

    let l:month_idx = index(g:HtmTxt_cal_month_numbers, l:month) + 1
    let l:weekday = HtmTxt_cal_get_weekday(l:yr, l:month_idx, l:day)

    let l:out = g:HtmTxt_cal_entry_delineator . " " . l:weekday . " "
                \ . l:hr . ":" . printf("%02d", l:min) . " " . l:ampm
                \ . " ----------" . l:month . " " . l:day . " ----------" . l:yr . " "

    return l:out
endfu


fu! HtmTxt_cal_getPrevDate()
    let l:full = join(getline(1, '$'), "\n")
    let l:curpos = line('.') * 1000 + col('.')
    let l:idx = strridx(l:full[0:l:curpos], g:HtmTxt_cal_entry_delineator)
    if l:idx == -1 | return {} | endif
    let l:chunk = strpart(l:full, l:idx, 160)
    return HtmTxt_cal_getItem_n_date(l:chunk)
endfu


fu! HtmTxt_cal_menu()
    let l:lines = getline(1, '$')
    let l:full_text = join(l:lines, "\n")

    let l:cal_delim = g:HtmTxt_cal_calender_delineator
    let l:entry_delim = g:HtmTxt_cal_entry_delineator

    let l:blocks = split(l:full_text, '\V' . escape(l:cal_delim, '\/'), 1)

    " === Ensure proper 3 blocks (create if missing, matching JS structural tracking) ===
    if len(l:blocks) != 3
        let l:template = " :b: Calendar_1_per_file :b: \n" . l:cal_delim . "\n\n" . l:cal_delim
        let l:full_text = l:full_text . (l:full_text == "" ? "" : "\n") . l:template
        let l:blocks = split(l:full_text, '\V' . escape(l:cal_delim, '\/'), 1)
        let l:tmpEntries = []
    else
        let l:cal_text = l:blocks[1]
        let l:tmpEntries = split(l:cal_text, '\V' . escape(l:entry_delim, '\/'), 1)
    endif

    " === Get user input ===
    let l:msg = "ENTER CALENDER ENTRY FORMAT (blank to cancel):\n"
          \ . " (days/month::1:Jan31 2:Feb28(29 leap years) \n"
          \ . " 3:Mar31 4:Apr30 5:May31 6:Jun30 7:July31 \n"
          \ . " 8:Aug31 9:Sept30 10:Oct31 11:Nov30 12:Dec31 \n"
          \ . " first 'n' is for NOW, else previous entry by cursor\n"
          \ . " AUTO-FILLS MISSING ELEMENTS!!!\n"
          \ . " EG: n 12:30 am jan 23 2026 -OR- 12 30 am 1 23 2026\n> "
    
    let l:input = input(l:msg)
    if HtmTxt_cal_trim(l:input) == "" | return | endif

    let l:prompts = HtmTxt_cal_get_words(l:input)
    let l:use_now = 0
    if len(l:prompts) > 0 && tolower(l:prompts[0]) ==# 'n'
        let l:use_now = 1
        call remove(l:prompts, 0)
    endif

    " Pad prompts array to mimic JS argument spreading safety
    while len(l:prompts) < 6
        call add(l:prompts, "")
    endwhile

    let l:prevDate = l:use_now ? {} : HtmTxt_cal_getPrevDate()
    if empty(l:prevDate)
        " Explicitly padding the 7 expected arguments to satisfy Vim 7.4 strict arity
        let l:prevDate = HtmTxt_cal_getItem_n_date(HtmTxt_cal_genTxt_date({}, "", "", "", "", "", ""))
    endif
     

    let l:tmpGenDate = HtmTxt_cal_genTxt_date(l:prevDate,
                \ l:prompts[1], l:prompts[0], l:prompts[2],
                \ l:prompts[4], l:prompts[3], l:prompts[5])

    if empty(l:tmpGenDate)
        echo "\nfailed to create date!"
        return
    endif

    " Extract raw entry body without its delineator
    let l:new_entry_split = split(l:tmpGenDate, '\V' . escape(l:entry_delim, '\/'), 1)
    let l:new_entry_body = (len(l:new_entry_split) > 1 ? l:new_entry_split[1] : l:tmpGenDate)
    
    call add(l:tmpEntries, l:new_entry_body)

    " === FIX: Clear old whitespaces while explicitly protecting layout formatting ===
    let l:clean_entries = []
    for l:entry in l:tmpEntries
        let l:trimmed = substitute(l:entry, '^[\s\r\n]\+\|[\s\r\n]\+$', '', 'g')
        if l:trimmed != ""
            " Appending a single leading space preserves the clean "___________ Monday" look
            call add(l:clean_entries, " " . l:trimmed . "\n\n\n")
        endif
    endfor

    " Sort if multiple entries exist
    if len(l:clean_entries) > 1
        call sort(l:clean_entries, "HtmTxt_cal_compare_dates")
    endif

    " === Re-inject matching JS exact layout logic ===
    let l:blocks[1] = l:entry_delim . join(l:clean_entries, l:entry_delim)
    let l:reconstructed = join(l:blocks, l:cal_delim)

    " Overwrite buffer safely (Vim 7.4 keepempty compatible)
    %delete _
    call setline(1, split(l:reconstructed, "\n", 1))

    " === FIX: Generate a search target that perfectly matches the newly cleaned buffer text ===
    let l:search_target = l:entry_delim . " " . substitute(l:new_entry_body, '^[\s\r\n]\+\|[\s\r\n]\+$', '', 'g')
    call search(escape(l:search_target, '\/.*$^~[]'), 'w')
    normal! j
endfu



let g:MyMenus_Main = "
\<M> Spreadsheet/Tag Functs  ; g:MyMenus_Spreadsheet </M> 
\<M> Bkmarks/FoldTxt/cheetsht; g:MyMenuBookmarks  </M> 
\<M> Calendar(add/add entry) ;:call HtmTxt_cal_menu() </M>
\<M> Files/Terminal          ; g:Menu_File_Sys </M> 
\<M> Tools/Procedural Gen    ; g:MyMenus_SubOptimalTools  </M> 
\<M> OpenRecent(exit updates);:call MyOpenRecentFile() </M> 
\<M> Replace Wrd Under Cursor;:call MyReplaceUdrCrsr() </M>
\<M> 
\\n\r start lines with to run when press ENTER(SHIFT+ENTER ignores):
\\n\r        ':'/'='/'=+'  ('='prints, like 'echo', \w '+'stays on line), 
\\n\r        '=+Run()'/':call Run()'(runs ALL ':'/'=' starting lines)
\\n\r        '=RunTag('TAG')'    (runs code btween #1 & 2 'TAG's in doc)
\\n\r        ':w|so %'     (runs file as vimscript(USE IN VimTERMINAL))
\\n\r  example:          
\\n\r    :let g:v=str2nr(input('a').'4')| let g:v=g:v+1| call input('')
\\n\r    =g:v+2.0| let g:var=[{'b':['a',1]}] | let g:var[0]['c']=2 ;: </M>"

let g:Menu_File_Sys = "
\<M>RunCurLine like a shortcut ;: call MySysOpenCurLine()  </M>
\<M>Sh-Batch-vimScript From CurDoc;: call MyMakeCmd_post_polyglot() </M>
\<M>RunCurLine like above as link;: call MyP('=MyOpen(\"\", 1)')  </M>
\<M>Recursive FileNameGet      ::(srchList,rtrnList,format_0vim_1path_2shell)
\\n           ;: call MyP('=MyEverything([\"**/*.txt\"], 0, 1) \"
\../*.txt,*.txt')  </M>
\<M>Run terminal CmdA;: call MyP('=system(\"echo 1 && echo 2\")')  </M>
\<M>Run term Cmd(old);: call MyP('write\"!echo 1\" in a line, yy:ctrl_P')</M>
\<M>Terminal(or:term);: execute(\"! xterm || cmd \")  </M>
\<M>term run vimscrip;: call MyP('vim --cmd \"so a.vim | so b.vim|q!\"')  </M>
\<M>getURL(lin/win10);: call MyP('=system(\"curl http://www.URL.com\")')</M>
\<M>ReadFile(asList) ;: call MyP('=readfile(\"filename\")')  </M>
\<M>ReadListOfFiles  ;: call MyP('=MyReadFileList([\"a.txt\"],0) \"asLines')</M>
\<M>MakeDir          ;: call MyP('=mkdir(\"DIRNAME\")')</M>
\<M>WriteFile        ::(final paramiter:blank,'a' for append,'b' binary)
\\n     ;: call MyP('=writefile([\"lines or obj\"], \"filename.txt\", \"\")')  </M>
\<M>FILE_OTHER_OPTS- delete(\"file/fldr\"), cd \"dir\" ;: </M>
\"

let g:MyMenus_Tags = "
\<M>--PULL TXT BETWEEN EVERY OTHER TAG (& EXAMPLE OF HOW TAGS WORK)\n\r
\;:call MyGetTxtBtweentags_curDoc() </M> 
\<M>--TAG OPTS #S BETWEEN TAGS  (1 # PER TAG) \n\r
\;:call MyP('=TagSum(\"#TAG\") \" TagMax,TagMin,TagList,TagNumbList') </M>
\<M>--2D_LIST->TSV 
\;:call MyP('=MyList2dToTSV([[\"#1\",2],[3,\"!4\"]],\"#!\")') </M> 
\<M>--Convert TSV to Tagged data (whole doc) ;:call MyTagTSVCols() </M> 
\<M>------COMPARE 2 TAGS (NUMBERS ONLY IN TAGS, 1 PER TAG ENTRY) \n\r
\;:call MyP('=TagCompare2(\"TagA\",\"TagB\",[\"c_ListTagsAvrgEach\"],1)')
\</M> 
\<M>------STOCKPROJECT, 1.05 FOR %MULTI4_1TRADE = 5% GAIN/TRADE  \n\r
\;:call MyP('=TagStockProjection( startCash,
\ #trades, trade%OfCash, %Multi4_1trade)') </M> 
\<M>------STOCKTRADES (START CONTAING_TAGS WITH #/!/$), SEE VIMRC\n\r
\ '#CONTAIN...' are added 2 each search:'WIN %'->'#CONTAIN... WIN %'\n\r  
\;:call MyP('=TagStockTrades( [\"#CONTAINING TAGS\"],\"WIN %TAG\",
\\"LOSE %TAG\",[\"LOSE DAYLEN\", \"WIN DAYLEN\"])') </M> 
\"

let g:MyMenus_Spreadsheet = "
\<M>Tags Sub-menu                          ;g:MyMenus_Tags </M> 
\<M>Pull lines containing                  ;:call MyPullLinesWith('') </M> 
\<M>Copy buff exec(same as '=' @ linestrt) ;:call MyCopyBuffRun() </M> 
\<M>Sum Collumn                            ;:call MySumCol() </M> 
\<M>Avrg Collumn                           ;:call MyAvrgCol() </M> 
\<M>Sort Lines By Tab                      ;:call MySortByTab()</M> 
\<M>Avrg PREVIOUS/LASTctrl+q sel. text     ;:call MyAvrgSelectedText()</M> 
\<M>Select tab collumn(like ctrl+q select) ;:call MySelect_col() </M> 
\<M>Sum PREVIOUS/LASTctrl+q sel. text      ;:call MySumSelectedText()</M> 
\<M>Count lines(-1= cur line);
\:call MyP('=+len(MyPullLinesWith(\"-\"))-1')</M> 
\<M>--------NOTES:
\\n\r wordwrap-> :set wrap / :set nowrap
\\n\r 'Count lines' takes same input as 'Pull lines containing'
\\n\r Rectangle Select--use CTLR+q & HOLD SHIFT in normal mode
\\n\r FOAT-vars WON'T WORK on some vim versions!!!;: </M>"

let g:MyMenus_SubOptimalTools = "
\<M> Procedural Generation      ; g:MyMenuProgen </M> 
\<M>Speed Read                  ;:call MySpeedRead() </M>
\<M>Drawing Mode                ;:call DrawMode_EntrLeave() </M> 
\<M>Timer ( NOT accurate)       ;:call MyTimer_blocking () </M> 
\<M>DiceSolitaire( modivation? );:call MyDice_solitare() </M> 
\<M>Encrypt file:               ;:execute('X') </M> 
\<M>Macros:NORMAL MODE: q+register, q to stop, playback:@+register;: </M> 
\<M>Recursive grab_between_tags/replace----see cheatsheet/JS2Vim;: </M> 
\<M>Recursive run esc. seq on dir files----see cheatsheet/JS2Vim;: </M> 
\<M>Clipboards:':reg' lists(del. txt IS registers), \"@y, \"@p, etc;: </M> 
\<M>CLIPBOARD MANAGER(using 'reg'): open vim, paste, run below cmd:
\<M>--- :execute 'normal Gdgg' |q! ---Remove q! if leaving vim open;: </M> 
\<M>FIND ONLINE:SPEEDREAD'spritz'/w MARKOV TXTGEN/SIMPLETOOLS---;: </M> 
\<M>NOTE:
\\n\r    Search/clipBoards tools:(ClCl/Everything win/fzf lin) </M> "

fu! MyP(getStr) "post string to curline, simplified for use in menus
	call append(line('.'), a:getStr)
	normal! j
endfu

let g:MyMenuProgen = "
\<M>RanDraw get groups  ;
\:call MyP('=+RandDraw([\"?\"], 1,\"\")[0]') </M> 
\<M>RanDraw EXAMPLE     ;
\:call MyP('=+RandDraw([\"d8\",\"!-\",\"cards\"],4,\"\")') </M> 
\<M>Roll 1D20                     ;:call MyP('=+Roll(20,1)') </M> 
\<M>RanDraw base ('.')(load first);
\:call MyP('=+RandDraw([\".\"], 1, \"\")') </M> 
\<M>RanDraw base ('.')([0])       ;
\:call MyP('=+RandDraw([\".\"], 1,\"\")[0]') </M> 
\<M>Load RandDraw() from OpenDoc    ;:call RandDraw_dataFrom(2) </M> 
\<M>Load RandDraw() from CopyBuffer ;:call RandDraw_dataFrom(0) </M> 
\<M>Load RandDraw() from NearbyFiles;:call RandDraw_dataFrom(1) </M> 
\<M>Clean gen-strs & del '|/=' lines;:call MyTrimGendStrLines() </M> 
\<M>\n\r---------(CAN CRASH) dRandDraw()/RandDraw_2dList() guide::"
\."\n\r  RandDraw([groups_add_per_entry], number_draws, recomb_or_blank) "
\."\n\r    [groups_add_per_entry] = list of groups to draw & join, "
\."\n\r  	entries that start with '!' aren't groups, just txt disp"
\."\n\r     recomb_or_blank =groups will be split and recombined by this" 
\.";: </M>" 

" for if can change font here
if has("gui_running") && has("unix")
	set guifont=Consolas\ Bold\ 18
	set lines=18
endif

" :b: colorScheme :b: murphy, builtin, Ron Aaron <ron@ronware.org>
""""""""""""""""""""""""""
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "murphy"

hi Normal		ctermbg=Black  ctermfg=lightgreen guibg=Black		 guifg=lightgreen
hi Comment		term=bold	   ctermfg=LightRed   guifg=Orange
hi Constant		term=underline ctermfg=LightGreen guifg=White	gui=NONE
hi Identifier	term=underline ctermfg=LightCyan  guifg=#00ffff
hi Ignore					   ctermfg=black	  guifg=bg
hi PreProc		term=underline ctermfg=LightBlue  guifg=Wheat
hi Search		term=reverse					  guifg=white	guibg=Blue
hi Special		term=bold	   ctermfg=LightRed   guifg=magenta
hi Statement	term=bold	   ctermfg=Yellow	  guifg=#ffff00 gui=NONE
hi Type						   ctermfg=LightGreen guifg=grey	gui=none
hi Error		term=reverse   ctermbg=Red	  ctermfg=White guibg=Red  guifg=White
hi Todo			term=standout  ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
" From the source:
hi Cursor										  guifg=Orchid	guibg=fg
hi Directory	term=bold	   ctermfg=LightCyan  guifg=Cyan
hi ErrorMsg		term=standout  ctermbg=DarkRed	  ctermfg=White guibg=Red guifg=White
hi IncSearch	term=reverse   cterm=reverse	  gui=reverse
hi LineNr		term=underline ctermfg=Yellow					guifg=Yellow
hi ModeMsg		term=bold	   cterm=bold		  gui=bold
hi MoreMsg		term=bold	   ctermfg=LightGreen gui=bold		guifg=SeaGreen
hi NonText		term=bold	   ctermfg=Blue		  gui=bold		guifg=Blue
hi Question		term=standout  ctermfg=LightGreen gui=bold		guifg=Cyan
hi SpecialKey	term=bold	   ctermfg=LightBlue  guifg=Cyan
hi StatusLine	term=reverse,bold cterm=reverse   gui=NONE		guifg=White guibg=darkblue
hi StatusLineNC term=reverse   cterm=reverse	  gui=NONE		guifg=white guibg=#333333
hi Title		term=bold	   ctermfg=LightMagenta gui=bold	guifg=Pink
hi WarningMsg	term=standout  ctermfg=LightRed   guifg=Red
hi Visual		term=reverse   cterm=reverse	  gui=NONE		guifg=white guibg=darkgreen
                                         






