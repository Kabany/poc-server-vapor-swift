import Vapor

struct MetaController: RouteCollection {
    
    func boot (routes: Vapor.RoutesBuilder) throws {
        let meta = routes.grouped("meta")
        meta.get("ping", use: ping)
        meta.get("health-check", use: healthCheck)
        meta.get("version", use: sendVersion)
    }
    
    @Sendable func ping(req: Request) async throws -> ResponseBody<String> {
        return responseService.SuccessResponse(data: nil, message:"pong!")
    }
    
    @Sendable func healthCheck(req: Request) async throws -> ResponseBody<String> {
        return responseService.SuccessResponse(data: nil, message:"ok!")
    }
    
    @Sendable func sendVersion(req: Request) async throws -> ResponseBody<String> {
        let v = Environment.get("VERSION")
        return responseService.SuccessResponse(data: nil, message:v)
    }
}
