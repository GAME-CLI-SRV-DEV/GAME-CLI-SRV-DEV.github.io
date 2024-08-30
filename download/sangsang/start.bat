echo off
chcp 65001
echo 상상서버를 시작하는 중입니다.
set 최소메모리=128
set 최대메모리=2988
set 메모리단위=M
java -XMs%최소메모리%%메모리단위% -jar%최소메모리%%메모리단위%
