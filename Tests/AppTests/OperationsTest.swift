@testable import App
import XCTVapor
import Testing

final class OperationTests: XCTestCase {

    func testCreateList() async throws {
        let list = operationsService.createList(1000)
        XCTAssertEqual(1000, list.count)
        // First item
        XCTAssertEqual(1, list[0].id)
        XCTAssertEqual("This is the message number 1", list[0].message)
        // 100th item
        XCTAssertEqual(100, list[99].id)
        XCTAssertEqual("This is the message number 100", list[99].message)
        // 1000th item
        XCTAssertEqual(1000, list[999].id)
        XCTAssertEqual("This is the message number 1000", list[999].message)
    }
    
    func testCheckFibonacciSum() async throws {
        XCTAssertEqual(0, operationsService.fibonacciSum(-1))
        XCTAssertEqual(0, operationsService.fibonacciSum(0))
        XCTAssertEqual(1, operationsService.fibonacciSum(1))
        XCTAssertEqual(2, operationsService.fibonacciSum(2))
        XCTAssertEqual(4, operationsService.fibonacciSum(3))
        XCTAssertEqual(7, operationsService.fibonacciSum(4))
        XCTAssertEqual(12, operationsService.fibonacciSum(5))
        XCTAssertEqual(143, operationsService.fibonacciSum(10))
        XCTAssertEqual(32951280098, operationsService.fibonacciSum(50))
        // XCTAssertEqual(927372692193078999175, operationsService.fibonacciSum(n: 100))
    }
    
    func testCheckFibonacciSequence() async throws {
        XCTAssertEqual(0, operationsService.fibonacciList(-1).count)
        let list0 = operationsService.fibonacciList(0)
        XCTAssertEqual(1, list0.count)
        XCTAssertEqual(0, list0[0])
        let list1 = operationsService.fibonacciList(1)
        XCTAssertEqual(2, list1.count)
        XCTAssertEqual(1, list1[1])
        let list2 = operationsService.fibonacciList(2)
        XCTAssertEqual(3, list2.count)
        XCTAssertEqual(1, list2[2])
        let list3 = operationsService.fibonacciList(3)
        XCTAssertEqual(4, list3.count)
        XCTAssertEqual(2, list3[3])
        let list4 = operationsService.fibonacciList(4)
        XCTAssertEqual(5, list4.count)
        XCTAssertEqual(3, list4[4])
        let list5 = operationsService.fibonacciList(5)
        XCTAssertEqual(6, list5.count)
        XCTAssertEqual(5, list5[5])
        let list6 = operationsService.fibonacciList(6)
        XCTAssertEqual(7, list6.count)
        XCTAssertEqual(8, list6[6])
        let list7 = operationsService.fibonacciList(10)
        XCTAssertEqual(11, list7.count)
        XCTAssertEqual(55, list7[10])
        let list8 = operationsService.fibonacciList(50)
        XCTAssertEqual(51, list8.count)
        XCTAssertEqual(12586269025, list8[50])
        let list9 = operationsService.fibonacciList(78)
        XCTAssertEqual(79, list9.count)
        XCTAssertEqual(8944394323791464, list9[78])
        /*let list10 = operationsService.fibonacciList(100)
        XCTAssertEqual(101, list10.count)
        XCTAssertEqual(354224848179261915075, list10[100])*/
    }
}
