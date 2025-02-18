import Vapor

struct AuthController: RouteCollection {
    
    func boot (routes: Vapor.RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        let jwtR = auth.grouped("jwt")
        jwtR.post("string", use: sendJwtToken)
        let hashR = auth.grouped("hash")
        hashR.post("string", use: sendHash)
        let codeR = auth.grouped("totp")
        codeR.post("string", use: sendTotpCode)
    }
    
    @Sendable func sendJwtToken(req: Request) async throws -> ResponseBody<AuthTokenResponse> {
        let request = try req.content.decode(AuthMessageRequest.self)
        let token = try await authService.createJwtToken(request.message)
        let response = AuthTokenResponse(token: token)
        return responseService.SuccessResponse(data: response, message:nil)
    }
    
    @Sendable func sendHash(req: Request) async throws -> ResponseBody<AuthHashResponse> {
        let request = try req.content.decode(AuthMessageRequest.self)
        let token = authService.createHash(request.message)
        let response = AuthHashResponse(hash: token)
        return responseService.SuccessResponse(data: response, message:nil)
    }
    
    @Sendable func sendTotpCode(req: Request) async throws -> ResponseBody<AuthCodeResponse> {
        let request = try req.content.decode(AuthMessageRequest.self)
        let token = authService.createTotp(request.message)
        let response = AuthCodeResponse(code: token)
        return responseService.SuccessResponse(data: response, message:nil)
    }
}

struct AuthMessageRequest: Content {
    var message: String
}

struct AuthTokenResponse: Content {
    var token: String
}

struct AuthHashResponse: Content {
    var hash: String
}

struct AuthCodeResponse: Content {
    var code: String
}
