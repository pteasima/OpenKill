import Foundation

import Foundation

public extension URLRequest {
  var cURL: String {
    let newLine = "\\\n"
    let method = "--request " + "\(self.httpMethod ?? "GET") \(newLine)"
    let url: String = "--url " + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
    
    var cURL = "curl "
    var header = ""
    var data: String = ""
    
    if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
      for (key,value) in httpHeaders {
        header += "--header " + "\'\(key): \(value)\' \(newLine)"
      }
    }
    
    if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
      data = "--data '\(bodyString)'"
    }
    
    cURL += method + url + header + data
    
    return cURL
  }
}
