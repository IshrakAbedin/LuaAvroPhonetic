<!-- Written by Mohammad Ishrak Abedin-->
# LuaAvroPhonetic

A Lua module providing classic (rule-based) transliterator based on [Avro Phonetic](https://en.wikipedia.org/wiki/Avro_Keyboard).

## Optimizations

While the work started as a direct translation of [jsAvroPhonetic](https://github.com/torifat/jsAvroPhonetic), later on, two major optimizations have been added.

1. Using a [`Trie`](./lib/trie.lua) instead of linear search to speed-up pattern finding
2. Avoiding repetitive string concatenations to prevent unnecessary memory allocations

The optimizations are necessary as the library is mainly intended for batch transliteration use cases, like in $\mathrm{\LaTeX}$. The optimizations may provide around 16x to 20x speed up. A portion of the source code is translated using GPT 4o with manual verification, debugging, and corrections afterwards.

If you are looking for a better implementation with dictionary support, you might want to look at [`libavrophonetic`](https://github.com/mugli/libavrophonetic) written in Go by the original author of Avro Phonetic, Mehdi Hasan Khan.

## Example Usage

To use the library, just copy the contents of [`lib`](./lib/) directory to your project location. Some example use cases have been shown in [`example.lua`](./example.lua).

```lua
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
```

Executing the code should produce the following output (make sure your output medium supports Bangla or alternatively write to a unicode file):

```
ভাষা হোক উন্মুক্ত...
আমি বাংলায় গান গাই।
আমাদের ভালোবাসা হয়ে গেল ঘাস, খেয়ে গেল গরু আর দিয়ে গেল বাঁশ!
```

## Tests

The test cases are mainly taken from [jsAvroPhonetic](https://github.com/torifat/jsAvroPhonetic). Considering you have a Lua interpreter installed, you can use [`runtests.sh`](./runtests.sh) or [`runtests.ps1`](./runtests.ps1) script for *\*nix* systems or *Windows* (via Powershell) respectively.

## License
`LuaAvroPhonetic` is released under the terms of the Mozilla Public License 2.0. A copy of the license text is included in [LICENSE](./LICENSE). Online copy can also be found at [MPL 2.0](https://mozilla.org/MPL/2.0/). Copyright (c) 2024 Mohammad Ishrak Abedin.