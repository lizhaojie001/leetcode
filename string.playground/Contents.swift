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
