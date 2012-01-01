" native2ascii.vim - native2ascii
" author:       glix <gleexpp@gmail.com>
" version:      0.1
" description:  convert all characters in current buffer whose unicode value are greater than 256
"               into the form '\uxxxx', a simulation of native2ascii if you know it.

if !has('python')
  echo 'Vim compiled with +python required!'
  finish
endif

func! Native2ascii()
  let encoding = a:0 == 1 ? a:1 : 'UTF-8'

python << EOF
import vim 

current_buffer = vim.current.buffer
count_of_lines = len(current_buffer)
def my_to_unicode(c):
  uc = ord(c)
  if uc > 256:
    return "\u" + str(uc)
  return c

enc = vim.eval('encoding')
for ix in range(0,count_of_lines):
  current_line = current_buffer[ix].strip()
  if current_line.find('#') != 0:
    cnt = cnt + 1
    converted = ''.join(map(my_to_unicode,unicode(current_line,enc)))
    current_buffer[ix] = str(converted)
EOF

endfunc
