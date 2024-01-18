function goto() {
    dir=$(kawa /home/mindspice/.scripts/scheme/goto.scm "$@")
    if [ -d "$dir" ]; then
        cd "$dir"
    else
        echo "$dir"  # Or handle the error however you prefer
    fi
}


function conn() {
    ssh_dest=$(kawa /home/mindspice/.scripts/scheme/conn.scm "$@")
    if [[ "$ssh_dest" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+$ ]]; then
        ssh "$ssh_dest"
    else
        echo "$ssh_dest"  # Display the message returned by the Scheme script
    fi
}

