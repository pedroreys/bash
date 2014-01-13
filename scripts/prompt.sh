custom_prompt(){
	local STATUS=`git status 2>/dev/null`
	
	local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
  
  if [[ "$BRANCH" = "" ]]; then
    BRANCH=`git status 2> /dev/null | grep "On branch" | sed 's/# On branch //'`
  fi
  
  local PROMPT_COLOR=$GREEN
  local STATE=" "
  local NOTHING_TO_COMMIT="# Initial commit"
  local BEHIND="# Your branch is behind"
  local AHEAD="# Your branch is ahead"
  local UNTRACKED="# Untracked files:"
  local DIVERGED="have diverged"
  local CHANGED="# Changed but not updated"
  local TO_BE_COMMITED="# Changes to be committed"
  local CHANGES_NOT_STAGED="# Changes not staged for commit"
  local LOG=`git log -1 2> /dev/null`


    if [[ "$STATUS" = "$CHANGES_NOT_STAGED" ]];then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" = "$NOTHING_TO_COMMIT" ]];then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" = "$DIVERGED" ]];then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}?${NO_COLOR}"
    elif [[ "$STATUS" = "$BEHIND" ]];then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}?${NO_COLOR}"
    elif [[ "$STATUS" = "$AHEAD" ]];then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}?${NO_COLOR}"
    elif [[ "$STATUS" = "$CHANGED" ]];then
      PROMPT_COLOR=$RED
      STATE="${STATE}${LIGHT_BLUE}!${NO_COLOR}"
    elif [[ "$STATUS" = "$TO_BE_COMMITED" ]];then
      PROMPT_COLOR=$RED
      STATE=""
    else
      PROMPT_COLOR=$GREEN
      STATE=""
    fi

    if [[ "$STATUS" = "$UNTRACKED" ]];then
      STATE="${STATE}${YELLOW}*${NO_COLOR}"
    fi

    local GIT_PROMPT="[${YELLOW}git${NO_COLOR} ${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}${NO_COLOR}] "
	
	
	if [[ "$STATUS" != "" ]];then
		PS1="\n${GIT_PROMPT} ${YELLOW}\w\a${NO_COLOR} \n\$ "
	else
		PS1="\n${YELLOW}\w\a${NO_COLOR}\n\$ "
	fi
}

FG_GRAY="30"
FG_RED="31"
FG_GREEN="32"
FG_YELLOW="33"
FG_BLUE="34"
FG_VIOLET="35"
FG_CYAN="36"
FG_WHITE="37"

ESC="\033"
LIGHT="1"
DULL="0"

export NO_COLOR="\[\e[0m\]"


export GRAY="\[$ESC[${LIGHT};${FG_GRAY}m\]"
export RED="\[$ESC[${DULL};${FG_RED}m\]"
export GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
export YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
export BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
export VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
export CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
export WHITE="\[$ESC[${LIGHT};${FG_WHITE}m\]"

export LIGHT_GRAY="\[$ESC[${DULL};${FG_WHITE}m\]"
export LIGHT_RED="\[$ESC[${LIGHT};${FG_RED}m\]"
export LIGHT_GREEN="\[$ESC[${LIGHT};${FG_GREEN}m\]"
export LIGHT_YELLOW="\[$ESC[${LIGHT};${FG_YELLOW}m\]"
export LIGHT_BLUE="\[$ESC[${LIGHT};${FG_BLUE}m\]"
export LIGHT_VIOLET="\[$ESC[${LIGHT};${FG_VIOLET}m\]"
export LIGHT_CYAN="\[$ESC[${LIGHT};${FG_CYAN}m\]"

PROMPT_COMMAND=custom_prompt
