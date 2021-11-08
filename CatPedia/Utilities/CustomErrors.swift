

import Foundation

enum CustomErrors: String,Error {
    
    case invalidURL          = "This url is invalid"
    case unableToComplete    = "Unable to connect start url session"
    case invalidResponse     = "Invalid response from the http call"
    case invalidDataResponse = "Invalid data response from call"
}
