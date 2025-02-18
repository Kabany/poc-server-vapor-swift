import Vapor
import JWTKit
import SwiftOTP

struct AuthService {
    
    private let FIRST_JWT_SECRET = "ThisIsASuperSecret"
    
    func createJwtToken(_ text: String) async throws -> String {
        let keys = JWTKeyCollection()
        await keys.add(hmac: HMACKey(from: FIRST_JWT_SECRET), digestAlgorithm: .sha256)
        let payload = AuthJwtPayload(message: text)
        let jwt = try await keys.sign(payload)
        return jwt
    }
    
    func validateJwtToken(_ token: String) async throws -> String {
        let keys = JWTKeyCollection()
        await keys.add(hmac: HMACKey(from: FIRST_JWT_SECRET), digestAlgorithm: .sha256)
        let payload = try await keys.verify(token, as: AuthJwtPayload.self)
        return payload.message
    }
    
    func createHash(_ text: String) -> String {
        let data = Data(text.utf8)
        let hash = SHA512.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func createTotp(_ text: String) -> String {
        let key = base32DecodeToData(text)!
        let totp = TOTP(secret: key, digits: 8, timeInterval: 30, algorithm: .sha512)
        return totp?.generate(time: Date()) ?? ""
    }
}

struct AuthJwtPayload: JWTPayload {
    var message: String
    
    func verify(using algorithm: some JWTKit.JWTAlgorithm) async throws {
        
    }
}
