
"---------------------------------------------------
" Highlight NOTE and DELME keywords inside comments
"---------------------------------------------------

" Create keyword called myExtraCommentKeywords with 'NOTE', 'DELME' and 'delme',
" they will only highlight if contained in another group.
syn keyword myExtraCommentKeywords NOTE DELME delme contained

" Add myExtraCommentKeywords to the cCommentGroup cluster.
" From a c file, see: `:syn list`, G
syn cluster cCommentGroup add=myExtraCommentKeywords

" Link myExtraCommentKeywords to the Todo highlight format
hi link myExtraCommentKeywords Todo
