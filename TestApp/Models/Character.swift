//
//  Character.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Foundation

struct CharactersModel: Codable {
    let results: [Character]
}

struct Character: Codable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: String
  let origin: NameWithUrl
  let location: NameWithUrl
  let image: String
  let episode: [String]
  let url: String
  let created: String
}

struct NameWithUrl: Codable {
  let name: String
  let url: String
}
