//
//  CommonDTO.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation

struct CommonDTO<T: Decodable>: Decodable {
    let responseCode: String
    let responseMessage: String
    let responseObject: T
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decode(String.self, forKey: .responseCode)
        responseMessage = try values.decode(String.self, forKey: .responseMessage)
        responseObject = try values.decode(T.self, forKey: .responseObject)
    }
    
    private enum CodingKeys : String, CodingKey {
        case responseCode, responseMessage, responseObject
    }
}
