
" emoticon vim plugin
"
" Author: Cornelius
" Email:  cornelius.howl@gmail.com
" Date:   二 11/17 20:30:28 2009
" Version: 0.1
"
" http://github.com/c9s

scriptencoding utf8

fun! s:randselect(list)
  let s = len( a:list )
  let r = reltime()
  let t = str2nr( r[1] ) % s
  return a:list[t]
endf

fun! s:generate()
    let rinkaku = s:randselect([
      \['(',')'] , 
      \['(', ')'], 
      \['|', '|'], 
      \['[', ']']
      \])
    let otete = s:randselect([
      \['∑','','','',''],
      \['', '', '', '', ''], 
      \['', '', 'm', '', ''],
      \['', '', 'ლ', '', ''], 
      \['ლ', '', '', 'ლ', ''], 
      \['', '｢', '', '', '｢'], 
      \['', ' つ', '', '', 'つ'], 
      \['', '　', '', '', 'o彡ﾟ'], 
      \['⊚', '', '', '', '⊚'], 
      \['', 'n', '', '', 'η'], 
      \['', '∩', '', '∩', ''], ['∩', '', '', '', '∩'], ['ヽ', '', '', '', 'ノ'], ['┐', '', '', '', '┌']])
    let omeme = s:randselect([['╹', '╹'], ['＞', '＜'], ['＾', '＾'], ['・', '・'], ['´・', '・`'], ['`・', '・´'], ['´', '`'], ['≧', '≦'], ['ﾟ', 'ﾟ'], ['''', ''''], ['･ิ', '･ิ'], ['❛', '❛']])
    let okuti = s:randselect(['⇔','x','=','"','~','_','д','ω', '∀', '▽', '△', 'Д', '◡', 'A', '□', '～', 'ー', 'ェ', 'ρ', 'o'])
    let hoppe = s:randselect([['', ''], ['*', ''], ['', '*'], ['', '#'], ['#', ''], ['✿', ''], ['', '✿'], ['', '；'], ['；', ''], ['', '。']])

    let ot1 = otete[1]
    let ot2 = otete[2]
    let ot3 = otete[3]
    if ot1 == '' && otete[3]
      let ot1 = ''
    elseif ot1 == '' && otete[3] == ''
      let ot1 = hoppe[0]
    endif

    if ot2 == ''
      let ot2 = okuti
    endif

    if ot3 == '' && otete[1]
      let ot3 = ''
    elseif ot3 == '' && otete[1] == ''
      let ot3 = hoppe[1]
    endif

    let text = [
          \        otete[0],
          \        rinkaku[0],
          \        ot1,
          \        omeme[0],
          \        otete[2],
          \        omeme[1],
          \        ot2,
          \        rinkaku[1],
          \        otete[4]
          \]
    return join( text , "" )
endf

fun! s:newEmoticon()
  echo s:generate()
endf

fun! s:appendEmoticon()
  cal append(line('.'), s:generate() )
endf

fun! s:newEmoticonCB()
  if has('clipboard')
    cal setreg('*', s:generate() )
  else
    echomsg "You dont have clipboard supported"
  endif
endf

fun! s:gen_key(i)
  let key = ""
  let k = a:i
  while k > 0
    let key = nr2char( k % 26 + 97 ) . key
    let k = float2nr(k / 26)
  endwhile
  return key
endf

fun! CompleteEmoticon(s,base)
  if a:s 
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    for i in range(1,200)
      let key = s:gen_key(i)
      cal complete_add( { 'word': s:generate() , 'menu': key } )
    endfor
  endif
endf

com! NewEmoticon :cal s:newEmoticon()
com! NewEmoticonCB  :cal s:newEmoticonCB()
com! AppendEmoticon :cal s:appendEmoticon()
com! EnableEmoticonOmni :setlocal omnifunc=CompleteEmoticon
