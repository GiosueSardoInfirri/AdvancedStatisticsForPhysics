n1 = 0
n2 = 0
out = 1
i = 1

n = readline(prompt="This is a program to evaluate the any Fibonacci number\nEnter the number of the Fibonacci sequence you want to evaluate: ")
n = as.integer(n) # convert the string to a integer

# Loop that prevedes to save the informations in three variables
while (i < n) {
    n1 = n2;
    n2 = out;
    out = out + n1;
    i = i + 1;
}

print(out)
