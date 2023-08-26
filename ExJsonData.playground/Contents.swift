import UIKit
import Foundation

let jsonString = """
{
    "name": "jake",
    "age": 30,
    "isStudent": false
}
"""
let jsonData = jsonString.data(using: .utf8)!

// 1. JSONSerialization 개념: Dictionary <=> jsonData
func sampleJSONSerialization() {
    // jsonData > Dictionary
    guard
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
    else { return }
    print(dictionary)
    /*
     ["isStudent": 0, "age": 30, "name": jake]
     */
    
    
    // Dictinoary > jsonData
    guard
        let newJsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    else { return }
    print(newJsonData)
    /*
     58 bytes
     */
}

sampleJSONSerialization()

// 2. JSONEncoder 개념: Codable 구조체 => jsonData
// 주의) 이 반대인 jsonData를 Codable로 만들려면 JSONDecoder사용
struct Person: Codable {
    let name: String
    let age: Int
    let isStudent: Bool
}
let person = Person(name: "Jane Smith", age: 25, isStudent: true)

func sampleEncoder() {
    // Codable 구조체 => jsonData
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    guard let jsonData = try? jsonEncoder.encode(person) else { return }
    print(jsonData)
    /*
     63 bytes
    */
    
    // jsonData => Codable 구조체
    let jsonDecoder = JSONDecoder()
    guard
        let decodedPerson = try? jsonDecoder.decode(Person.self, from: jsonData)
    else { return }
    print(decodedPerson)
    /*
     Person(name: "Jane Smith", age: 25, isStudent: true)
     */
}

sampleEncoder()
