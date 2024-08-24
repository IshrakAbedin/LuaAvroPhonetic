--[[ 
  This file is part of LuaAvroPhonetic.
  
  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
  If a copy of the MPL was not distributed with this file,
  You can obtain one at https://mozilla.org/MPL/2.0/.
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  This Translated and Optimized Code is LuaAvroPhonetic.
    The Initial Developer of This Code is
    Mohammad Ishrak Abedin <ishrak.abedin.a1@gmail.com> <ishrakabedin@iut-dhaka.edu>
    Copyright (c) 2024 Mohammad Ishrak Abedin

  The Original Code is jsAvroPhonetic.
    The Initial Developer of the Original Code is 
    Rifat Nabi <to.rifat@gmail.com>
    Copyright (c) OmicronLab <http://www.omicronlab.com>. All Rights Reserved.
    Contributor(s): Mehdi Hasan <mhasan@omicronlab.com>
--]]


local Trie = require("lib.trie")
local Data = require("lib.data")

local OmicronLab_Avro_Phonetic = {}
OmicronLab_Avro_Phonetic.__index = OmicronLab_Avro_Phonetic

-- Constructor
function OmicronLab_Avro_Phonetic:new(userdata)
    local instance = setmetatable({}, OmicronLab_Avro_Phonetic)
    instance.data = userdata or Data
    instance.trie = Trie:new(instance.data.patterns)
    return instance
end

-- Method to parse the input string
function OmicronLab_Avro_Phonetic:parse(input)
    local fixed = self:fixString(input)
    local output = {}
    local cur = 1

    while cur <= #fixed do
        local start, end_pos, prev = cur, cur + 1, cur - 1

        -- max look up is 5 characters as the largest pattern is of size 5
        local pattern = self.trie:findInTrie(fixed:sub(start, start + 5))
        if pattern ~= nil then
            end_pos = cur + #pattern.find - 1
            prev = start - 1
            local matched = false

            if pattern.rules then
                for j = 1, #pattern.rules do
                    local rule = pattern.rules[j]
                    local replace = true

                    for k = 1, #rule.matches do
                        local match = rule.matches[k]
                        local chk

                        if match.type == "suffix" then
                            chk = end_pos + 1
                        else
                            chk = prev
                        end

                        match.negative = match.negative or false
                        if match.scope:sub(1, 1) == "!" then
                            match.negative = true
                            match.scope = match.scope:sub(2)
                        end

                        match.value = match.value or ""

                        if match.scope == "punctuation" then
                            if (not (
                                        ((chk < 1 and match.type == "prefix") or
                                            (chk > #fixed and match.type == "suffix") or
                                            self:isPunctuation(fixed:sub(chk, chk))))
                                    ~= match.negative
                                ) then
                                replace = false
                                break
                            end
                        elseif match.scope == "vowel" then
                            if (not (
                                    (
                                        (chk >= 1 and match.type == "prefix") or
                                        (chk <= #fixed and match.type == "suffix")
                                    ) and
                                    self:isVowel(fixed:sub(chk, chk))
                                )) ~= match.negative then
                                replace = false
                                break
                            end
                        elseif match.scope == "consonant" then
                            if (not (
                                    (
                                        (chk >= 1 and match.type == "prefix") or
                                        (chk <= #fixed and match.type == "suffix")
                                    ) and
                                    self:isConsonant(fixed:sub(chk, chk))
                                )) ~= match.negative then
                                replace = false
                                break
                            end
                        elseif match.scope == "exact" then
                            local s, e
                            if match.type == "suffix" then
                                s = end_pos + 1
                                e = end_pos + #match.value
                            else
                                s = start - #match.value
                                e = start - 1
                            end
                            if not self:isExact(match.value, fixed, s, e, match.negative) then
                                replace = false
                                break
                            end
                        end
                    end

                    if replace then
                        table.insert(output, rule.replace)
                        cur = end_pos
                        matched = true
                        break
                    end
                end
            end

            if not matched then
                table.insert(output, pattern.replace)
                cur = end_pos
                matched = true
            end
        else
            table.insert(output, fixed:sub(cur, cur))
        end

        cur = cur + 1
    end

    return table.concat(output)
end

-- Method to fix the input string
function OmicronLab_Avro_Phonetic:fixString(input)
    local fixed = {}
    for i = 1, #input do
        local cChar = input:sub(i, i)
        if self:isCaseSensitive(cChar) then
            table.insert(fixed, cChar)
        else
            table.insert(fixed, cChar:lower())
        end
    end
    return table.concat(fixed)
end

-- Method to check if a character is a vowel
function OmicronLab_Avro_Phonetic:isVowel(c)
    return self.data.vowel:find(c:lower(), 1, true) ~= nil
end

-- Method to check if a character is a consonant
function OmicronLab_Avro_Phonetic:isConsonant(c)
    return self.data.consonant:find(c:lower(), 1, true) ~= nil
end

-- Method to check if a character is punctuation
function OmicronLab_Avro_Phonetic:isPunctuation(c)
    return not (self:isVowel(c) or self:isConsonant(c))
end

-- Method to check for an exact match
function OmicronLab_Avro_Phonetic:isExact(needle, heystack, start, end_pos, not_flag)
    return (start >= 1 and end_pos <= #heystack and heystack:sub(start, end_pos) == needle) ~= not_flag
end

-- Method to check if a character is case-sensitive
function OmicronLab_Avro_Phonetic:isCaseSensitive(c)
    return self.data.casesensitive:find(c:lower(), 1, true) ~= nil
end

return OmicronLab_Avro_Phonetic
