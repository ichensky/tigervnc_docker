from debian:buster

env username=bob
run username=$(< /dev/urandom tr -dc a-z | head -c10)
run cat /etc/apt/sources.list | grep "^deb " | sed 's/^deb /deb-src /' >> /etc/apt/sources.list
run apt-get update
run apt-get build-dep -y tigervnc-viewer
run apt-get install -y fakeroot
run useradd -m -d /home/$username -s /bin/bash $username; 
user $username
run mkdir /home/$username/tmp
workdir /home/$username/tmp

run apt-get source tigervnc-viewer

copy ctrl_r.patch ./

run cd $(ls -d tigervnc-*/) ; quilt import ../ctrl_r.patch ; quilt push

run cd $(ls -d tigervnc-*/) ; dpkg-buildpackage -rfakeroot -uc -b

entrypoint cat $(ls tigervnc-viewer_*)
