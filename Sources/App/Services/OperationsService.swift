import Vapor

struct OperationItem: Content {
    var id: Int
    var message: String
}

struct OperationsService {
    func createList(_ times: Int) -> [OperationItem] {
        var list: [OperationItem] = []
        if times <= 0 {
            return list
        }
        for n in 1...times {
            list.append(OperationItem(id: n, message: "This is the message number \(n)"))
        }
        return list
    }
    
    func fibonacciSum(_ n: Int) -> UInt64  {
        var fib: [UInt64] = []
        if n <= 0 {
            return 0
        } else if n == 1 {
            return 1
        }
        fib.append(0)
        fib.append(1)
        var sum: UInt64 = 1
        for i in 2...n {
            fib.append(fib[i-1] + fib[i-2])
            sum += fib[i]
        }
        return sum
    }
    
    func fibonacciList(_ n: Int) -> [UInt64] {
        var fib: [UInt64] = []
        if n < 0 {
            return fib
        } else if n == 0 {
            fib.append(0)
            return fib
        }
        fib.append(0)
        fib.append(1)
        if n == 1 {
            return fib
        }
        for i in 2...n {
            fib.append(fib[i-1] + fib[i-2])
        }
        return fib
    }
}
