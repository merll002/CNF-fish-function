function fish_command_not_found
    set BR (set_color --bold red)
    set BG (set_color --bold green)
    set B (set_color blue)
    set BB (set_color --bold blue)
    set BY (set_color --bold yellow)
    set RESET (set_color normal)
    read -P " Search for package in repositories?$BY [y/n] $RESET" -n 1 search
    echo  
    switch (string lower "$search")
        case y
            set continue 1
        case '*'
            return 1
    end
    if test $continue -eq 1
    end
    set package_name (pacman -Fq "/usr/bin/$argv[1]" 2>/dev/null | head -n 1)
    if test -z "$package_name"
        printf "$BR Couldn't find the package containing the$B $argv[1]$BR command.\n"
        return 1
    end
    printf "$BG Command$B $argv[1]$BG not found, but was found in the$BY $package_name$BG package.\n"
    read -P " Would you like to install it?$BY [y/n] $RESET" -n 1 confirm
    switch (string lower "$confirm")
        case y
            yay -S --needed "$package_name"
    end
end
