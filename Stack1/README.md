### STACK1

1. First, the program needs to specify an argument

![Screenshot 2021-01-03 at 12 14 28 AM](https://user-images.githubusercontent.com/32232422/103469129-a6061300-4d15-11eb-9fc3-f1818aeafd0f.png)

2. We can anything as input 

![Screenshot 2021-01-03 at 12 21 54 AM](https://user-images.githubusercontent.com/32232422/103469209-abb02880-4d16-11eb-931d-90095f868f0b.png)

3. Now we can test by giving big amount of input by using python. Note that we can use backtag like `` or $()

![Screenshot 2021-01-03 at 12 25 20 AM](https://user-images.githubusercontent.com/32232422/103469241-1d887200-4d17-11eb-90e1-9833826bb656.png)

4. Based on the output, it said 0x58585858 which means capital 'XXXX'. This means we already overwrite the value. Now we must find the size of the variable. There are two methods:
- Try and error by giving input with different count
- Review the program using reverse engineering tools like gdb(linux), hydra, ollydbg(win)

5. First we gonna use try and error step. If we give 70 of 'X', we still overwrite the variable because the output is '0x58585858'. Then we try to give 65, and its become 0x00000058, this means it should be 64. Now when we give 64 characters, it becomes 0x00000000. This means the limit is 64 characters.

![Screenshot 2021-01-03 at 10 14 34 AM](https://user-images.githubusercontent.com/32232422/103476334-7bde4080-4d69-11eb-8086-f0c6ea8ab472.png)

6. Now we gonna fire up gdb to analyze to understand the behaviour of the program.

![Screenshot 2021-01-03 at 12 15 32 PM](https://user-images.githubusercontent.com/32232422/103478289-59a0ee80-4d7a-11eb-9594-0dc6360e297a.png)

```
gdb -q stack1
```
-q is stand for quiet, means do not print version number on startup.

```
set disassembly-flavor intel
```
This line is for changing syntax, by default it used at&t syntax, but i love intel syntax more lol

7. Now, we wanna disassemble the main function by running:
```
disas main
```

![Screenshot 2021-01-03 at 12 25 16 PM](https://user-images.githubusercontent.com/32232422/103478470-c963a900-4d7b-11eb-9363-3d275bff6caf.png)

8. If we look closely on this line its assign 0 on [esp+0x5c]. It's something like a variable.

![Screenshot 2021-01-03 at 12 31 32 PM](https://user-images.githubusercontent.com/32232422/103478588-8f46d700-4d7c-11eb-91b3-2c578a8804ff.png)

9. Next interesting part is on this line. It tells us that a buffer array start at [esp+1c]. Then it will copy input from user and saved it into buffer 

![Screenshot 2021-01-03 at 12 35 03 PM](https://user-images.githubusercontent.com/32232422/103478655-0f6d3c80-4d7d-11eb-97e5-54c7884799c2.png)

10. We know that a variable with 0 value is declared on [esp+5c] and a buffer array start on [esp+1c]. So now we can calculate the size of the buffer which is 5c(hex) - 1c(hex) = 64(int). I calculate it using python

![Screenshot 2021-01-03 at 1 03 00 PM](https://user-images.githubusercontent.com/32232422/103479201-f797b780-4d80-11eb-9e41-ce1341a38794.png)

11. On [main+67], it put the value from [esp+5c] into eax, which is 0. Then compare eax with 0x61626364. This is 'abcd' from hex to ascii, but due to the little endianness it will be inverse like 'dcba'.

![Screenshot 2021-01-03 at 3 50 03 PM](https://user-images.githubusercontent.com/32232422/103482920-8cf27600-4d98-11eb-8a54-99e0bb30a6b6.png)

12. Now we can craft our payload by providing 64byte of any characters + 'dcba' to change the [esp+5c]. 
```
./stack1 $(python -c "print 'X' * 64 + 'dcba'")
```

![Screenshot 2021-01-03 at 4 01 42 PM](https://user-images.githubusercontent.com/32232422/103483168-4b62ca80-4d9a-11eb-8218-5719c0a0d865.png)

- [x] Now we succeed, then you guys can review the source code

![Screenshot 2021-01-03 at 4 09 06 PM](https://user-images.githubusercontent.com/32232422/103483280-fbd0ce80-4d9a-11eb-9844-a5d9d6a96916.png)
