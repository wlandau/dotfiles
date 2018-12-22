git config --global user.name "wlandau"
git config --global user.email "will.landau@gmail.com"
ssh-keygen -t rsa -b 4096 -C "will.landau@gmail.com"
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
