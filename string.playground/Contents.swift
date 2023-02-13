//: [Previous](@previous)

import Foundation
 

//: [13. 罗马数字转整数](https://leetcode.cn/problems/roman-to-integer/)
func romanToInt(_ s: String) -> Int {
//    var map : [String : Int] = ["I" : 1 , "V" : 5 , "X" : 10 ,"L" : 50 , "C" : 100 , "D" : 500 , "M" : 1000]
    
    func getValue( _ c : Character) -> Int {
        switch c {
        case "I" : return 1
        case "V" : return 5
        case "X" : return 10
        case "L" : return 50
        case "C" : return 100
        case "D" : return 500
        case "M" : return 1000
        default:   return 0
        }
    }
    
    var sum = 0
    var last = Int.max
    
    for a in s{
        print(a)
        let value = getValue(a)
        if(last < value) {
            sum -= 2 * last
        }
        sum += value
        last = value
    }
    
    return sum
}



//[14. 最长公共前缀]

func longestCommonPrefix(_ strs: [String]) -> String {
    
    if strs.count < 1 {
        return ""
    }
    let first = strs[0]
    let length = first.count
    var index = 0
    var p = first
    while(index < length){
        let endIndex = first.index(first.startIndex,offsetBy: index)
        let prex = first[first.startIndex...endIndex]
        for str in strs {
            if str == first {
                continue
            }
            
            if(index >= str.count  || str[str.startIndex...endIndex] != prex){
                return p
            }
        }
        p = String(prex)
        index += 1
    }
    
    return p
}


//print(longestCommonPrefix(["ab", "a"]))


// [20. 有效的括号]

func isValid(_ s: String) -> Bool {
    if s.count%2 != 0 {
        return false
    }
    
    var str = s
    str.replace("{}", with: "")
    str.replace("[]", with: "")
    str.replace("()", with: "")
    return str.isEmpty
 
}

//print(isValid("[](){}}{"))



//[58. 最后一个单词的长度]

func lengthOfLastWord(_ s: String) -> Int {
    var end = s.count - 1
    let cs = Array(s)
    while cs[end] == " "  {
        end -= 1
        if end < 0 {
            break
        }
    }
    
    var start = end
    while cs[start] != " " {
        start -= 1
        if start < 0 {
            break
        }
    }
    return end - start
}


// [67. 二进制求和]

func addBinary(_ a: String, _ b: String) -> String {
    var a = a, b = b
    var step = false
    var newS : String = ""
    var count = a.count > b.count ? a.count : b.count
    var la = "0"
    var lb = "0"
    var value = 0
    while count > 0 {
        la = "0"
        lb = "0"
        if a.count > 0 {
            la = String(a.removeLast())
        }
        if b.count > 0 {
            lb = String(b.removeLast())
        }
        value = Int(la)! + Int(lb)! + (step ? 1 : 0)
        step = value >= 2
        newS = String(value%2) + newS
        count -= 1
        print(step,value,newS)
    }
    if step {
        newS = "1" + newS
    }
 
    return newS
}

//print( addBinary("1111", "1111"))

// [125. 验证回文串]

func isPalindrome(_ s: String) -> Bool {
    let cs = Array(s.lowercased())
    var start = 0
    var end = s.count - 1
    var begin : Character
    var last : Character
    while end >= start {
        begin = cs[start]
        last = cs[end]
        if !(begin >= "a" && begin <= "z" || begin >= "0" && begin <= "9") {
            start += 1
            continue
        }
        if !((last >= "a" && last <= "z") || (last >= "0" && last <= "9")) {
            end -= 1
            continue
        }
        print(begin,last)
        if begin != last {
            break
        }
        start += 1
        end -= 1
    }
    
    return end <= start
}

//print(isPalindrome( "aaaa"))
 
//let a : Character = "0"
//let b : Character = "P"
//print(a.asciiValue,b.asciiValue)

//[168. Excel表列名称]

//26进制 但是没有0 所以在求余数时先减去1,达到满26进一位的效果
/*
 这是一道从 11 开始的的 26 26 进制转换题。

 对于一般性的进制转换题目，只需要不断地对 columnNumbercolumnNumber 进行 % 运算取得最后一位，然后对 columnNumbercolumnNumber 进行 / 运算，将已经取得的位数去掉，直到 columnNumbercolumnNumber 为 00 即可。

 一般性的进制转换题目无须进行额外操作，是因为我们是在「每一位数值范围在 [0,x)[0,x)」的前提下进行「逢 xx 进一」。

 但本题需要我们将从 11 开始，因此在执行「进制转换」操作前，我们需要先对 columnNumbercolumnNumber 执行减一操作，从而实现整体偏移。

 作者：AC_OIer
 链接：https://leetcode.cn/problems/excel-sheet-column-title/solution/gong-shui-san-xie-cong-1-kai-shi-de-26-j-g2ur/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
func convertToTitle(_ columnNumber: Int) -> String {
    var str = ""
    var columnNumber = columnNumber
    let A : Character = "A"
    var c : Character
    while columnNumber > 0  {
        columnNumber -= 1
        let res : UInt8 = UInt8(columnNumber%26)
 
        c = Character(UnicodeScalar(A.asciiValue! + res))
        str.append(c)
        columnNumber/=26
        
    }
    return String(str.reversed())
}

//print( convertToTitle(2147483647))


//[171. Excel 表列序号]
func titleToNumber(_ columnTitle: String) -> Int {
    var cou = columnTitle
    var index = 0
    var nex = 1
    var value : Int = 0
    var add : Int = 1
    var sum : Int = 0
    while cou.count > 0 {
        value = Int(cou.removeLast().asciiValue! - 64)
        nex = index
        while nex > 0 {
            add *= 26
            nex -= 1
        }
        print(value,add)
        sum += (value * add)
        index += 1
        add = 1
    }
    return sum
}

//print(titleToNumber("FXSHRXW"))

//[205. 同构字符串]
/*
 给定两个字符串 s 和 t ，判断它们是否是同构的。

 如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。

 每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。



 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/isomorphic-strings
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    var s = Array(s)
    var t = Array(t)
    var map : [Character : Character] = [:]
    var sc : Character
    var tc : Character
    var countA : [Int] = Array(repeating: 0, count: 128)
    var index = 0
    while index < s.count {
        sc = s[index]
        tc = t[index]
        print(sc,tc)
        if !map.keys.contains(sc){
            map[sc] = tc
            countA[Int(tc.asciiValue!)] += 1
        }
        index += 1
    }
    
    index = 0
    
    while index < s.count {
        sc = s[index]
        tc = t[index]
        if countA[Int(tc.asciiValue!)] > 1 {
            return false
        }
        
        if map[sc] != tc {
            return false
        }
        index += 1
    }
    
    return true
}

//print(isIsomorphic("eggd", "addd"))
/*
 方法一：哈希表
 此题是「290. 单词规律」的简化版，需要我们判断 ss 和 tt 每个位置上的字符是否都一一对应，即 ss 的任意一个字符被 tt 中唯一的字符对应，同时 tt 的任意一个字符被 ss 中唯一的字符对应。这也被称为「双射」的关系。

 以示例 22 为例，tt 中的字符 aa 和 rr 虽然有唯一的映射 oo，但对于 ss 中的字符 oo 来说其存在两个映射 \{a,r\}{a,r}，故不满足条件。

 因此，我们维护两张哈希表，第一张哈希表 \textit{s2t}s2t 以 ss 中字符为键，映射至 tt 的字符为值，第二张哈希表 \textit{t2s}t2s 以 tt 中字符为键，映射至 ss 的字符为值。从左至右遍历两个字符串的字符，不断更新两张哈希表，如果出现冲突（即当前下标 \textit{index}index 对应的字符 s[\textit{index}]s[index] 已经存在映射且不为 t[\textit{index}]t[index] 或当前下标 \textit{index}index 对应的字符 t[\textit{index}]t[index] 已经存在映射且不为 s[\textit{index}]s[index]）时说明两个字符串无法构成同构，返回 \rm falsefalse。

 如果遍历结束没有出现冲突，则表明两个字符串是同构的，返回 \rm truetrue 即可。

 作者：LeetCode-Solution
 链接：https://leetcode.cn/problems/isomorphic-strings/solution/tong-gou-zi-fu-chuan-by-leetcode-solutio-s6fd/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
func isIsomorphic2(_ s: String, _ t: String) -> Bool {
    var s = Array(s)
    var t = Array(t)
    var s2t : [Character : Character] = [:]
    var t2s : [Character : Character] = [:]
    var index = 0
    var x : Character
    var y : Character
    while index < s.count {
         x = s[index]
         y = t[index]
        if (s2t.keys.contains(x) && s2t[x] != y) || (t2s.keys.contains(y) && t2s[y] != x) {
            return false
        }
            
        s2t[x] = y
        t2s[y] = x
        index += 1
    }
    return true
}


//[242. 有效的字母异位词]
/*
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

 注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。



 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/valid-anagram
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

func isAnagram(_ s: String, _ t: String) -> Bool {
   if s.count != t.count {
       return false
   }
   var s = Array(s)
   var t = Array(t)
   var x : Character
   var y : Character
   var countS : [Int] = Array(repeating: 0, count: 128)
   var index = 0
   while index < s.count {
       x = s[index]
       y = t[index]
       countS[Int(x.asciiValue!)] += 1
       countS[Int(y.asciiValue!)] -= 1
       index += 1
   }
   for value in countS {
       if value != 0 {
           return false
       }
   }
     return true
}
 

//[LeetCode 243. 最短单词距离]
/*
给定一个单词列表和两个单词 word1 和 word2，返回列表中这两个单词之间的最短距离。

示例:
假设 words = ["practice", "makes", "perfect", "coding", "makes"]
输入: word1 = “coding”, word2 = “practice”
输出: 3
输入: word1 = "makes", word2 = "coding"
输出: 1

注意:
你可以假设 word1 不等于 word2, 并且 word1 和 word2 都在列表里。
*/
//转化为两个有序数组的元素,最小差值问题
func shortestDistance( words : [String],  word1 : String,  word2 : String) -> Int{
    var word1s : [Int] = []
    var word2s : [Int] = []
    var index = 0
    var value : String
    while index < words.count {
        value = words[index]
        if value == word1 {
            word1s.append(index)
        }else if value == word2 {
            word2s.append(index)
        }
        index += 1
    }
    print(word1s,word2s)
    var indexa = 0
    var indexb = 0
    var valuea = 0
    var valueb = 0
    var dta = 0
    var fianl = Int.max
    while indexa < word1s.count && indexb < word2s.count {
        valuea = word1s[indexa]
        valueb = word2s[indexb]
        dta = valuea - valueb
        fianl = min(fianl, abs(dta))
        if dta > 0 {
            indexb += 1
        } else {
            indexa += 1
        }
    }

    return fianl
}

//print(shortestDistance(words: ["practice", "makes", "perfect", "coding", "makes","practice", "makes", "perfect", "coding", "makes"], word1: "makes", word2: "practice"))

//[LeetCode 246. 中心对称数（哈希)](https://cloud.tencent.com/developer/article/1660429)
/*
中心对称数是指一个数字在旋转了 180 度之后看起来依旧相同的数字（或者上下颠倒地看）。

请写一个函数来判断该数字是否是中心对称数，其输入将会以一个字符串的形式来表达数字。

示例 1:
输入:  "69"
输出: true

示例 2:
输入:  "88"
输出: true

示例 3:
输入:  "962"
输出: false
复制
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/strobogrammatic-number
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

func isStrobogrammatic( num : String) -> Bool {
    let rg : [Character : Character] = ["1" : "1" , "6" : "9" , "0" : "0", "8" : "8" , "9" : "6" ]
    var length = num.count
    var index = length - 1
    var c : Character
    var numcs = Array(num)
    var new : String = ""
    while index >= 0 {
        c = numcs[index]
        if !rg.keys.contains(c) {
            return false
        }
        new.append(rg[c]!)
        index -= 1
        
    }
    print(new)
    return new == num
}

//print(isStrobogrammatic(num: "9886"))

//【LeetCode - 266】回文排列

 /*
  给定一个字符串，判断该字符串中是否可以通过重新排列组合，形成一个回文字符串。

  示例 1：
  输入: "code"
  输出: false

  示例 2：
  输入: "aab"
  输出: true

  示例 3：
  输入: "carerac"
  输出: true
  复制
   来源：力扣（LeetCode）
   链接：https://leetcode-cn.com/problems/palindrome-permutation
   著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
  */

//思路1:最多有一个字符的数量是奇数,其余字符为偶数

func  canPermutePalindrome(s : String) -> Bool {
    var s = Array(s)
    var count = Array(repeating: 0, count: 26)
    for value in s {
        count[Int(value.asciiValue!) - 97] += 1
    }
    var c = 0
    for v in count {
        if v%2 != 0 {
            c += 1
        }
    }
    print(count,c)
    return c <= 1
}

//print(canPermutePalindrome(s: "abcbcadrr"))


//[290. 单词规律]
/*
 给定一种规律 pattern 和一个字符串 s ，判断 s 是否遵循相同的规律。

 这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 s 中的每个非空单词之间存在着双向连接的对应规律。

  

 示例1:

 输入: pattern = "abba", s = "dog cat cat dog"
 输出: true
 示例 2:

 输入:pattern = "abba", s = "dog cat cat fish"
 输出: false
 示例 3:

 输入: pattern = "aaaa", s = "dog cat cat dog"
 输出: false


 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/word-pattern
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//解题思路 通过map映射判断

func wordPattern(_ pattern: String, _ s: String) -> Bool {
    var p = Array(pattern)
    var ss = s.split(separator: " ")
    if p.count != ss.count {
        return false
    }
    var map : [Character : Substring] = [:]
    var map1 : [Substring : Character] = [:]
    var index = 0
    var key : Character
    var value : Substring
    var v : Substring?
    var k : Character?
    while index < p.count {
        key = p[index]
        value = ss[index]
        v = map[key]
        if v != nil && v != value {
            return false
        }
        k = map1[value]
        if k != nil && k != key {
            return false
        }
        
        map[key] = value
        map1[value] = key
        index += 1
    }
    return true
}


//print(wordPattern("abc", "dog cat dog"))

//[ LeetCode 293. 翻转游戏]
/*
 
 1. 题目
 你和朋友玩一个叫做「翻转游戏」的游戏，游戏规则：给定一个只有 + 和 - 的字符串。
  你和朋友轮流将 连续 的两个 “++” 反转成 “–”。
  当一方无法进行有效的翻转时便意味着游戏结束，则另一方获胜。

 请你写出一个函数，来计算出第一次翻转后，字符串所有的可能状态。

 示例：
 输入: s = "++++"
 输出:
 [
   "--++",
   "+--+",
   "++--"
 ]
 注意：如果不存在可能的有效操作，请返回一个空列表 []。
 复制
  来源：力扣（LeetCode） 链接：https://leetcode-cn.com/problems/flip-game
  著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

 
//思路: 双指针,连续++则转为--

func generatePossibleNextMoves(s : String) -> [String] {
    if s.count <= 1 {
        return []
    }
    var strs : [String] = []
    var sc = Array(s)
    var ts = sc
    var fre = 0
    var pre = 1
    var p : Character
    var f : Character
    while pre < s.count {
        f = sc[fre]
        p = sc[pre]
        if f == "+" && p == f {
            ts[fre] = "-"
            ts[pre] = "-"
            strs.append(String(ts))
        }
        
        pre += 1
        fre += 1
        ts = sc
    }
    
    return strs
}

//print(generatePossibleNextMoves(s: "++++"))

//[ 344. 反转字符串]
/*

 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。

 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
 */
func reverseString(_ s: inout [Character]) {
    var right = 0
    var left = s.count - 1
    var temp : Character
    while right < s.count/2 {
        temp = s[right]
        s[right] = s[left]
        s[left] = temp
        right += 1
        left -= 1
    }
}
//var s = Array("1234567")
//reverseString(&s)
//print(s)


//[345. 反转字符串中的元音字母]
/*
 给你一个字符串 s ，仅反转字符串中的所有元音字母，并返回结果字符串。

 元音字母包括 'a'、'e'、'i'、'o'、'u'，且可能以大小写两种形式出现不止一次。

 示例 1：

 输入：s = "hello"
 输出："holle"
 示例 2：

 输入：s = "leetcode"
 输出："leotcede"

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/reverse-vowels-of-a-string
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

//思路: 双指针, 首位同事遍历,满足同时都遇到元音,遇到元音后交换指针内容 , 首位指针相等时结束
func reverseVowels(_ s: String) -> String {
    var right = 0
    var s = Array(s)
    var left = s.count - 1
    var yy : [Character] = ["a","e","i","o","u","A","E","I","O","U"]
    var temp : Character = " "
    while right < left {
        while !yy.contains(s[right]) && right < left{
            right += 1
        }
        
        while !yy.contains(s[left]) && left > right {
            left -= 1
        }
        
        temp = s[right]
        s[right] = s[left]
        s[left] = temp
        right += 1
        left -= 1
    }
    
    return String(s)
}


//思路2 : 将元音字符的下标记录下来,然后统一做交换


//print(reverseVowels("leetcode"))


//[383. 赎金信]

/*
 给你两个字符串：ransomNote 和 magazine ，判断 ransomNote 能不能由 magazine 里面的字符构成。

 如果可以，返回 true ；否则返回 false 。

 magazine 中的每个字符只能在 ransomNote 中使用一次。

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/ransom-note
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    if ransomNote.count > magazine.count {
        return false
    }
    var r = Array(ransomNote)
    var m = Array(magazine)
    var b : [Int] = Array(repeating: 0, count: 26 )
   
    for v in m {
        b[Int(v.asciiValue!) - 97] += 1
    }
    
    for v in r {
        b[Int(v.asciiValue!) - 97] -= 1
        if  b[Int(v.asciiValue!) - 97] < 0{
            return false
        }
    }
    
    return true
 }
 


//[387. 字符串中的第一个唯一字符]
/*
 给定一个字符串 s ，找到 它的第一个不重复的字符，并返回它的索引 。如果不存在，则返回 -1 。
 https://leetcode.cn/problems/first-unique-character-in-a-string/
 */

func firstUniqChar(_ s: String) -> Int {
    var s = Array(s)
    var a : [Int] = Array(repeating: 0, count: 26)
    for v in s {
        a[Int(v.asciiValue!) - 97] += 1
    }
    var index = 0
    while index < s.count {
        if a[Int(s[index].asciiValue!) - 97] == 1 {
            return index
        }
        index += 1
    }
    
    return -1
}

print(firstUniqChar("aabb"))


