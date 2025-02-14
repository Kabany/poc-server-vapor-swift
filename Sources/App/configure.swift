import Vapor

let responseService = ResponseService()
let operationsService = OperationsService()

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    //try routes(app)
    
    try app.register(collection: MetaController())
}
