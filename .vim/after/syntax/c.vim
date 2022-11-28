
" -------------------------
" Highlight DELME keywords
" -------------------------

" Create keyword called myDelme with "DELME" and "delme", they will only highlight if
" contained in another group.
syn keyword myDelme DELME delme contained
" Add myDelme to the cCommentGroup cluster (in a c file: ":syn list", G)
syn cluster cCommentGroup add=myDelme
" Link myDelme to the Todo highlight format
hi link myDelme Todo
