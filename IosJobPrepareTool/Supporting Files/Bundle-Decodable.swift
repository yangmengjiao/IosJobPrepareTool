//
//  Bundle-Decodable.swift
//  Project8
//
//  Created by mengjiao on 1/29/21.
//  Copyright © 2020 mengjiao yang. All rights reserved.


import Foundation

extension Bundle {
    // 用Generics，这样，对于所有的Json文件我们都可以decode
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        //让日期更的显示更加漂亮
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            //如果没有找到文件，马上crash app
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
