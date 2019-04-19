import XCTest

enum IntEnum: Hashable, Decodable {

    private enum Defined: Int, CaseIterable {
        case zero
        case one
        case two
    }

    case zero
    case one
    case two
    case undefined(Int)
}

extension IntEnum: RawRepresentable {

    init?(rawValue: Int) {
        switch rawValue {
        case Defined.zero.rawValue: self = .zero
        case Defined.one.rawValue: self = .one
        case Defined.two.rawValue: self = .two
        default: self = .undefined(rawValue)
        }
    }

    var rawValue: Int {
        switch self {
        case .zero: return Defined.zero.rawValue
        case .one: return Defined.one.rawValue
        case .two: return Defined.two.rawValue
        case .undefined(let value):
            assert(!Defined.allCases.contains(where: { $0.rawValue == value }), "undefinedには他の定義済みのcaseと重複する値を指定しないで下さい")
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

