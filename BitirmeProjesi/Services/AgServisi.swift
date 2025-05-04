//
//  AgServisi.swift
//  BitirmeProjesi
//
//  Created by Şakir Yılmaz ÖĞÜT on 4.05.2025.
//

import Foundation

enum Sonuc<T> {
    case basarili(T)
    case hatali(Error)
}

enum AgHatasi: Error, LocalizedError, Equatable {
    case gecersizURL
    case veriYok
    case jsonCozumlemeHatasi
    case sunucuHatasi(String)
    
    var errorDescription: String? {
        switch self {
        case .gecersizURL:
            return "Geçersiz URL"
        case .veriYok:
            return "Veri alınamadı"
        case .jsonCozumlemeHatasi:
            return "Veri çözümlenirken hata oluştu"
        case .sunucuHatasi(let mesaj):
            return mesaj
        }
    }
    
    static func == (lhs: AgHatasi, rhs: AgHatasi) -> Bool {
        switch (lhs, rhs) {
        case (.gecersizURL, .gecersizURL):
            return true
        case (.veriYok, .veriYok):
            return true
        case (.jsonCozumlemeHatasi, .jsonCozumlemeHatasi):
            return true
        case (.sunucuHatasi(let a), .sunucuHatasi(let b)):
            return a == b
        default:
            return false
        }
    }
}

class AgServisi {
    
    static let shared = AgServisi()
    
    private init() {}
    
    private let baseURL = "http://kasimadalan.pe.hu/urunler"
    private let kullaniciAdi = "sakir_ogut" // Kendi kullanıcı adınızı buraya girin
    
    func tumUrunleriGetir(tamamlandi: @escaping (Sonuc<[Urun]>) -> Void) {
        let urlString = "\(baseURL)/tumUrunleriGetir.php"
        
        guard let url = URL(string: urlString) else {
            tamamlandi(.hatali(AgHatasi.gecersizURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { veri, yanit, hata in
            guard let veri = veri, hata == nil else {
                tamamlandi(.hatali(hata ?? AgHatasi.veriYok))
                return
            }
            
            do {
                let yanit = try JSONDecoder().decode(UrunYaniti.self, from: veri)
                tamamlandi(.basarili(yanit.urunler))
            } catch {
                print("JSON çözümleme hatası: \(error)")
                tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
            }
        }.resume()
    }
    
    func sepeteEkle(urun: Urun, adet: Int, tamamlandi: @escaping (Sonuc<Bool>) -> Void) {
        let urlString = "\(baseURL)/sepeteUrunEkle.php"
        
        guard let url = URL(string: urlString) else {
            tamamlandi(.hatali(AgHatasi.gecersizURL))
            return
        }
        
        var istek = URLRequest(url: url)
        istek.httpMethod = "POST"
        istek.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parametreler: [String: String] = [
            "ad": urun.ad,
            "resim": urun.resim,
            "kategori": urun.kategori,
            "fiyat": "\(urun.fiyat)",
            "marka": urun.marka,
            "siparisAdeti": "\(adet)",
            "kullaniciAdi": kullaniciAdi
        ]
        
        let govdeMetni = parametreler.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        istek.httpBody = govdeMetni.data(using: .utf8)
        
        URLSession.shared.dataTask(with: istek) { veri, yanit, hata in
            guard let veri = veri, hata == nil else {
                tamamlandi(.hatali(hata ?? AgHatasi.veriYok))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: veri) as? [String: Any],
                   let basari = json["success"] as? Int {
                    tamamlandi(.basarili(basari == 1))
                } else {
                    tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
                }
            } catch {
                tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
            }
        }.resume()
    }
    
    func sepettekiUrunleriGetir(tamamlandi: @escaping (Sonuc<[SepetOgesi]>) -> Void) {
        let urlString = "\(baseURL)/sepettekiUrunleriGetir.php"
        
        guard let url = URL(string: urlString) else {
            tamamlandi(.hatali(AgHatasi.gecersizURL))
            return
        }
        
        var istek = URLRequest(url: url)
        istek.httpMethod = "POST"
        istek.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parametreler = ["kullaniciAdi": kullaniciAdi]
        let govdeMetni = parametreler.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        istek.httpBody = govdeMetni.data(using: .utf8)
        
        URLSession.shared.dataTask(with: istek) { veri, yanit, hata in
            guard let veri = veri, hata == nil else {
                tamamlandi(.hatali(hata ?? AgHatasi.veriYok))
                return
            }
            
            do {
                let yanit = try JSONDecoder().decode(SepetYaniti.self, from: veri)
                if yanit.success == 1, let sepetOgeleri = yanit.urunler_sepeti {
                    tamamlandi(.basarili(sepetOgeleri))
                } else if yanit.success == 0 && yanit.message == "Sepetinizde ürün bulunmamaktadır." {
                    // Sepet boş durumunda boş dizi döndür, hata değil
                    tamamlandi(.basarili([]))
                } else {
                    let mesaj = yanit.message ?? "Bilinmeyen hata"
                    tamamlandi(.hatali(AgHatasi.sunucuHatasi(mesaj)))
                }
            } catch {
                print("JSON çözümleme hatası: \(error)")
                tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
            }
        }.resume()
    }
    
    func sepettenCikar(sepetId: Int, tamamlandi: @escaping (Sonuc<Bool>) -> Void) {
        let urlString = "\(baseURL)/sepettenUrunSil.php"
        
        guard let url = URL(string: urlString) else {
            tamamlandi(.hatali(AgHatasi.gecersizURL))
            return
        }
        
        var istek = URLRequest(url: url)
        istek.httpMethod = "POST"
        istek.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parametreler: [String: String] = [
            "sepetId": "\(sepetId)",
            "kullaniciAdi": kullaniciAdi
        ]
        
        let govdeMetni = parametreler.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        istek.httpBody = govdeMetni.data(using: .utf8)
        
        URLSession.shared.dataTask(with: istek) { veri, yanit, hata in
            guard let veri = veri, hata == nil else {
                tamamlandi(.hatali(hata ?? AgHatasi.veriYok))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: veri) as? [String: Any],
                   let basari = json["success"] as? Int {
                    tamamlandi(.basarili(basari == 1))
                } else {
                    tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
                }
            } catch {
                tamamlandi(.hatali(AgHatasi.jsonCozumlemeHatasi))
            }
        }.resume()
    }
} 
