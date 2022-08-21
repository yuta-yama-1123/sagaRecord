//
//  CharactersModel.swift
//  sagaRecord
//
//  Created by 山本祐太 on 2022/08/20.
//

class CharactersModel{
    struct Character: Decodable {
        var character_id: String
        var character_name: String

    }

    struct Skill: Decodable {
        var name: String
        var type: String
        var rank: Int
    }

    struct Style: Decodable {
        var base_character: Character
        var style_id: String
        var style_name: String
        var skills: [Skill]
    }
    
    // こういう定義って必要？
    struct Styles: Decodable {
        var styles: [Style]
    }
    
    // キャラ単位で一覧が欲しい時
    struct Characters: Decodable {
        var characters: [Character]
    }
    
    struct Names {
        var id: String
        var name: String
    }
}
