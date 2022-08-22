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
    var constant = ConstantValuesModel()
    var response: String = ""
    var names: [CharactersModel.Names] = []
    struct TestStruct: Decodable {
        var id: Int
        var name: String
        var update_at: String? // nullable
    }
    struct Users: Decodable {
        var users: [TestStruct]
    }
    struct UsersTest: Decodable {
        var users: Users
    }
    
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
    func getDBSuccess() {
        do {
            let testJson = response.data(using: .utf8)!
            let decodedData = try JSONDecoder().decode(Users.self, from: testJson)
            print(decodedData.users[0].name)
        } catch {
            print("fail")
        }
    }
    
    func getCharNames() -> [CharactersModel.Names] {

        let requestUrl = constant.apiDomain + "/db"
        AF // Alamofire
            .request(
                requestUrl,
                method: .get,
                headers: HTTPHeaders.default
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        self.response = String(data: data, encoding: .utf8)!
                        self.getDBSuccess()
                    case .failure(let error):
                        print("error:\(error)")
                }
            }

        names.append(CharactersModel.Names(id: "1", name: "済王"))
        names.append(CharactersModel.Names(id: "2", name: "ヴァンパイアレディ"))
        names.append(CharactersModel.Names(id: "3", name: "おたま"))
        names.append(CharactersModel.Names(id: "4", name: "ラベール"))
        names.append(CharactersModel.Names(id: "5", name: "タチアナ"))
        return names

    }
    
    func getCharacter() {
        let requestUrl = constant.apiDomain +  "/getCharacter"
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
    
    /*
     * testテーブルへのinsertお試し。
     * 試すこと。
     * ・POSTリクエストでHttpBodyでJSONパラメータを渡す
     * ・その内容を受け取ってnodejs側でテーブルにinsertする
     */
    func postAddTest() {
        // TODO 定数系のものはどこかに外出ししたい。
        let requestUrl = constant.apiDomain + "/addTest"
        let param: Parameters = [
            "name": "addTestFromSwift"
        ]
        let headers: HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"
        ]
        AF // Alamofire
            .request(
                requestUrl,
                method: .post,
                parameters: param,
                encoding: URLEncoding.httpBody,
                headers: headers
            )
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        print("response:\(String(data: data, encoding: .utf8)!)")
                    case .failure(let error):
                        print("error:\(error)")
                }
            }
    }
}
