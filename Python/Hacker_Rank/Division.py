# Task
# The provided code stub reads two integers,  and , from STDIN. Add logic to print two lines. The first line should contain the result of integer division,  // . The second line should contain the result of float division,  / .
# No rounding or formatting is necessary.

if __name__ == '__main__':
    a = int(input())
    b = int(input())
    print(int(a / b), '\n', abs(a / b))
# /n pushes the proceeding code to the next line

