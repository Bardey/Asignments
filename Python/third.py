# This is not exactly what the task example shows. I also eliminated duplicates,

#def palindrome(string):
#    res = []
#    tmp = ""
#    for charnum in range(1, len(string) + 1):
#        for starting in range(0, len(string)-charnum+1):
#            tmp += string[starting:starting+charnum]
#            if tmp == tmp[::-1]:
#                if tmp not in res:
#                   res.append(tmp)
#            tmp = ""
#    return res
#
# s = "aab"
# print(palindrome(s))

def main(string):
    res = []
    def palCheck(string):
        return string == string[::-1]

    def fn(string, s_list):
        if not string:
            res.append(s_list)
            return
        for i in range(1, len(string)+1):
            if palCheck(string[:i]):
                fn(string[i:], s_list+[string[:i]])
    fn(string, [])
    return res


s1 = "aab"
print(main(s1))
