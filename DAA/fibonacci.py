# Recursive Fibonacci
def fibonacci_recursive(n):
    if n == 0 or n == 1:
        return n
    return fibonacci_recursive(n-1) + fibonacci_recursive(n-2)
n = 10
print("Recursive Fibonacci of", n, ":", fibonacci_recursive(n))

# Non-Recursive, Iterative Fibonacci
def fibonacci_iterative(n):
    if n == 0:
        return 0
    a, b = 0, 1
    for _ in range(2, n+1):
        print("Iterating:", a)
        a, b = b, a + b
    return b 

# Test
n = 10
print("Iterative Fibonacci of", n, ":", fibonacci_iterative(n))

#Updated fibonacci

# Recursive Fibonacci
def fib_recursive(n):
    if n <= 1:
        return n
    else:
        return fib_recursive(n-1) + fib_recursive(n-2)

# Iterative Fibonacci
def fib_iterative(n):
    a, b = 0, 1
    for i in range(n):
        print(a, end=" ")
        a, b = b, a + b

n = int(input("Enter number of terms: "))

print("Recursive Fibonacci:")
for i in range(n):
    print(fib_recursive(i), end=" ")

print("\nIterative Fibonacci:")
fib_iterative(n)
