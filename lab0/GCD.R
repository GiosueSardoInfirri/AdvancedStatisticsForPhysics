helper = 0

N1 = readline(prompt="This is a program to evaluate the greatest common divisor\nEnter the first number: ")
n1 = as.integer(N1) # convert the string to a integer
N2 = readline(prompt="Enter the second number: ")
n2 = as.integer(N2) # convert the string to a integer

# In case one inserts before a smaller  number
if (n1 < n2) {
    servo = n1
    n1 = n2
    n2 = servo
}

# While loop searching for the result 
while (n2 >= 1) {
    helper = n2
    n2 = n1 %% n2
    n1 = helper
}

if (as.integer(n1) == 1) {
    print(paste(as.integer(N1), " and ", as.integer(N2), " are coprime"))
} else {
    print(n1)
}
