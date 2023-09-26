vim9script
##                       ##
# ::: Fzf Grep Buffer ::: #
##                       ##

import 'fzf-run.vim' as Fzf

var spec = {
  'set_fzf_data': (data) =>
    expand('%:p')->filereadable()
      ? systemlist($"rg --color=ansi --line-number . {expand('%:p')}")->writefile(data)
      : systemlist('echo -n')->writefile(data),

  'set_tmp_file': ( ) => tempname(),
  'set_tmp_data': ( ) => tempname(),

  'geometry': {
    'width': 0.8,
    'height': 0.8
  },

  'commands': {
    'enter': (entry) => $":{entry->split(':')->get(0)}"
  },

  'term_command': [
    'fzf',
    '--no-multi',
    '--delimiter=:',
    '--preview-window=border-left:+{1}-/2',
    '--nth=2..',
    '--ansi',
    '--bind=alt-j:preview-down,alt-k:preview-up,alt-p:toggle-preview',
    '--expect=enter'
  ],

  'set_term_command_options': (data) =>
    [
      $'--preview=bat --color=always --style=numbers --highlight-line={{1}} {expand("%:p")}',
      $"--bind=start:reload^cat '{data}'^",
    ],

  'term_options': {
    'hidden': true,
    'out_io': 'file'
  },

  'popup_options': {
    'title': '─ ::: Fzf Grep Buffer ::: ─',
    'border': [1, 1, 1, 1],
    'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└']
  }
}

command FzfGB Fzf.Run(spec)

# vim: set textwidth=80 colorcolumn=80:
