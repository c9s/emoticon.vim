
" emoticon vim plugin
"
" Author: Cornelius
" Email:  cornelius.howl@gmail.com
" Date:   二 11/17 20:30:28 2009
" Version: 0.1
"
" http://github.com/c9s

fun! s:randselect(list)
  let s = len( a:list )
  let t = str2nr( localtime() ) * 7 % s
  return a:list[t]
endf

fun! s:generate()
    let rinkaku = s:randselect([ ['(',')'] , ['(', ')'], ['|', '|'], ['[', ']'] ])
    let otete = s:randselect([['∑','','','',''],['', '', '', '', ''], ['', '', 'm', '', ''], ['', '', 'ლ', '', ''], ['ლ', '', '', 'ლ', ''], ['', '｢', '', '', '｢'], ['', ' つ', '', '', 'つ'], ['', '　', '', '', 'o彡ﾟ'], ['', 'n', '', '', 'η'], ['', '∩', '', '∩', ''], ['∩', '', '', '', '∩'], ['ヽ', '', '', '', 'ノ'], ['┐', '', '', '', '┌']])
    let omeme = s:randselect([['╹', '╹'], ['＞', '＜'], ['＾', '＾'], ['・', '・'], ['´・', '・`'], ['`・', '・´'], ['´', '`'], ['≧', '≦'], ['ﾟ', 'ﾟ'], ['''', ''''], ['･ิ', '･ิ'], ['❛', '❛']])
    let okuti = s:randselect(['д','ω', '∀', '▽', '△', 'Д', '◡', 'A', '□', '～', 'ー', 'ェ', 'ρ', 'o'])
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

fun! s:newemoticon()
  echo s:generate()
endf

com! NewEmoticon :cal s:newemoticon()
