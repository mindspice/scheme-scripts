# scheme-scripts
Collections of various scheme utility scrips for daily uses. Mainly for learning, a lot of this could be implemented in bash or more efficiently in another language. I am writing these in scheme for more hands-on experience.

All scripts are in the kawa dialect of scheme.


# Script descriptions

## GOTO
Provides a simple means to navigate to a specific directory given a saved key-path pair, uses a bash alias on return to cd to the directory.

```goto <key>```

```goto --add-path <key> <path>```

```goto --remove-path <key-to-remove>```


## CONN
Scheme script is the same as goto other than terminal output and argument syntax. Used with the bash alias to connect to a saved ssh host for a given key

```conn <key>```

```conn --add-host <key> <host>```

```goto --remove-host <key-to-remove>```
