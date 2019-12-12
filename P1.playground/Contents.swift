import UIKit

var str = "Hello, playground"

let nickName: String? = nil
let fullName: String = "John Appleseed"
// Ternary
let informalGreeting = "Hi \(nickName ?? fullName)"

// Exercise 7
// a) Declare an integer variable with an explicit type annotation and then one without.
var implicit = 70
var explicit : Int = 70

// b) Declare a constant integer value that represents the number of wheels of a car. Don't assign it a value on the same line. On the next line, assign a value to the constant. Why does this work?
let constant : Int
constant = 70

// c) Why does the following code not work? What do you need to add to it to make it work, if we absolutely want to store this value as an integer, i.e. 3, but we don't want to change the type of the variables?
let pi = 3.141592654
let approximatePi: Int = Int(pi)

// cc) Why does the following code not work? What do you need to add to it to make it work, if we absolutely want to store this value as an integer, i.e. 3, but we don't want to change the type of the variables?

// d) Why doesn't this work? What needs to be added to value on the second line for this to work?
let value: Int? = 17
let banana: Int = value ?? 0

// e) What happens if you try the unary increment operator (e.g. value++) from other Clike languages?
var value1 = 0
value1 += 1

// The first name is optional in this example.
var firstName: String? = nil

// The last name is however not optional.
var lastName: String = "Jones"

// Use ?? operator here to provide a fallback value,
// if no first name has been provided.
// For example, the default value could be "Dr.", because this code is to be used at a medical conference.
var name: String = firstName ?? lastName
name += " " + lastName

print(name)

// d) Define a closed range, e.g. for an amplifier volume knob that goes from 0 to 11. The range should include both 0 and 11, because this amplifier really does go to 11 (warning: pop culture reference! :-)). Use the pattern matching operator ~= to check if a value is included in the range.
let val = 5
let range : ClosedRange<Int> = 0...11
if range ~= val {
    print("In range")
}

// e) Define an open range, e.g. for an amplifier volume knob that goes from 0 to 10. The range should include both 0 and 10, but not 11.
let openRange = 0..<11

// i) Create the string "Polytechnic Institute of Leiria" from the following variables/constants, and assign it to the constant school. First do it using concatenation, and then again using interpolation.
let s1: String = "Polytechnic"
var s2 = "of"
let s3 = "Leiria"
var concatenation = s1 + " " + s2 + " " + s3
var interpolation = "\(s1) \(s2) \(s3)"

// j) Assign the length of the string to the variable length.
var len = s1.count

// k) Create an empty array with values of type Int and assign it to a variable in as many ways as you can think of.
var arr = [Int]()
var arr1 : [Int] = []
var arr2 = Array<String>()
var arr3 : Array<Int> = []

// l) Create an array containing the integer values 4, 8, 15, 16, 23, and 42.
var arr4 = [4, 8, 15, 16, 23, 42]

// m) Add the values 1138, 1337, and 4711 to the end of the previous array.
arr4.append(1138)
arr4.append(1337)
arr4.append(4711)

// n) Replace the values 15, 16, and 23 with the values 1, 2, 3, 4, and 5 in the previous array
arr4[2...4] = [1, 2, 3, 4, 5]
print(arr4)

// o) Create an empty dictionary with keys of type String and values of type Int and assign it to a variable in as many ways as you can think of.
var dictionary = [String: Int]()
var dictionary1 : [String: Int] = [String: Int]()
var dictionary2 : [String: Int] = [:]
var dictionary3 : Dictionary<String, Int> = Dictionary<String, Int>()
var dictionary4 = Dictionary<String, Int>()
var dictionary5 : Dictionary<String, Int> = [:]

// p) Create a mutable dictionary named secretIdentities where the key value pairs are "Hulk" -> "Bruce Banner", "Batman" -> "Bruce Wayne", and "Superman" -> "Clark Kent".
var secretIdentities: Dictionary<String, String> = ["Hulk": "Bruce Banner", "Batman": "Bruce Wayne", "Superman": "Clark Kent"]

// q) Given the previous dictionary, print the secret identity of Batman. Spoiler: It's Bruce Wayne.
print(secretIdentities["Batman"]!)

// r) Given the previous array, write a for loop that prints its values.
for item in secretIdentities {
    print(item)
}

// s) Given the previous dictionary, iterate (with a for loop) over all the secret identities and print both the values and the keys.
for (key, value) in secretIdentities {
    print("\(key): \(value)")
}

// t) Write a for loop that prints the values in array [2, 6, 11, 19, 25], each value and its index in the array on a separate line. Tip: check the enumerated() method.
for (index, item) in [2, 6, 11, 19, 25].enumerated() {
    print("\(index): \(item)")
}

// u) Write a repeat...while loop that increments a counter variable until it reaches 10.
var i = 0
repeat {
    print(i)
    i += 1
} while i < 10

// v) Write a single if statement that converts a String to an Int and then checks if that Int is 1337. If it is, print "The value is 1337".
if Int("1337") == 1337 {
    print("1337")
}

//w) Write a switch (using fallthrough) that prints "Animal is a tiger" and also prints "Animal is a cat" if animal is "tiger". It should also print "Animal is a cat" if animal is "cat". The line that prints "Animal is a cat" may only exist once in the code. If animal is not a cat or a tiger, print "Animal is some other type of animal".
let animal = "tiger"
switch animal {
case "tiger":
    print("Animal is a tiger")
    fallthrough
case "cat":
    print("Animal is a cat")
default:
    print("Animal is some other type of animal")
}

// x) Consider the following code, and define a vector3D variable so that the switch prints the y value.
var vector3D = (0, 666, 5)
vector3D = (12, 666, 0)

switch vector3D {
case (_, let y, 5), (12, let y, _):
    print("y: \(y)")
default:
    break
    
}

// y) Consider the following code, and define a vector3D variable so that the switch prints the x value
vector3D = (666, 2, 6)
switch vector3D {
case let (x, y, z) where z == y * 3:
    print("x: \(x)")
default:
    break
}

// z) Assign a tuple with two values in it to a constant named player. The values could represent the number of a football player and the name of the football player. For example, Maradona whose number used to be 10.
let player = (10, "Maradona")
var t : (Int, String) = player

// aa) Now you have a player tuple. Decompose (i.e. split) the number and the name into two constants named number and name. This could be done in at least two ways. Try both.
let number1 = t.0
let name1 = t.1
print("number1:\(number1), name1:\(name1)")
let (number2, name2) = t
print("number2:\(number2), name2:\(name2)")

// bb) Let's compare some tuples. Guess if these are true or false:
print("(1, \"zebra\") < (2, \"apple\")", (1, "zebra") < (2, "apple")) // true
print("(2, \"zebra\") < (1, \"apple\")", (2, "zebra") < (1, "apple")) // false
print("(3, \"apple\" < (3, \"bird\")", (3, "apple") < (3, "bird")) // true?
print("(4, \"dog\") == (4, \"dog\")", (4, "dog") == (4, "dog")) // true
print("(4, \"dog\") == (4, \"cat\")", (4, "dog") == (4, "cat")) // false

// cc) Write a function greeting that takes the name of a person (e.g. "Batman") as input and returns a greeting string (e.g. "Hello, Batman!") that can be printed.

// underscore means that the argument doesn't need to be labeled when the function is called
func greet(_ name: String) -> (String) {
    return "Hello, \(name)!"
}
print("cc)", greet("Batman"))

// dd) Write a function split(name: String) that takes a name (e.g. "Justino Figueiredo") as input and returns the first and the last name separated into a tuple with two elements. To split a string into an array with " " as separator, you can use the following:

func split(_ name: String) -> (firstName: String?, lastName: String?) {
    let parts : [String] = name.components(separatedBy: " ")
    guard parts.count >= 2 else {
        return (name[0], nil)
    }
    return (parts.first, parts.last)
}

let result = split("Justino Figueiredo")
print("dd)", result.firstName ?? "No first name", result.lastName ?? "No last name")

// ee) Write a function square that takes an Int as input, but doesn't require a label at the call site, i.e. square(3) should work. It should return the square of the input value.

func square(_ input: Int) -> Float {
    return sqrt(Float(input))
}
print("ee)", square(3))

// ff) Write a closure that prints the string "stuff" and assign the closure to a variable. Then call the closure.
let clsr = {() -> String in "stuff"}
print("ff)", clsr())

// ffv8) Write the function called stats, which should takes a varying number of input values (i.e., a variadic parameter), and return the sum, min value, max value and arithmetic mean.
func stats(_ input: Int...) -> (sum: Int, min: Int, max: Int, mean: Int) {
    if input.isEmpty {
        print("ffv8) No arguments")
        return (0, 0, 0, 0)
    }
    
    var _sum = 0;
    for item in input {
        _sum += item ?? 0
    }
    
    return (_sum, input.min() ?? 0, input.max() ?? 0, _sum/input.count)
}
print("ffv8)", stats(1, 2, 3, 4, 5))

// ggv8) Write a function called swapTwoInts, that should receive two integer parameters and swap their values. Use In-Out Parameters.
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// hh) Write a closure that returns the square of its input value. Write the whole closure and call it within the parentheses of a print call, i.e. print( <write your closure here> ).
print("hh)", {(i: Int) -> Float in sqrt(Float(i))}(3))

// iiv8) Write a closure that takes two integers and returns the sum of the integers. Assign the closure to a variable and then call the closure.
let clsr2 = {(i1: Int, i2: Int) -> Int in i1 + i2}
print("gg)", clsr2(1, 2))

// Swift’s standard library provides a method called sorted(by:), which sorts an array of values of a known type, based on the output of a sorting closure that you provide. Once it completes the sorting process, the sorted(by:) method returns a new array of the same type and size as the old one, with its elements in the correct sorted order. The sorted(by:) method accepts a closure that takes two arguments of the same type as the array’s contents, and returns a Bool value to say whether the first value should appear before or after the second value once the values are sorted.
// Consider the following array:
// let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// Sort this array backwards (i.e, ["Ewa", "Daniella", "Chris", "Barry", "Alex"] should be returned), by:
// 1. Creating a function named backward as the sorting closure, and passing it in as an argument to the sorted(by:) method.
// 2. Writing the sorting closure inline, using closure expression syntax: { (parameters) -> return type in statements }
// 3. Writing the sorting closure inline, and implicitly returning the result of the by omitting the return keyword from the declaration.
// 4. Writing the sorting closure inline, and using shorthand argument names.

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]


