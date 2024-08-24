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

  This Original Code is LuaAvroPhonetic.
    The Initial Developer of the Original Code is 
    Mohammad Ishrak Abedin <ishrak.abedin.a1@gmail.com> <ishrakabedin@iut-dhaka.edu>
    Copyright (c) 2024 Mohammad Ishrak Abedin
--]]


local Trie = {}
Trie.__index = Trie

function Trie:new(patterns)
    local instance = setmetatable({}, Trie)
    instance.root = { key = 0, pattern = nil, next = {} }
    instance:buildTrie(patterns)
    return instance
end

function Trie:buildTrie(patterns)
    self.root = { key = 0, pattern = nil, next = {} }
    for _, pattern in ipairs(patterns) do
        local currentTrie = self.root
        local find = pattern.find
        for j = 1, #find do
            local char = find:byte(j)

            if currentTrie.next[char] == nil then
                currentTrie.next[char] = { key = char, pattern = nil, next = {} }
            end
            currentTrie = currentTrie.next[char]

            if j == #find then
                currentTrie.pattern = pattern
            end
        end
    end
end

function Trie:findInTrie(str)
    local currentTrie = self.root
    for i = 1, #str do
        local char = str:byte(i)
        if currentTrie.next[char] == nil then
            break
        end
        currentTrie = currentTrie.next[char]
    end

    return currentTrie.pattern
end

return Trie
