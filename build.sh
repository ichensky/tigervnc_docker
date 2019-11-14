docker build --build-arg username=$(< /dev/urandom tr -dc a-z | head -c10) -t ichensky/tigervnc:ctrl_r .
