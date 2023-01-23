# 三目並べFSM
## 動作確認方法
以下のコマンドを実行することにより動作確認ができる。なお`test.sv` に一切変更を加えない場合はユーザが負けるようになっている。
```sh
iverilog -Wall -g2012 ./code/test.sv ./code/sanmoku.sv
./a.out
```
一切変更を加えない場合の出力は以下のようになる。
```
state = 000000000000000000000001 isNotEnd = 1 userWins = 0
-------
| | | |
-------
| |o| |
-------
| | | |
-------
state = 000000000000000000000010 isNotEnd = 1 userWins = 0
-------
|o|x| |
-------
| |o| |
-------
| | | |
-------
state = 000000000000000000010000 isNotEnd = 0 userWins = 0
-------
|o|x|x|
-------
| |o| |
-------
| | |o|
-------
You Lose
```
自分の手を変更したい場合は`test.sv`を変更すればよい。詳細はレポートに譲るが以下の部分が変更箇所にあたる。
```sv
  localparam FIRST = 1;
  localparam SECOND = 2;
  localparam THIRD = 4;
  localparam FOURTH = 8;
```
手動でやるのが面倒な場合`create_test.c`ファイルが利用できる。
```sh
gcc -O3 create_test.c
./a.out
```
上記のコマンドを実行し表示される指示文に従えば、自分の手を任意に変更でき、かつシミュレータの実行を自動で行うことができる。