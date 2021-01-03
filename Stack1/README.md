### STACK1

1. First, the program needs to specify an argument

![Screenshot 2021-01-03 at 12 14 28 AM](https://user-images.githubusercontent.com/32232422/103469129-a6061300-4d15-11eb-9fc3-f1818aeafd0f.png)

2. We can anything as input 

![Screenshot 2021-01-03 at 12 21 54 AM](https://user-images.githubusercontent.com/32232422/103469209-abb02880-4d16-11eb-931d-90095f868f0b.png)

3. Now we can test by giving big amount of input by using python. Note that we can use backtag like `` or $()

![Screenshot 2021-01-03 at 12 25 20 AM](https://user-images.githubusercontent.com/32232422/103469241-1d887200-4d17-11eb-90e1-9833826bb656.png)

4. Based on the output, it said 0x58585858 which means capital 'XXXX'. This means we already overwrite the value. Now we must find the size of the variable. There are two methods:
- Try and error by giving input with different count
- Review the rogram using reverse engineering tools like gdb(linux), hydra, ollydbg(win)

5. First we gonna use try and error step. If we give 70 of 'X', we still overwrite the variable because the output is '0x58585858'. Then we try to give 65, and its become 0x00000058, this means it should be 64. Now when we give 64 characters, it becomes 0x00000000. This means the limit is 64 characters.

![Screenshot 2021-01-03 at 10 14 34 AM](https://user-images.githubusercontent.com/32232422/103476334-7bde4080-4d69-11eb-8086-f0c6ea8ab472.png)
