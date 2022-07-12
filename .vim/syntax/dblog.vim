" Vim syntax file
" Language: Discord bot logs
" Maintainer: https://github.com/r4v10l1
" Latest Revision: 16 April 2022

if exists("b:current_syntax")
    finish
endif

" ------------- Regions ------------
syn region botMessageRegion start="\[Bot\] " end="$" transparent contains=tagRegion
syn region tagRegion start="\[" end="\] " transparent contained contains=errorKeywords,warningKeywords,modulesKeywords

syn region guildRegion start="\[" end="\]" transparent contains=guildChannel,discordUser
syn region beforeMessageLog start="^" end="\:" transparent contains=guildRegion
syn region afterMessageLog start="\]\: " end="$"

" ------------ Keywords ------------
syn keyword errorKeywords contained Error
syn keyword warningKeyword contained W E ET
syn keyword modulesKeywords contained Music Administration Admin AM Messages Ping

" ------------ Matches -------------
syn match guildChannel contained "[a-zA-Z0-9\-.\'’&$ ]\+\/[a-zA-Z0-9\-.\'’&$ ]\+"
syn match discordUser contained "[a-zA-Z0-9\-.\'’&$ ]\+#\d\{4}"

syn match dblComment "^#.*$"

" ----------- Highlight ------------
let b:current_syntax = "dblog"  " Discord bot log

hi def link dblComment          Comment

hi def link afterMessageLog     Comment

hi def link guildChannel        Comment
hi def link discordUser         Comment
