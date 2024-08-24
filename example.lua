-- Import the library
local avro = require("lib.avro")

-- Create an instance of Avro
local phonetic = avro.new(nil)

-- Sample input string
local inputString = "BHaSHa hOk unmukto..."

-- Use the `parse` method with a string variable or literal
local result1 = phonetic:parse(inputString)
local result2 = phonetic:parse("ami banglay gan gai.")
local result3 = phonetic:parse("amader valObasa hoye gel ghas, kheye gel goru ar diye gelo ba^sh!")

-- Print the results (output should support Bangla display)
print(result1)
print(result2)
print(result3)
