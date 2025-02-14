import Vapor

struct ResponseBody<T>: Content where T: Content {
    var data: T?
    var success: Bool
    var message: String?
}

struct ResponseService {
    func SuccessResponse<T>(data: T?, message:String?) -> ResponseBody<T> {
        return ResponseBody(data: data, success: true, message: message)
    }
}
