import XCTest

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

// --------------------------------------------------------------------------

// swicthのテスト
func testSwitchCase(type: IntEnum) -> String {
    switch type {
    case .zero:
        return "case: zero, rawValue: \(type.rawValue)"
    case .one:
        return "case: one, rawValue: \(type.rawValue)"
    case .two:
        return "case: two, rawValue: \(type.rawValue)"
    case .undefined:
        return "case: undefined, rawValue: \(type.rawValue)"
    }
}

let result0 = testSwitchCase(type: .zero)
print(result0)
let result1 = testSwitchCase(type: .one)
print(result1)
let result2 = testSwitchCase(type: .two)
print(result2)
let result3 = testSwitchCase(type: IntEnum(rawValue: 100)!)
print(result3)

// rawValueのテスト
XCTAssertEqual(0, IntEnum.zero.rawValue)
XCTAssertEqual(1, IntEnum.one.rawValue)
XCTAssertEqual(2, IntEnum.two.rawValue)

// init?(rawValue: Int)のテスト
XCTAssertEqual(0, IntEnum(rawValue: 0)!.rawValue)
XCTAssertEqual(1, IntEnum(rawValue: 1)!.rawValue)
XCTAssertEqual(2, IntEnum(rawValue: 2)!.rawValue)
XCTAssertEqual(3, IntEnum(rawValue: 3)!.rawValue)
XCTAssertEqual(4, IntEnum(rawValue: 4)!.rawValue)
XCTAssertEqual(5, IntEnum(rawValue: 5)!.rawValue)
XCTAssertEqual(6, IntEnum(rawValue: 6)!.rawValue)
XCTAssertEqual(7, IntEnum(rawValue: 7)!.rawValue)

