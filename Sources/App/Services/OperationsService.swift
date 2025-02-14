import Vapor

struct OperationItem: Content {
    var id: Int
    var message: String
}

struct OperationsService {
    func createList(times: Int) -> [OperationItem] {
        var list: [OperationItem] = []
        if times <= 0 {
            return list
        }
        for n in 1...times {
            list.append(OperationItem(id: n, message: "This is the message number \(n)"))
        }
        return list
    }
}
