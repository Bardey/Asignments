
def longest_substr(string):
    max_length = 5*10**4
    isEnglish = string.encode('utf-8')
    if len(string) > max_length or len(string) < len(isEnglish):
        raise('You either entered an oversized string or used forbidden characters')
    longest = ""
    for letter in range(0, len(string)):
        substr_demo = ""
        substr_demo += string[letter]
        for i in range(letter + 1, len(string)):
            if string[i] in substr_demo:
                break
            else:
                substr_demo += string[i]

        if len(substr_demo) > len(longest):
            longest = substr_demo

    return longest, len(longest)


s1 = "pwkeweAOKQ"
print('The longest substring is: "{}" with {} letter(s)'.format(longest_substr(s1)[0], longest_substr(s1)[1]))

