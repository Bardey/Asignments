def paranteses_comb(n):
    if n < 1:
        return "Give me a realistic task"
    elif n > 8:
        return "Are you trying to kill this computer??"

    parantheses = []
    res = []

    def recursion_func(opening, closing):
        if opening == closing == n:
            res.append("".join(parantheses))
            return

        if opening < n:
            parantheses.append("(")
            recursion_func(opening + 1, closing)
            parantheses.pop()

        if opening > closing:
            parantheses.append(")")
            recursion_func(opening, closing + 1)
            parantheses.pop()
    recursion_func(0,0)
    return res

n = 5
print(paranteses_comb(n))
