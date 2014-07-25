for i in 1 2 3 4 5 6
do
cowsay `echo "$E[47;32;7mI will stop awubuntum${i} vm  $E[0m"`
azure vm shutdown awubuntum${i}
done
