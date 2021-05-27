#!/usr/bin/env python3

def convert(string):
    string = string.replace(" ̈", "¨")
    string = string.replace(" ̧", "¸")
    string = string.replace(" ̄", "¯")
    string = string.replace("\\", "\\\\")
    string = string.replace('"', '\"')
    return string

def choice(question):
    ch = input(question)
    while ch.upper() not in ["Y", "YES", "N", "NO"]:
        ch = input("WRONG ENTRY! RETRY: ")
    if ch.upper() == "Y" or ch.upper() == "YES":
        return True
    else:
        return False

f = open("output.json", "w")
f.write('    "prayers": {\n')
mystr = ''
while True:
    mystr += '        "'
    mystr += input("ShortName: ")
    mystr += '": {\n            "Name": "'
    mystr += convert(input("Name: "))
    mystr += '",\n            "Prayer": ["'
    mystr += convert(input("Prayer: "))
    while choice("Add More Pages: "):
        mystr += '","'
        mystr += convert(input("Prayer: "))
    mystr += '"]\n        }'
    print("current entry: ", mystr)
    if  choice("Is the entry correct? "):
        f.write(mystr)
    if not choice("Add More Entries? "):
        break
    mystr = ',\n'
f.close()

