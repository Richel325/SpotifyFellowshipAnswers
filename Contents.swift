/*  Sort the letters in the string s by the order they occur in the string t. You can assume t will not have repetitive characters. For s = "weather" and t = "therapyw", the output should be sortByString(s, t) = "theeraw". For s = "good" and t = "odg", the output should be sortByString(s, t) = "oodg". */

func sortByString(string: String, pattern: String) -> String {
    //Create an empty dictionary to hold each character and the frequency of the character in a string
    var dictionary = [Character : Int]()
    //Create an empty string to hold the final output of characters
    var answerString = ""
    
    //Implement dictionary, making sure the input string is lowercased
    for char in string.lowercased() {
        if let charCount = dictionary[char] {
            dictionary[char] = charCount + 1
        } else {
            dictionary[char] = 1
        }
    }
    
    //For each (lowercased) character in the pattern string, from 0 occurrences to less occurrences than its character count, add the character to the answer (output) string
    for char in pattern.lowercased() {
        if let charCount = dictionary[char] {
            for _ in 0 ..< charCount {
                answerString += String(char)
            }
        }
    }
    
    print(dictionary)
    print(answerString)
    return answerString
}

var str = "abcabc"
var patrn = "gfedcba"
var str2 = "richel"
var patrn2 = "remarkable"

sortByString(string: str, pattern: patrn)
sortByString(string: str2, pattern: patrn2)






/*  Given an encoded string, return its corresponding decoded string.
 
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is repeated exactly k times. Note: k is guaranteed to be a positive integer.
 
 For s = "4[ab]", the output should be decodeString(s) = "abababab"
 For s = "2[b3[a]]", the output should be decodeString(s) = "baaabaaa" */

func decodedString(encodedString: String) -> String {
    //Create an empty string to store the final decoded values
    var decodedStr = ""
    
    //We will need a way to print the same character multiple times (a positive integer)
    
    
    //Print and return the decoded string to check progress
    print(decodedStr)
    return decodedStr
}














/* Your quirky boss collects rare, old coins. They found out you're a programmer and asked you to solve something they've been wondering for a long time.
 
 Write a function that, given an amount of money and an array of coin denominations, computes the number of ways to make the amount of money with coins of the available denominations.
 
 Example: for amount=4 (4¢) and denominations=[1,2,3] (1¢, 2¢ and 3¢), your program would output 4—the number of ways to make 4¢ with those denominations: */


func createChange(amount: Int, denominations: [Int]) -> Int {
    //Create a variable that repeats the amount and increases its count by 1
    var combiningCents = Array(repeating: 0, count: amount + 1)
    //First index in the combiningCents array is 1 cent
    combiningCents[0] = 1
    
    //For each coin in the array of denominations, if the coin is less than or equal to the amount: for every larger amount in the count of coins to amount, let the larger amount left be equal to the larger amount minus the coin, and add that larger amoun to the combiningCents array
    for coin in denominations {
        if coin <= amount {
            for largerAmount in coin...amount {
                let largerAmountLeft = largerAmount - coin
                combiningCents[largerAmount] += combiningCents[largerAmountLeft]
            }
        }
    }
    
    print(combiningCents[amount])
    return combiningCents[amount]
}


createChange(amount: 4, denominations: [1, 2, 3])
createChange(amount: 75, denominations: [1, 10, 25, 50])
