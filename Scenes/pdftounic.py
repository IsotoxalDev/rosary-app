#!/usr/bin/env python3
import pyperclip
str = input("to convert: ")
str = str.replace(" ̈", "¨")
str = str.replace(" ̧", "¸")
str = str.replace(" ̄", "¯")
str = str.replace("\\", "\\\\")
str = str.replace('"', '\"')
pyperclip.copy(str)
print("COPIED!!")
