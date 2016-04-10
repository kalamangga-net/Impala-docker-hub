# Enable core dumps.
ulimit -c unlimited

export IMPALA_HOME=/home/dev/Impala
export IMPALA_TOOLCHAIN=/opt/Impala-Toolchain
export IMPALA_LZO=/home/dev/Impala-lzo
export HADOOP_LZO=/home/dev/hadoop-lzo

# Add the user's bin dir and the Impala bin dirs. On some systems regular user don't
# have /sbin in their path by default but /sbin useful and all users have sudo.
PATH="$HOME/bin:$PATH:$IMPALA_HOME/bin:$IMPALA_HOME/testdata/bin:/sbin"

# These are set by the docker build script.
export JAVA_HOME=###JAVA_HOME###

# The data loading will be done by the dev user and hadoop permissions will fail if the
# user is not "dev". Without explicitly overriding this, the $USER on some OSs (ex:
# Ubuntu) would be the user name used to SSH in.
USER=dev

# In case this script is not run through SSH, use the $HOME dir to get what would be
# the SSH user name.
export SSH_USER=$(basename $HOME)
# Used by $HOME/bin/git-add-my-remotes, override as needed in $HOME/.extra_bashrc.
export GERRIT_SSH_USER=$SSH_USER
# Used by $HOME/bin/git-add-my-remotes, override as needed in $HOME/.extra_bashrc.
export INTERNAL_GITHUB_USER=$SSH_USER

if [[ -n "$PS1" ]]; then
  # Start the prompt with the last number group in the IP. The assumption is people
  # are using a fixed subnet like 192.168.123.
  PS1="$USER@$(awk -F. '{print $4}' <<< $(docker-ip))"':\w\$ '
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -f $HOME/.extra_zshrc ]]; then
  source $HOME/.extra_zshrc
fi
