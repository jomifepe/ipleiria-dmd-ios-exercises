import UIKit

// 1) 1) Declare an Animal class, which should represent a generic animal. All animals should be able to emit a sound. Then, declare two subclasses of Animal: Cat, and Dog. A dog’s sound should be “woof”, and a cat’s sound should be “miau”.
//class Animal {
//    func emitSound() {
//        print("No sound specified")
//    }
//}
//
//class Cat: Animal {
//    override func emitSound() {
//        print("Meow")
//    }
//}
//
//class Dog: Animal {
//    override func emitSound() {
//        print("Woof")
//    }
//}
//
//print("1)")
//let cat: Cat = Cat()
//cat.emitSound()
//let dog: Dog = Dog()
//dog.emitSound()

// 2) Is it possible to define the Animal class as abstract?
// No, it need to be change to a protocol

// 3) Replace the Animal class with an Animal protocol, which should also include the sound method definition. Have the Cat and Dog adopt to Animal protocol.
protocol Animal {
    func emitSound()
}

//class Cat: Animal {
//    func emitSound() {
//        print("Meow")
//    }
//}
//
//print("\n3)")
//let _cat: Cat = Cat()
//_cat.emitSound()


// 4) Extend the Animal protocol, and add the maxAge property (default value: 20 years) and the eat method (which should simply print “eating”). The Dog should redefine the value of the maxAge property as being 25 years.
extension Animal {
    var maxAge: Int {
        get {
            return 20
        }
    }

    func eat() {
        print("eating")
    }
}

//class Dog: Animal {
//    func emitSound() {
//        print("Woof")
//    }
//
//    var maxAge: Int {
//        get {
//            return 25
//        }
//    }
//}
//
//let _dog: Dog = Dog()
//_dog.emitSound()
//
//print("\n4)")
//_dog.eat()
//print("Dog maxAge: \(_dog.maxAge)")

// 5) Redefine the hierarchy so that Dogs and Cats adopt a new Pet protocol which, in turn, should adopt the Animal protocol. All pets must have a name and an owner (use a Property Requirement).

protocol Pet: Animal {
    var name: String { get set }
    var owner: String { get set }
}

class Dog: Pet {
    var name = "Goodest boi"
    var owner = "Hooman"
    
    func emitSound() {
        print("Woof")
    }
    
    var maxAge: Int {
        get {
            return 25
        }
    }
}

class Cat: Pet {
    var name = "Chonker"
    var owner = "Slave Hooman"
    
    func emitSound() {
        print("Meow")
    }
}

print("\n5)")
let __cat: Cat = Cat()
let __dog: Dog = Dog()
print("Cat: ", __cat.name, "Owner: ", __cat.owner)
print("Dog: ", __dog.name, "Owner: ", __dog.owner)

// 6) Define a breed property just for the dogs. Possible breeds are: Golden Retrievers, Doberman Pinscher, and Labrador.

enum Breed {
    case GoldenRetrievers, DobermanPinscher, Labrador
}

// 7) Create a PetOwner class, which should contain an array of pets. Define a subscript that allows which accessing the pets. 







