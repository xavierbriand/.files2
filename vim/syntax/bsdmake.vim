" Vim syntax file
" Language:     BSD Makefile
" Maintainer:   Taylor Venable <taylor@metasyntax.net>
" URL:          http://bitbucket.org/taylor_venable/metasyntax/src/tip/Config/vim/syntax/bsdmake.vim
" Last Change:  2010 Oct 03
" Revision:     r755

" Based on 'make.vim' distributed with the Vim release,
" which is maintained by Claudio Fleiner <claudio@fleiner.com>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" some special characters
syn match bsdmakeSpecial        "^\s*[@+-]\+"
syn match bsdmakeNextLine       "\\\n\s*"

" Variable definitions; highlight the identifier.
syn match bsdmakeIdent  "^ *\a\w*\s*[:+?!]="me=e-2
syn match bsdmakeIdent  "^ *\a\w*\s*="me=e-1

" some directives
syn match bsdmakeConditional    "^\. *\(if\>\|ifn\?def\>\|ifn\?bsdmake\>\|else\>\|elif\>\|elifn\?def\>\|elifn\?bsdmake\>\|endif\>\)"
syn match bsdmakeForLoop        "^\. *\(for\>\|endfor\>\)"
syn match bsdmakeInclude        "^\. *include"

" Hijacked shamelessly from the sed.vim syntax file.
" Metacharacters: $ * . \ ^ [ ~
" @ is used as delimiter and treated on its own below

let __at = char2nr("@")
let __bsdmake_i = char2nr(" ")
let __bsdmake_last = 126

let __bsdmake_metacharacters = '$*.\^[~'

while __bsdmake_i <= __bsdmake_last
    let __bsdmake_delim = escape(nr2char(__bsdmake_i), __bsdmake_metacharacters)
    if __bsdmake_i != __at
        exe 'syn region bsdmakeReplMod'.__bsdmake_i.' matchgroup=Special start=@'.__bsdmake_delim.'@ skip=@\\\\'.__bsdmake_delim.'@ end=@'.__bsdmake_delim.'@me=e-1 keepend contained contains=bsdmakeIdent nextgroup=bsdmakeReplModInt'.__bsdmake_i
        exe 'syn region bsdmakeReplModInt'.__bsdmake_i.' matchgroup=Special start=@'.__bsdmake_delim.'@ skip=@\\\\'.__bsdmake_delim.'@ end=@'.__bsdmake_delim.'[1g]*@ keepend contained contains=bsdmakeIdent'
    endif
    let __bsdmake_i = __bsdmake_i + 1
endwhile

syn region bsdmakeReplMod64 matchgroup=Special start=+@+ skip=+\\@+ end=+@+me=e-1 keepend contained contains=bsdmakeIdent nextgroup=bsdmakeReplModInt64
syn region bsdmakeReplModInt64 matchgroup=Special start=+@+ skip=+\\@+ end=+@+ keepend contained contains=bsdmakeIdent

syn region bsdmakeModP start=":" end=")"me=e-1 skip="\\)" contains=bsdmakeSimpleMod,bsdmakeReplMod contained
syn region bsdmakeModC start=":" end="}"me=e-1 skip="\\}" contains=bsdmakeSimpleMod,bsdmakeReplMod contained

syn match bsdmakeSimpleMod "[EHLUQRT]" contained
syn match bsdmakeReplMod "[SC]" contained nextgroup=bsdmakeReplMod\d\+

hi link bsdmakeSimpleMod        bsdmakeModifier
hi link bsdmakeReplMod          bsdmakeModifier

" identifiers
syn region bsdmakeIdent         start="\$(" skip="\\)\|\\\\" end=")" contains=bsdmakeStatement,bsdmakeIdent,bsdmakeSString,bsdmakeDString,bsdmakeModP
syn region bsdmakeIdent         start="\${" skip="\\}\|\\\\" end="}" contains=bsdmakeStatement,bsdmakeIdent,bsdmakeSString,bsdmakeDString,bsdmakeModC

" bsdmake targets
syn match bsdmakeImplicit               "^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2 nextgroup=bsdmakeSource
syn match bsdmakeImplicit               "^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1 nextgroup=bsdmakeSource

syn region bsdmakeTarget        transparent matchgroup=bsdmakeTarget start="^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"rs=e-1 end=";"re=e-1,me=e-1 end="[^\\]$" keepend contains=bsdmakeIdent,bsdmakeSpecTarget,bsdmakeNextLine skipnl nextGroup=bsdmakeCommands
syn match bsdmakeTarget         "^[A-Za-z0-9_./$()%*@-][A-Za-z0-9_./\t $()%*@-]*::\=\s*$" contains=bsdmakeIdent,bsdmakeSpecTarget skipnl nextgroup=bsdmakeCommands,bsdmakeCommandError

syn region bsdmakeSpecTarget    transparent matchgroup=bsdmakeSpecTarget start="^\.\(BEGIN\|DEFAULT\|END\|IGNORE\|INCLUDES\|INTERRUPT\|LIBS\|MAIN\|MAKEFLAGS\|NOTPARALLEL\|NO_PARALLEL\|ORDER\|PATH\|PHONY\|PRECIOUS\|SILENT\|SUFFIXES\)\>\s*:\{1,2}[^:=]"rs=e-1 end="[^\\]$" keepend contains=bsdmakeIdent,bsdmakeSpecTarget,bsdmakeNextLine skipnl nextGroup=bsdmakeCommands
syn match bsdmakeSpecTarget             "^\.\(BEGIN\|DEFAULT\|END\|IGNORE\|INCLUDES\|INTERRUPT\|LIBS\|MAIN\|MAKEFLAGS\|NOTPARALLEL\|NO_PARALLEL\|ORDER\|PATH\|PHONY\|PRECIOUS\|SILENT\|SUFFIXES\)\>\s*::\=\s*$" contains=bsdmakeIdent skipnl nextgroup=bsdmakeCommands,bsdmakeCommandError

syn match bsdmakeCommandError "^\s\+\S.*" contained
syn region bsdmakeCommands start=";"hs=s+1 start="^\t" end="^[^\t#]"me=e-1,re=e-1 end="^$" contained contains=bsdmakeCmdNextLine,bsdmakeSpecial,bsdmakeComment,bsdmakeIdent,bsdmakePreCondit,bsdmakeDefine,bsdmakeDString,bsdmakeSString nextgroup=bsdmakeCommandError
syn match bsdmakeCmdNextLine    "\\\n."he=e-1 contained

syn region  bsdmakeComment      start="#" end="^$" end="[^\\]$" keepend contains=@Spell,bsdmakeTodo
syn match   bsdmakeComment      "#$" contains=@Spell

syn keyword bsdmakeTodo TODO FIXME XXX contained

" match escaped quotes and any other escaped character
" except for $, as a backslash in front of a $ does
" not bsdmake it a standard character, but instead it will
" still act as the beginning of a variable
" The escaped char is not highlightet currently
syn match bsdmakeEscapedChar    "\\[^$]"

syn region  bsdmakeDString start=+\(\\\)\@<!"+  skip=+\\.+  end=+"+  contains=bsdmakeIdent
syn region  bsdmakeSString start=+\(\\\)\@<!'+  skip=+\\.+  end=+'+  contains=bsdmakeIdent
syn region  bsdmakeBString start=+\(\\\)\@<!`+  skip=+\\.+  end=+`+  contains=bsdmakeIdent,bsdmakeSString,bsdmakeDString,bsdmakeNextLine

" Syncing
syn sync minlines=20 maxlines=200

" Sync on Make command block region: When searching backwards hits a line that
" can't be a command or a comment, use bsdmakeCommands if it looks like a target,
" NONE otherwise.
syn sync match bsdmakeCommandSync groupthere NONE "^[^\t#]"
syn sync match bsdmakeCommandSync groupthere bsdmakeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"
syn sync match bsdmakeCommandSync groupthere bsdmakeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}\s*$"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_make_syn_inits")
  if version < 508
    let did_make_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink bsdmakeNextLine                bsdmakeSpecial
  HiLink bsdmakeCmdNextLine     bsdmakeSpecial
  HiLink bsdmakeSpecTarget              Statement
  if !exists("bsdmake_no_commands")
    HiLink bsdmakeCommands              Number
  endif
  HiLink bsdmakeImplicit        Function
  HiLink bsdmakeTarget          Function
  HiLink bsdmakeInclude         Include
  HiLink bsdmakeConditional     PreCondit
  HiLink bsdmakeForLoop         Repeat
  HiLink bsdmakeStatement       Statement
  HiLink bsdmakeIdent           Identifier
  HiLink bsdmakeModifier        Underlined
  HiLink bsdmakeSpecial         Special
  HiLink bsdmakeComment         Comment
  HiLink bsdmakeDString         String
  HiLink bsdmakeSString         String
  HiLink bsdmakeBString         Function
  HiLink bsdmakeError           Error
  HiLink bsdmakeTodo            Todo
  HiLink bsdmakeDefine          Define
  HiLink bsdmakeCommandError    Error
  HiLink bsdmakeConfig          PreCondit
  delcommand HiLink
endif

let b:current_syntax = "bsdmake"

" vim: ts=8
