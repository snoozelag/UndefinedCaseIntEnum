import UIKit

enum IntEnum: Hashable, Decodable {
    case zero
    case one
    case two
    case undefined(Int)
}

extension IntEnum: RawRepresentable {

    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .zero
        case 1: self = .one
        case 2: self = .two
        default: self = .undefined(rawValue)
        }
    }

    var rawValue: Int {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .undefined(let value):
            return value
        }
    }
}

// ----------------------------------------------------------------

struct Foo: Decodable {
    let id: Int
    let description: String
    let type: IntEnum
}

// サーバーからのjsonレスポンスの例
let data = """
{
"id": 312931,
"description": "Some Text.",
"type": 4
}
""".data(using: .utf8)!

// デコード
let foo = try? JSONDecoder().decode(Foo.self, from: data)

if let foo = foo {
    print(foo.type.rawValue)
} else {
    print("モデルへのデコード失敗!!")
}

