ignored_files=".git"

for file in .*; do
    if ! [[ ":$ignored_files:" = *:$file:* ]] ; then
        ln -s "dotfiles/$file" "../$file"
    fi
done
