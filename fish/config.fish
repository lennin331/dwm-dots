if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
    set -gx ADW_DISABLE_PORTAL 1
    fish_add_path ~/.local/bin
end
