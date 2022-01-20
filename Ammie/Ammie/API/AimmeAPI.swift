//
//  AimmeAPI.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation
import RxSwift

struct AimmeAPI {
    private static let scheme = "http"
    private static let host = "devapi.aimmeart.com"
    private static let basePath = "/aimme/api"
    
    enum Version: String {
        case v1 = "/v1"
        case v2 = "/v2"
    }
    
    enum Path: String {
        case artistNameList = "/artist-name-list"
        case auctionPeriod = "/auction-period"
        case detail = "/detail"
        case feedback = "feedback"
        case healthCheck = "/health-check"
        case recommendArtist = "/recommend-artist"
        case search = "/search"
        case sharingInfo = "sharing-info"
        case signup = "signup"
        case similarLotList = "similarLotList"
        case artWorks = "/artWorks"
        case getArtist = "getArtist"
        case topArtists = "/top-artists"
    }
    
    private static func getURL(_ path: AimmeAPI.Path, version: AimmeAPI.Version) -> URL? {
        var components = URLComponents()
        components.scheme = Self.scheme
        components.host = Self.host
        components.path = Self.basePath + version.rawValue + path.rawValue
        return components.url
    }
    
    static func artistNameList(_ artistName: String) -> Observable<[ArtistNameDTO]> {
        guard let url = Self.getURL(.artistNameList, version: .v1)?.absoluteString else { return .empty() }
        let parameters = ["artistName": artistName]
        
        return RequestBuilder<[ArtistNameDTO]>(method: .get, URLString: url, parameters: parameters, isBody: false).returnObservable()
    }
}
