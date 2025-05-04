//
//  SepetOgesi.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

struct SepetOgesi: Codable {
    let sepetId: Int
    let ad: String
    let resim: String
    let kategori: String
    let fiyat: Int
    let marka: String
    let siparisAdeti: Int
    let kullaniciAdi: String
}

struct SepetYaniti: Codable {
    let urunler_sepeti: [SepetOgesi]?
    let success: Int
    let message: String?
} 
