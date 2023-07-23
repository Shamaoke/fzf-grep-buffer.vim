vim9script
##                       ##
# ::: Fzf Grep Buffer ::: #
##                       ##

import 'fzf-run.vim' as Fzf

var spec = {
  'fzf_default_command': $FZF_DEFAULT_COMMAND,

  'set_fzf_data': ( ) => expand('%:p')->filereadable() ? $"rg --color=ansi --line-number . {expand('%:p')}" : 'echo -n',

  'set_fzf_command': (data) => $"{data} || exit 0",

  'set_tmp_file': ( ) => tempname(),

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
    '--nth=2',
    '--ansi',
    '--bind=alt-j:preview-down,alt-k:preview-up',
    '--expect=enter'
  ],

  'set_term_command_options': ( ) =>
    [
      $'--preview=bat --color=always --style=numbers --highlight-line={{1}} {expand("%:p")}'
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
