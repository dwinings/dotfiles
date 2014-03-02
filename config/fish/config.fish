bind \ea backward-word
bind \ee forward-word

function fish_prompt --description  "My good old bash prompt"
  set_color $fish_color_cwd
  set_color --bold white
  echo -n '['
  set_color --bold magenta
  echo -n (whoami)
  set_color --bold white
  echo -n '@'
  set_color --bold blue
  echo -n (hostname)
  echo -n ' '
  set_color --bold green
  echo -n (basename (prompt_pwd))
  set_color --bold white
  echo ']'
  set_color white
  echo -n " └─"
  set_color --bold white
  echo -n " \$ "
  set_color normal
end

function irc
  weechat-curses 'irc://Wisp|Working:Durandal@irc.ecnet.org:6669/#wispchannel'

end

function fish_greeting
end

function fish_title
  true
end

begin
  rvm
end > /dev/null

function sgdiff -d "Git diff with locate"
  git diff (locate $argv)
end

function sgadd
  git add (locate $argv)
end

function sgco
  git checkout (locate $argv)
end

function pwdloc
  locate -r (pwd)".*/"$argv
end

function speak
  tmux send -t irc "$argv" C-m
end

function dmenu_speak
  speak (tail -n 5 ~/.weechat/logs/irc.irc.ecnet.org.\#wispchannel.weechatlog | sed -u "s/^[a-zA-Z0-9:-]* *[a-zA-Z0-9:-]*[ \t]*//" | sed -u "s/\t/:  /"    | pmenu -l 5)
end

function ll
 ls -lahrt $argv
end


set -x JAVA_HOME /usr/lib/jvm/j2sdk1.6-oracle
set PATH /home/wisp/.scripts /usr/local/bin $PATH
