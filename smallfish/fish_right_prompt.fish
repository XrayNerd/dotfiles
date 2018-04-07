
set -x left_arrow_glyph    \uE0B2
set -x space               \u205F

function get_git_status -d "Gets the current git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git describe --tags --exact-match ^/dev/null ; or command git symbolic-ref --short HEAD 2> /dev/null ; or command git rev-parse --short HEAD 2> /dev/null)

    if [ "$dirty" != "0" ]
      set_color -b normal
      set_color red
      echo "$dirty changed file"
      if [ "$dirty" != "1" ]
        echo "s"
      end
      echo " "
      set_color red
      echo -ns $left_arrow_glyph
      set_color -b red
      set_color white
    else
      set_color green
      echo -ns $left_arrow_glyph
      set_color -b green
      set_color white
    end

    echo " $ref "
    set_color normal
   end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  if [ -w "$PWD" ]
    prompt_segment normal blue "$pad$pwd "
  else
    prompt_segment normal red "$pad$pwd "
  end
end

function fish_right_prompt -d "Prints right prompt"
  show_pwd
  get_git_status
end
