//
//  ArtistNameDTO.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation

struct ArtistNameDTO: Decodable {
    let exposeOrder: Int
    let artistName: String
    let seq: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        exposeOrder = try values.decode(Int.self, forKey: .exposeOrder)
        artistName = try values.decode(String.self, forKey: .artistName)
        seq = try values.decode(Int.self, forKey: .seq)
    }
    
    private enum CodingKeys : String, CodingKey {
        case exposeOrder, artistName, seq
    }
}
