import Vapor

struct OperationsController: RouteCollection {
    
    func boot (routes: Vapor.RoutesBuilder) throws {
        let operations = routes.grouped("operations")
        operations.group("list") { operationsList in
            operationsList.group("params") { params in
                params.get(":times", use: sendListWithParams)
            }
            operationsList.get("query", use: sendListWithQuery)
            operationsList.post("body", use: sendListWithBody)
            operationsList.get("headers", use: sendListWithHeaders)
        }
        operations.group("fibonacci") { fib in
            fib.group("sum") { fibSum in
                fibSum.get(":number", use: sendFibonacciSum)
            }
            fib.group("list") { fibList in
                fibList.get(":number", use: sendFibonacciList)
            }
        }
    }
    
    @Sendable func sendListWithParams(req: Request) async throws -> ResponseBody<[OperationItem]> {
        let times = Int(req.parameters.get("times") ?? "0") ?? 0
        let list: [OperationItem] = operationsService.createList(times)
        return responseService.SuccessResponse(data: list, message:nil)
    }
    
    @Sendable func sendListWithQuery(req: Request) async throws -> ResponseBody<[OperationItem]> {
        let times = Int(req.query["times"] ?? "0") ?? 0
        let list: [OperationItem] = operationsService.createList(times)
        return responseService.SuccessResponse(data: list, message:nil)
    }
    
    @Sendable func sendListWithBody(req: Request) async throws -> ResponseBody<[OperationItem]> {
        let request = try req.content.decode(OperationTimesRequest.self)
        let list: [OperationItem] = operationsService.createList(request.times)
        return responseService.SuccessResponse(data: list, message:nil)
    }
    
    @Sendable func sendListWithHeaders(req: Request) async throws -> ResponseBody<[OperationItem]> {
        let times = Int(req.headers.first(name: "times") ?? "0") ?? 0
        let list: [OperationItem] = operationsService.createList(times)
        return responseService.SuccessResponse(data: list, message:nil)
    }
    
    @Sendable func sendFibonacciSum(req: Request) async throws -> ResponseBody<OperationSumResponse> {
        let times = Int(req.parameters.get("number") ?? "0") ?? 0
        let sum = operationsService.fibonacciSum(times)
        let response = OperationSumResponse(sum: sum)
        return responseService.SuccessResponse(data: response, message:nil)
    }
    
    @Sendable func sendFibonacciList(req: Request) async throws -> ResponseBody<OperationListResponse> {
        let times = Int(req.parameters.get("number") ?? "0") ?? 0
        let list = operationsService.fibonacciList(times)
        let response = OperationListResponse(list: list)
        return responseService.SuccessResponse(data: response, message:nil)
    }
}

struct OperationTimesRequest: Content {
    var times: Int
}

struct OperationSumResponse: Content {
    var sum: UInt64
}

struct OperationListResponse: Content {
    var list: [UInt64]
}
