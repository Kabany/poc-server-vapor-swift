@testable import App
import VaporTesting
import Testing

@Suite("Operations Tests")
struct OperationTests {
    @Test("Should create a list of items with a number and a string as parameters")
    func createList() async throws {
        let list = operationsService.createList(times: 1000)
        #expect(1000 == list.count)
    }
}
