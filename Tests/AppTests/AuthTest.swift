@testable import App
import XCTVapor
import Testing

final class AuthTest: XCTestCase {

    func testShouldCreateJwtFromString() async throws {
        let message = "Hello World!"
        let token = try await authService.createJwtToken(message)
        let opc1 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZXNzYWdlIjoiSGVsbG8gV29ybGQhIn0.q_OAmeTO_BJ0X1_6SMzGEat8qHvcMZ6LtPhLg8yKXR4"
        let opc2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSGVsbG8gV29ybGQhIn0.Qn62lWxZ5VZKovUbE8KTu_xGeDSp739uapAuBDK360Y"
        XCTAssert(opc1 == token || opc2 == token)
    }
    
    func testShouldCreateJwtThenDecodeAndMustMatch() async throws {
        let message = "Hello World!"
        let token = try await authService.createJwtToken(message)
        let decoded = try await authService.validateJwtToken(token)
        XCTAssertEqual(message, decoded)
        
        // From Ruby
        let decoded2 = try await authService.validateJwtToken("eyJhbGciOiJIUzI1NiJ9.eyJtZXNzYWdlIjoiSGVsbG8gV29ybGQhIn0.yX3llK_oxmp-qhJ7l-B0AL8wOlzCzsDHlw7xtCU2d4s")
        XCTAssertEqual(message, decoded2)
        // From JavaScript, C# & Java/Kotlin
        let decoded3 = try await authService.validateJwtToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZXNzYWdlIjoiSGVsbG8gV29ybGQhIn0.q_OAmeTO_BJ0X1_6SMzGEat8qHvcMZ6LtPhLg8yKXR4")
        XCTAssertEqual(message, decoded3)
    }
    
    func testShouldCreateHashWithSha512Algorithm() {
        let message = "Hello World!"
        let hash = authService.createHash(message)
        XCTAssertEqual("861844d6704e8573fec34d967e20bcfef3d424cf48be04e6dc08f2bd58c729743371015ead891cc3cf1c9d34b49264b510751b1ff9e537937bc46b5d6ff4ecc8", hash)
    }
    
    func testShouldCreateTotp() {
        let message = "JBSWY3DPEHPK3PXP"
        let token = authService.createTotp(message)
        let token2 = authService.createTotp(message)
        XCTAssertEqual(token, token2)
    }
}
