//
//  Urun.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

struct Urun: Codable, Equatable {
    let id: Int
    let ad: String
    let resim: String
    let kategori: String
    let fiyat: Int
    let marka: String
    var favori: Bool? = false
    
    static func == (lhs: Urun, rhs: Urun) -> Bool {
        return lhs.id == rhs.id
    }
}

struct UrunYaniti: Codable {
    let urunler: [Urun]
    let success: Int
}
