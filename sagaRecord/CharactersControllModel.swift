//
//  CharactersControllModel.swift
//  sagaRecord
//
//  Created by 山本祐太 on 2022/08/20.
//

import Foundation
import Alamofire
import SystemConfiguration

// キャラクター情報を取得したり保存したり。
class CharacterControllModel{
    var response: String = ""
    
    func getName() -> String {
        do {
            let testJson = response.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(CharactersModel.Style.self, from: testJson)
            print(decodedData.skills[0].name)
            return decodedData.skills[0].name
        } catch {
            print("fail")
        }
        return "fail"
    }
    
    func getCharacter() {
        let requestUrl = "https://nodejs-api-dev1123.herokuapp.com/getCharacter"
        let param: Parameters = [
            "id": "1234"
        ]
        AF // Alamofire
            .request(
                requestUrl,
                method: .post,
                parameters: param,
                encoding: URLEncoding(destination: .queryString),
                headers: HTTPHeaders.default
            )
            .responseString{ response in
                if let text = response.value {
                    self.response = text
                }
                self.getName()
            }
    }
}
