" MIT License. Copyright (c) 2013-2021 Bailey Ling Christian Brabandt et al.
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

" basic 16 msdos from MSDOS
" see output of color, should be
"     0    Black
"     1    DarkBlue
"     2    DarkGreen
"     3    DarkCyan
"     4    DarkRed
"     5    DarkMagenta
"     6    Brown
"     7    LightGray
"     8    DarkGray
"     9    Blue
"     10   Green
"     11   Cyan
"     12   Red
"     13   Magenta
"     14   Yellow
"     15   White

let s:basic16 = [
  \ [ 0x00, 0x00, 0x00 ],
  \ [ 0x00, 0x00, 0x80 ],
  \ [ 0x00, 0x80, 0x00 ],
  \ [ 0x00, 0x80, 0x80 ],
  \ [ 0x80, 0x00, 0x00 ],
  \ [ 0x80, 0x00, 0x80 ],
  \ [ 0x80, 0x80, 0x00 ],
  \ [ 0xC0, 0xC0, 0xC0 ],
  \ [ 0x80, 0x80, 0x80 ],
  \ [ 0x00, 0x00, 0xFF ],
  \ [ 0x00, 0xFF, 0x00 ],
  \ [ 0x00, 0xFF, 0xFF ],
  \ [ 0xFF, 0x00, 0x00 ],
  \ [ 0xFF, 0x00, 0xFF ],
  \ [ 0xFF, 0xFF, 0x00 ],
  \ [ 0xFF, 0xFF, 0xFF ]
  \ ]

if !exists(":def") || !airline#util#has_vim9_script()

	function! airline#msdos#round_msdos_colors(rgblist)
		" Check for values from MSDOS 16 color terminal
		let best = []
		let min  = 100000
		let list = s:basic16
		for value in list
			let t = abs(value[0] - a:rgblist[0]) +
						\ abs(value[1] - a:rgblist[1]) +
						\ abs(value[2] - a:rgblist[2])
			if min > t
				let min = t
				let best = value
			endif
		endfor
		return index(s:basic16, best)
	endfunction

	finish

else

  def airline#msdos#round_msdos_colors(rgblist: list<number>): string
    # Check for values from MSDOS 16 color terminal
    var best = []
    var min  = 100000
    var t = 0
    for value in s:basic16
      t = abs(value[0] - rgblist[0]) +
          abs(value[1] - rgblist[1]) +
          abs(value[2] - rgblist[2])
      if min > t
        min = t
        best = value
      endif
    endfor
    return string(index(s:basic16, best))
  enddef
endif
