set -e

[ ! -z "$DKR_HOME" ] && (echo DKR_HOME is already exported; exit)

export DKR_HOME=$HOME/.dkr

#force a clean install
rm -fr $DKR_HOME
mkdir -p $DKR_HOME

git clone https://github.com/2mia/dkr $DKR_HOME

FILES="$HOME/.bashrc $HOME/.profile"
for FILE in $FILES; do 
    [ -f $FILE ] && (
        TO_ADD="source $DKR_HOME/aliases.sh"
        if ( grep "$TO_ADD" $FILE ); then
            echo already added to $FILE
            exit 0
        else
            [[ -d /etc/coreos/ ]] && ( unlink $FILE && echo source /usr/share/skel/`basename $FILE` >> $FILE)
            echo $TO_ADD >> $FILE
            echo added to $FILE
            exit 0
        fi
    ) 
done

source $DKR_HOME/aliases.sh
