ignored_files=".git"

for file in .*; do
    ! [[ ":$ignored_files:" = *:$file:* ]] && ln -s "dotfiles/$file" "../$file"
done
