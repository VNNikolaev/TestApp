//
//  NetworkError.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Foundation

public enum NetworkError: Error {
    case noInternetConnection
    case decodingError(DecodingError)
    case unknownError
}
