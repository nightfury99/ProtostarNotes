## STACK_0

1. This is quiet easy, we just try to put any input to overflow the application.
![Screenshot 2020-12-22 at 7 08 47 AM](https://user-images.githubusercontent.com/32232422/102859850-9a475200-43e1-11eb-86df-7609901dad76.png)

2. Lets see the source code
![Screenshot 2020-12-22 at 7 21 01 AM](https://user-images.githubusercontent.com/32232422/102860690-32920680-43e3-11eb-83f7-99289e0c291b.png)

- If we look at the source code, first it will declare a _buffer_ with 64 char size and initialize variable _modified_ = 0

- Then on line 11, it will take input from the user and store it into _buffer_ variable

- On line 13, the program will check if _modified_ variable is not equal to 0, it'll print the message, else print 'try again'

- Thus, if we supply with big input more than 64 byte of character, it will overwrite the _modified_ variable
