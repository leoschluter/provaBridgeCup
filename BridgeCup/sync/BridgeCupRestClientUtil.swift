//
// Created by Leonardo Schlüter on 18/04/18.
// Copyright (c) 2018 Bridge. All rights reserved.
//

import Foundation
import Alamofire

enum  BridgeCupRestClientUtil: URLRequestConvertible {


    case GET_GRUPOS(Int) // #2 --  /api/v1/edicoes/{ano}/grupos

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            default:
                return .get
            }
        }


        var params: ([String: Any]?) = try {
            switch self {
            case .GET_GRUPOS(let year):
                return genParametersGrupos(year: year)
            default:
                return nil
            }
        }()

        let url: URL = {
            var relativePath: String = ""
            switch self {
            case .GET_GRUPOS(let year):
                relativePath = "api/v1/edicoes/\(year)/grupos"
            }

            return URL(string: getServerBasePath() + relativePath)!
        }()


        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()

        return try encoding.encode(urlRequest, with: params)
    }

    private func genParametersGrupos(year: Int) -> [String: Any] {
        return ["ano": year]
    }

    private func getServerBasePath() -> String {
        return  "https://bridge-worldcup.herokuapp.com/"
    }
}
