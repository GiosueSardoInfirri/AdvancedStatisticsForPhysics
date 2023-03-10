n = readline(prompt="This is a program to factorize a number\nEnter the number: ")
n = as.integer(n) # convert the string to a integer

divisori = 1
f = 2

# While loop to search the divisors
while (n > 1) {
    if ((n %% f) == 0){ # If it is a divisor
        n = n / f
        divisori = c(divisori, f)
    } else { # else it increases the number to search
        f = f + 1
    }
}

print(divisori)

# It takes a second to evaluate 27644437